# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1] - 2025-08-27

### Added

- ✨ **Core Features**
  - `CSSnackbar` class with predefined snackbar types (success, error, warning, info)
  - `SnackbarType` enum with predefined colors and icons
  - `SnackbarConfig` class for global configuration management
- 🎨 **Predefined Snackbar Types**
  - `CSSnackbar.success()` - Green background with check circle icon
  - `CSSnackbar.error()` - Red background with error icon
  - `CSSnackbar.warning()` - Orange background with warning icon
  - `CSSnackbar.info()` - Blue background with info icon
- 🛠️ **Customization Options**
  - `CSSnackbar.custom()` - Fully customizable snackbar with custom colors and icons
  - `CSSnackbar.show()` - Advanced snackbar with all configuration options
  - Global default configuration via `updateDefaultConfig()`
- ⚙️ **Configuration Features**
  - Customizable duration (default: 3 seconds)
  - Show/hide close icon (default: true)
  - Show/hide type icons (default: true)
  - Configurable elevation (default: 6.0)
  - Custom margin and padding support
  - Adjustable border radius (default: 8.0)
  - Custom text styling
  - Floating or fixed behavior (default: floating)
  - Customizable dismiss direction (default: down)
  - onVisible callback support
- 🎯 **Action Support**
  - `SnackBarAction` support for all snackbar types
  - UNDO, RETRY, and custom action buttons
- 🔧 **Utility Methods**
  - `CSSnackbar.hide()` - Hide current snackbar
  - `CSSnackbar.clearAll()` - Clear all snackbars from queue
- 📱 **Responsive Design**
  - Text overflow handling with ellipsis
  - Maximum 3 lines for long messages
  - Proper icon and text spacing
- ♿ **Accessibility**
  - Built-in accessibility support via Flutter's SnackBar widget
  - Semantic labels and descriptions
  - Proper color contrast ratios
- 🧪 **Testing**
  - Comprehensive test suite with 15+ test cases
  - Widget tests for all snackbar types
  - Configuration and edge case testing
  - Test utilities for easy testing integration
- 📚 **Documentation**
  - Comprehensive README with examples
  - Inline code documentation with Turkish comments
  - API reference with parameter descriptions
  - Usage examples and best practices
- 🔧 **Development**
  - Minimum SDK requirement: Dart >=2.17.0 <4.0.0
  - Flutter >=2.0.0 support for broad compatibility
  - Null safety enabled
  - Flutter lints for code quality

### Technical Details

- **Dependencies**: Only Flutter SDK (no external dependencies)
- **Null Safety**: Full null safety support
- **Platform Support**: All platforms supported by Flutter
- **Performance**: Lightweight implementation with minimal overhead
- **Theming**: Respects Material Design principles

### Breaking Changes

- None (initial release)

### Migration Guide

- This is the initial release, no migration required

### Known Issues

- None reported

### Deprecated

- None

### Security

- No security concerns identified
