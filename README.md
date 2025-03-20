# no_dup_album

[![License](https://img.shields.io/badge/license-BSD--3--Clause-blue?style=flat-square)](LICENSE)
<!-- [![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/RequieMa/bk_tree/publish.yml)](https://github.com/RequieMa/bk_tree/actions/workflows/publish.yml) -->
<!-- [![Flutter Version](https://img.shields.io/badge/Flutter-3.22%2B-blue)](https://flutter.dev)  
[![GitHub Stars](https://img.shields.io/github/stars/yourusername/photo_manager?style=social)](https://github.com/yourusername/photo_manager)   -->

A cross-platform Flutter app for managing photo albums with **AI-powered duplicate detection** and **visual comparison tools**.  

<!-- <img src="screenshots/demo.gif" width="300" alt="App Demo">   -->

## 🚀 Getting Started

### Prerequisites  
- Flutter 3.22+  
- Dart 3.6+  
- Android SDK 34+ / Xcode 15+  

### Installation  
```bash  
git clone https://github.com/RequieMa/no_dup_album.git
cd no_dup_album  
flutter pub get  
```

### Running the App
```bash
# iOS  
flutter run -d iPhone  
```
```bash
# Android  
flutter run -d Pixel_6  
```

## 🛠 Project Structure

```bash
lib/  
├── main.dart          # App entry  
├── features/          # Core modules  
│   ├── gallery/       # Album browsing  
│   ├── duplicates/    # Duplicate detection  
│   └── compare/       # Comparison interface  
├── core/              # Business logic  
│   ├── providers/     # State management (Riverpod)  
│   ├── services/      # Image hashing & BK-Tree logic  
│   └── utils/         # Helper classes  
└── generated/         # Auto-generated files  
```

## 📸 Screenshots
<!-- | Gallery View	| Duplicates	| Comparison
| <img src="screenshots/1.jpg" width="200">	| <img src="screenshots/2.jpg" width="200">	| <img src="screenshots/3.jpg" width="200"> | -->

## 🤝 Contributing

### Workflow
1. Fork repository
2. Create feature branch:
   ```bash
   git checkout -b feat/your-feature
   ```
3. Follow [Conventional Commits](https://www.conventionalcommits.org):
   ```bash
   git commit -m "feat: add new validation method"
   ```

### Code Style
Follow the **Effective Dart** and `analysis_options.yaml`

## 📚 Documentation

<!-- | Resource         | Link                                   |
|------------------|----------------------------------------|
| API Reference    | [View Docs](https://pub.dev/documentation/your_package) |
| Example Project  | [/example](example/)                   |
| Tutorial Series  | [YouTube Playlist](https://youtube.com/your-channel) | -->

## 📜 License

BSD 3-Clause "New" or "Revised" License © 2025 RequieMa

Full text at [LICENSE](LICENSE)

## 🚧 Maintenance Status
Basic functionalities are under development. 

Please report issues via [GitHub Issues](https://github.com/RequieMa/no_dup_album/issues)