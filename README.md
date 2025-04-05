<p align="center">   
    <a href="https://github.com/youngcet/app_flow_cli"><img src="https://img.shields.io/github/stars/youngcet/app_flow_cli?style=social" alt="Repo stars"></a>
    <a href="https://github.com/youngcet/app_flow_cli/commits/master"><img src="https://img.shields.io/github/last-commit/youngcet/app_flow_cli/master?logo=git" alt="Last Commit"></a>
    <a href="https://github.com/youngcet/app_flow_cli/pulls"><img src="https://img.shields.io/github/issues-pr/youngcet/app_flow_cli" alt="Repo PRs"></a>
    <a href="https://github.com/youngcet/app_flow_cli/issues?q=is%3Aissue+is%3Aopen"><img src="https://img.shields.io/github/issues/youngcet/app_flow_cli" alt="Repo issues"></a>
    <a href="https://github.com/youngcet/app_flow_cli/graphs/contributors"><img src="https://badgen.net/github/contributors/youngcet/app_flow_cli" alt="Contributors"></a>
    <a href="https://github.com/youngcet/app_flow_cli/blob/master/LICENSE"><img src="https://badgen.net/github/license/youngcet/app_flow_cli" alt="License"></a>
    <br>       
    <a href="https://app.codecov.io/gh/youngcet/app_flow_cli"><img src="https://img.shields.io/codecov/c/github/youngcet/app_flow_cli?logo=codecov&logoColor=white" alt="Coverage Status"></a>
</p>

# 🧱 AppFlow CLI – Flutter Project Structure Generator

AppFlow CLI is a command-line tool built with Dart to help Flutter developers generate and manage scalable project structures using a simple configuration file.

It's perfect for bootstrapping projects with a clean, modular architecture — ideal for solo devs and teams alike.

[![Pub Version](https://img.shields.io/pub/v/app_flow_cli)](https://pub.dev/packages/app_flow_cli)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/youngcet/app_flow_cli/blob/main/LICENSE)
<a href="https://pub.dev/packages/app_flow_cli"><img src="https://badgen.net/pub/points/app_flow_cli" alt="Pub points"></a>
<a href="https://pub.dev/packages/app_flow_cli"><img src="https://badgen.net/pub/likes/app_flow_cli" alt="Pub Likes"></a>
<a href="https://pub.dev/packages/app_flow_cli"><img src="https://badgen.net/pub/popularity/app_flow_cli" alt="Pub popularity"></a>

---

<p align="center">
    <h2>Using the default project structure</h2>
  <img src="https://github.com/youngcet/app_flow_cli/blob/main/doc/defaultConfig.gif?raw=true" width="750px">
  <h2>Using your own project structure config</h2>
  <img src="https://github.com/youngcet/app_flow_cli/blob/main/doc/customConfig.gif?raw=true" width="750px" style="margin-left:10px">
</p>

## ✨ Features

- 🚀 Generate folder/file structures using YAML config
- ➕ Add new modules or features on demand
- ♻️ Overwrite existing files with a flag
- 🧹 Clean/remove previously generated structures

---

## 📦 Installation
```dart
dart pub global activate app_flow_cli
```

Or install a specific version using:

```dart
dart pub global activate app_flow_cli <version>
```

If you haven't already, you might need to [set up your path](https://dart.dev/tools/pub/cmd/pub-global#running-a-script-from-your-path).

When that is not possible (eg: CI environments), run very_good commands via:
```dart
dart pub global run app_flow_cli [options] // e.g dart pub global run app_flow_cli --add structure
```

# Usage
```dart
app_flow_cli [options]
```

## Options

| Option            | Description                                   |
|-------------------|-----------------------------------------------|
| `--config <path>` | Path to the YAML/JSON config file             |
| `--add <module>`  | Add a module/feature to the structure         |
| `--overwrite`     | Overwrite existing files                      |
| `--clean`         | Remove previously generated structure         |
| `--help`          | Display usage information                     |

# Example
Using the default structure.
```dart
// generate the default structure
app_flow_cli --add structure
```

<p align="left">
  <img src="https://github.com/youngcet/app_flow_cli/blob/main/doc/structure.png?raw=true" style="width:700px">
</p>

Removing the default structure.
```dart
app_flow_cli --clean
```

Using your own structure.
```dart
// pass your own config structure to generate
app_flow_cli --add structure --config app_flow_cli.yaml

// pass your config to remove the folders & files
app_flow_cli --clean --config app_flow_cli.yaml
```

## Default Structure

When using the default structure, three key files will be generated:

1. **`home.dart`**: This file serves as the entry point for your app's main screen. It will typically display the primary content for your app.
2. **`splash.dart`**: A splash screen that is shown when the app is launched. It provides a smooth transition into the app.
3. **`router.dart`**: This file manages routing setup, defining routes and handling navigation across the app.
4. **`main.dart`**: This is the main file. This file is overriden only if the `--overwrite` option is set when you run `app_flow_cli --add structure`. For example, `app_flow_cli --add structure --overwrite`.

These files are automatically generated when you run `app_flow_cli --add structure` and provide a solid starting point for your app's UI and navigation flow.

# Configuration Example (app_flow_cli.yaml)
A basic config:

```yaml
folders:
  # Main application code
  - lib/src/app/             # App-wide configuration
  - lib/src/app/config/      # Environment configurations (dev, staging, prod)"
  - lib/src/app/constants/   # App constants (strings, routes, enums)"
  - lib/src/app/di/          # Dependency injection setup"
  - lib/src/app/theme/       # App theme data"
  
  # Core functionality
  - lib/src/core/            # Core functionality"
  - lib/src/core/errors/     # Error handling classes"
  - lib/src/core/network/    # Network clients and interceptors"
  - lib/src/core/utils/      # Utilities (validators, extensions, formatters)"
  - lib/src/core/widgets/    # Reusable app-wide widgets"
  
  # Feature modules
  - lib/src/features/auth/        # Example feature: Authentication"
  - lib/src/features/auth/data/    # Data layer"
  - lib/src/features/auth/data/datasources/  # Local/remote data sources"
  - lib/src/features/auth/data/models/       # Data transfer objects"
  - lib/src/features/auth/data/repositories/ # Repository implementations"
  - lib/src/features/auth/domain/  # Domain layer"
  - lib/src/features/auth/domain/entities/     # Business logic entities"
  - lib/src/features/auth/domain/repositories/ # Repository interfaces"
  - lib/src/features/auth/domain/usecases/     # Business logic use cases"
  - lib/src/features/auth/presentation/    # UI layer"
  - lib/src/features/auth/presentation/bloc/        # State management"
  - lib/src/features/auth/presentation/pages/       # Full screens/views"
  - lib/src/features/auth/presentation/widgets/     # Feature-specific widgets"
  
  # Routing configuration
  - lib/src/routes/          # Routing configuration"
  
  # Localization
  - lib/l10n/                # Localization files"
  
  # Static files
  - assets/icons/               # App icons"
  - assets/images/              # Images"
  - assets/fonts/               # Custom fonts"
  - assets/translations/        # JSON translation files"
  
  # Testing
  - test/                    # Test files"
  - test/features/            # Feature tests"
  - test/mock/                # Mock classes"
  - test/test_helpers/        # Testing utilities"
  
  # Other
  - integration_test/        # Integration tests"
  - scripts/                 # Build/deployment scripts"

files:   
  "lib/src/routes/app_pages.dart": |
    // Route definitions
    class AppPages {
      static const initial = '/';
    }
    
  "lib/src/routes/app_router.dart": |
    // Router implementation
    class AppRouter {}
    
  "lib/l10n/app_en.arb": |
    // Localization files
    {
      "appTitle": "My App",
      "@appTitle": {
        "description": "The title of the application"
      }
    }
    
  "lib/firebase_options.dart": |
    // Firebase configuration (if used)
    class FirebaseOptions {}
        
  ".gitignore": |
    # Version control ignore
    /build/
    
  "README.md": |
    # Project documentation
    ## My Flutter App
    A developer community application.
```

## License

This package is available under the [MIT License](https://github.com/youngcet/app_flow_cli/blob/main/LICENSE).