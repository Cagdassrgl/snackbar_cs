<!--
# Snackbar CS

A customizable Flutter snackbar package with predefined styles for success, error, warning, and info messages. This package provides an easy-to-use API for displaying beautiful and consistent snackbars throughout your Flutter application.

## Features

✅ **Predefined Types**: Success, Error, Warning, and Info snackbars with appropriate colors and icons
✅ **Custom Snackbars**: Create completely custom snackbars with your own colors and icons
✅ **Configurable**: Global configuration options for consistent styling
✅ **Action Support**: Add action buttons to snackbars
✅ **Icon Control**: Show/hide icons for each snackbar
✅ **Multiple Behaviors**: Floating or fixed snackbar behavior
✅ **Duration Control**: Customize display duration for each snackbar
✅ **Accessibility**: Built with Flutter's accessibility best practices
✅ **Null Safety**: Full null safety support
✅ **Low SDK Requirement**: Minimum SDK requirement for broader compatibility

## Screenshots

| Success | Error | Warning | Info |
|---------|-------|---------|------|
| ![Success](https://via.placeholder.com/200x50/4CAF50/white?text=✓+Success) | ![Error](https://via.placeholder.com/200x50/F44336/white?text=✗+Error) | ![Warning](https://via.placeholder.com/200x50/FF9800/white?text=⚠+Warning) | ![Info](https://via.placeholder.com/200x50/2196F3/white?text=ℹ+Info) |

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  snackbar_cs: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

Import the package:

```dart
import 'package:snackbar_cs/snackbar_cs.dart';
```

#### Success Snackbar
```dart
CSSnackbar.success(context, 'Operation completed successfully!');
```

#### Error Snackbar
```dart
CSSnackbar.error(context, 'Something went wrong!');
```

#### Warning Snackbar
```dart
CSSnackbar.warning(context, 'Please check your input!');
```

#### Info Snackbar
```dart
CSSnackbar.info(context, 'Here is some useful information.');
```

### Advanced Usage

#### Custom Duration
```dart
CSSnackbar.success(
  context,
  'Success message',
  duration: Duration(seconds: 5),
);
```

#### Without Icon
```dart
CSSnackbar.error(
  context,
  'Error message',
  showIcon: false,
);
```

#### With Action Button
```dart
CSSnackbar.warning(
  context,
  'Are you sure you want to delete this item?',
  action: SnackBarAction(
    label: 'UNDO',
    onPressed: () {
      // Handle undo action
    },
  ),
);
```

#### Custom Snackbar
```dart
CSSnackbar.custom(
  context,
  message: 'Custom styled message',
  backgroundColor: Colors.purple,
  textColor: Colors.white,
  icon: Icons.star,
  duration: Duration(seconds: 4),
);
```

#### With Callback
```dart
CSSnackbar.info(
  context,
  'Processing your request...',
  onVisible: () {
    print('Snackbar is now visible');
  },
);
```

### Global Configuration

You can set global defaults for all snackbars:

```dart
CSSnackbar.updateDefaultConfig(
  SnackbarConfig(
    duration: Duration(seconds: 4),
    showCloseIcon: true,
    showIcon: true,
    elevation: 8.0,
    borderRadius: 12.0,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(16),
  ),
);
```

### Utility Methods

#### Hide Current Snackbar
```dart
CSSnackbar.hide(context);
```

#### Clear All Snackbars
```dart
CSSnackbar.clearAll(context);
```

## API Reference

### CSSnackbar Class

#### Static Methods

| Method | Description | Parameters |
|--------|-------------|------------|
| `success()` | Shows a success snackbar with green background | `context`, `message`, optional: `duration`, `textStyle`, `showIcon`, `onVisible`, `action` |
| `error()` | Shows an error snackbar with red background | `context`, `message`, optional: `duration`, `textStyle`, `showIcon`, `onVisible`, `action` |
| `warning()` | Shows a warning snackbar with orange background | `context`, `message`, optional: `duration`, `textStyle`, `showIcon`, `onVisible`, `action` |
| `info()` | Shows an info snackbar with blue background | `context`, `message`, optional: `duration`, `textStyle`, `showIcon`, `onVisible`, `action` |
| `custom()` | Shows a custom snackbar with specified styling | `context`, `message`, `backgroundColor`, optional: multiple styling options |
| `show()` | Shows a fully customizable snackbar | `context`, `message`, optional: all styling and behavior options |
| `hide()` | Hides the current snackbar | `context` |
| `clearAll()` | Clears all snackbars from the queue | `context` |
| `updateDefaultConfig()` | Updates global default configuration | `SnackbarConfig` |

### SnackbarType Enum

| Type | Color | Icon |
|------|-------|------|
| `success` | Green (#4CAF50) | `Icons.check_circle` |
| `error` | Red (#F44336) | `Icons.error` |
| `warning` | Orange (#FF9800) | `Icons.warning` |
| `info` | Blue (#2196F3) | `Icons.info` |

### SnackbarConfig Class

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `duration` | `Duration` | `Duration(seconds: 3)` | How long the snackbar is displayed |
| `showCloseIcon` | `bool` | `true` | Whether to show close icon |
| `showIcon` | `bool` | `true` | Whether to show type icon |
| `elevation` | `double` | `6.0` | Elevation of the snackbar |
| `margin` | `EdgeInsetsGeometry?` | `null` | Margin around snackbar |
| `padding` | `EdgeInsetsGeometry?` | `null` | Padding inside snackbar |
| `borderRadius` | `double` | `8.0` | Border radius of snackbar |
| `textStyle` | `TextStyle?` | `null` | Custom text style |
| `behavior` | `SnackBarBehavior` | `SnackBarBehavior.floating` | Floating or fixed behavior |
| `dismissDirection` | `DismissDirection` | `DismissDirection.down` | Swipe direction to dismiss |
| `onVisible` | `VoidCallback?` | `null` | Callback when snackbar becomes visible |

## Examples

### Example 1: Form Validation
```dart
void validateForm() {
  if (emailController.text.isEmpty) {
    CSSnackbar.warning(context, 'Please enter your email address');
    return;
  }

  if (!isValidEmail(emailController.text)) {
    CSSnackbar.error(context, 'Please enter a valid email address');
    return;
  }

  CSSnackbar.success(context, 'Form submitted successfully!');
}
```

### Example 2: Network Operations
```dart
Future<void> saveData() async {
  CSSnackbar.info(context, 'Saving data...');

  try {
    await apiService.saveData(data);
    CSSnackbar.success(context, 'Data saved successfully!');
  } catch (e) {
    CSSnackbar.error(
      context,
      'Failed to save data: ${e.toString()}',
      action: SnackBarAction(
        label: 'RETRY',
        onPressed: () => saveData(),
      ),
    );
  }
}
```

### Example 3: Delete Confirmation
```dart
void showDeleteConfirmation() {
  CSSnackbar.warning(
    context,
    'Item will be deleted permanently',
    duration: Duration(seconds: 5),
    action: SnackBarAction(
      label: 'UNDO',
      onPressed: () {
        // Cancel deletion
        CSSnackbar.success(context, 'Deletion cancelled');
      },
    ),
  );

  // Schedule deletion after snackbar duration
  Timer(Duration(seconds: 5), () {
    deleteItem();
  });
}
```

## Requirements

- **Flutter**: >= 2.0.0
- **Dart**: >= 2.17.0 < 4.0.0

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup

1. Clone the repository
```bash
git clone https://github.com/yourusername/snackbar_cs.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Run tests
```bash
flutter test
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.

## Support

If you like this package, please give it a ⭐ on [GitHub](https://github.com/yourusername/snackbar_cs) and consider [buying me a coffee](https://www.buymeacoffee.com/yourusername).

For issues and feature requests, please visit the [GitHub Issues](https://github.com/yourusername/snackbar_cs/issues) page.
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
