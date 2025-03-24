import "dart:typed_data";
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '相册管理器',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PhotoPermissionHandler(), // 直接作为首页
    );
  }
}

class PhotoPermissionHandler extends StatefulWidget {
  @override
  _PhotoPermissionHandlerState createState() => _PhotoPermissionHandlerState();
}

class _PhotoPermissionHandlerState extends State<PhotoPermissionHandler> {
  List<AssetEntity> _photos = [];
  PermissionState? _currentState;

  Future<void> _checkPermissions() async {
    // if (Platform.isAndroid) {
    //   await requestAndroidPermissions();
    // }
    
    final ps = await PhotoManager.requestPermissionExtend();
    setState(() => _currentState = ps);

    if (ps.isAuth) {
      _loadAllPhotos();
    } 
    // else if (ps.hasAccess) {
    //   if (Platform.isIOS) {
    //     _handleLimitedAccessIOS();
    //   } else {
    //     _loadAllPhotos();
    //   }
    // } else {
    //   _showDeniedUI();
    // }
  }

  Future<void> _loadAllPhotos() async {
    try {
      // 获取所有相册路径（过滤仅图片类型）
      final paths = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(minWidth: 100, minHeight: 100),
          ),
        ),
      );
      if (paths.isEmpty) {
        print('No photo albums found');
        return;
      }

      // 选择第一个相册（通常为"所有照片"）
      final selectedAlbum = paths.first;

      // 分页加载相册内所有图片（每页100张）
      final entities = await selectedAlbum.getAssetListPaged(
        page: 0,
        size: 1000, // 一次性加载全部，建议分页优化
      );

      setState(() {
        _photos = entities;
      });
    } catch (error) {
      print('Failed to load photos: $error');
    }
  }

  Widget _buildBody() {
    if (_currentState == null) {
      return Center(child: CircularProgressIndicator());
    }
    
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (ctx, index) => AssetThumbnail(_photos[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('相册'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => PhotoManager.openSetting(),
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _checkPermissions,
        tooltip: '刷新权限',
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class AssetThumbnail extends StatelessWidget {
  final AssetEntity asset;
  final double size;
  
  const AssetThumbnail(
    this.asset, {
    Key? key,
    this.size = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _getThumbnail(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(
            snapshot.data!,
            fit: BoxFit.cover,
            width: size,
            height: size,
          );
        }
        return _buildPlaceholder();
      },
    );
  }

  Future<Uint8List?> _getThumbnail() async {
    try {
      return await asset.thumbnailDataWithSize(
        const ThumbnailSize.square(200), // 控制缩略图尺寸
      );
    } catch (e) {
      print('加载缩略图失败: $e');
      return null;
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[200],
      width: size,
      height: size,
      child: const Icon(Icons.photo, size: 40),
    );
  }
}