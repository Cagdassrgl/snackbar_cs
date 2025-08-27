// ignore_for_file: inference_failure_on_instance_creation

/// A customizable Flutter snackbar package with predefined styles
/// for success, error, warning, and info messages.
library snackbar_cs;

import 'package:flutter/material.dart';

/// Enum for different snackbar types with predefined colors and icons
enum SnackbarType {
  /// Success type with green color and check icon
  success(Color(0xFF4CAF50), Icons.check_circle),

  /// Error type with red color and error icon
  error(Color(0xFFF44336), Icons.error),

  /// Warning type with orange color and warning icon
  warning(Color(0xFFFF9800), Icons.warning),

  /// Info type with blue color and info icon
  info(Color(0xFF2196F3), Icons.info);

  const SnackbarType(this.color, this.icon);

  /// Default background color for this snackbar type
  final Color color;

  /// Default icon for this snackbar type
  final IconData icon;
}

/// Configuration class for snackbar appearance and behavior
class SnackbarConfig {
  /// Creates a snackbar configuration
  const SnackbarConfig({
    this.duration = const Duration(seconds: 3),
    this.showCloseIcon = true,
    this.showIcon = true,
    this.elevation = 6.0,
    this.margin,
    this.padding,
    this.borderRadius = 8.0,
    this.textStyle,
    this.behavior = SnackBarBehavior.floating,
    this.dismissDirection = DismissDirection.down,
    this.onVisible,
  });

  /// Duration the snackbar will be displayed
  final Duration duration;

  /// Whether to show close icon
  final bool showCloseIcon;

  /// Whether to show type icon
  final bool showIcon;

  /// Elevation of the snackbar
  final double elevation;

  /// Margin around the snackbar
  final EdgeInsetsGeometry? margin;

  /// Padding inside the snackbar
  final EdgeInsetsGeometry? padding;

  /// Border radius of the snackbar
  final double borderRadius;

  /// Text style for the content
  final TextStyle? textStyle;

  /// Behavior of the snackbar (floating or fixed)
  final SnackBarBehavior behavior;

  /// Direction to dismiss the snackbar
  final DismissDirection dismissDirection;

  /// Callback when snackbar becomes visible
  final VoidCallback? onVisible;
}

/// Custom snackbar component with enhanced features
class CSSnackbar {
  /// Default configuration for all snackbars
  static SnackbarConfig defaultConfig = const SnackbarConfig();

  /// Show a customizable snackbar with full control over appearance
  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
    Color? backgroundColor,
    Color? textColor,
    TextStyle? textStyle,
    Duration? duration,
    bool? showCloseIcon,
    bool? showIcon,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? borderRadius,
    SnackBarBehavior? behavior,
    DismissDirection? dismissDirection,
    VoidCallback? onVisible,
    SnackBarAction? action,
  }) {
    // Hide any current snackbar before showing new one
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Determine final configuration values
    final config = defaultConfig;
    final finalDuration = duration ?? config.duration;
    final finalShowCloseIcon = showCloseIcon ?? config.showCloseIcon;
    final finalShowIcon = showIcon ?? config.showIcon;
    final finalElevation = elevation ?? config.elevation;
    final finalMargin = margin ?? config.margin;
    final finalPadding = padding ?? config.padding;
    final finalBorderRadius = borderRadius ?? config.borderRadius;
    final finalBehavior = behavior ?? config.behavior;
    final finalDismissDirection = dismissDirection ?? config.dismissDirection;

    // Default text style with fallback
    final defaultTextStyle = TextStyle(
      color: textColor ?? Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
    final finalTextStyle = textStyle ?? config.textStyle ?? defaultTextStyle;

    // Build content with optional icon
    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (finalShowIcon) ...[
          Icon(
            type.icon,
            color: textColor ?? Colors.white,
            size: 20,
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            message,
            style: finalTextStyle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

    // Show the snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: content,
        backgroundColor: backgroundColor ?? type.color,
        duration: finalDuration,
        showCloseIcon: finalShowCloseIcon,
        elevation: finalElevation,
        margin: finalMargin,
        padding: finalPadding,
        behavior: finalBehavior,
        dismissDirection: finalDismissDirection,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(finalBorderRadius),
        ),
        action: action,
        onVisible: onVisible,
      ),
    );
  }

  /// Show success message with green background and check icon
  static void success(
    BuildContext context,
    String message, {
    Duration? duration,
    TextStyle? textStyle,
    bool? showIcon,
    VoidCallback? onVisible,
    SnackBarAction? action,
  }) {
    show(
      context,
      message: message,
      type: SnackbarType.success,
      duration: duration,
      textStyle: textStyle,
      showIcon: showIcon,
      onVisible: onVisible,
      action: action,
    );
  }

  /// Show error message with red background and error icon
  static void error(
    BuildContext context,
    String message, {
    Duration? duration,
    TextStyle? textStyle,
    bool? showIcon,
    VoidCallback? onVisible,
    SnackBarAction? action,
  }) {
    show(
      context,
      message: message,
      type: SnackbarType.error,
      duration: duration,
      textStyle: textStyle,
      showIcon: showIcon,
      onVisible: onVisible,
      action: action,
    );
  }

  /// Show warning message with orange background and warning icon
  static void warning(
    BuildContext context,
    String message, {
    Duration? duration,
    TextStyle? textStyle,
    bool? showIcon,
    VoidCallback? onVisible,
    SnackBarAction? action,
  }) {
    show(
      context,
      message: message,
      type: SnackbarType.warning,
      duration: duration,
      textStyle: textStyle,
      showIcon: showIcon,
      onVisible: onVisible,
      action: action,
    );
  }

  /// Show info message with blue background and info icon
  static void info(
    BuildContext context,
    String message, {
    Duration? duration,
    TextStyle? textStyle,
    bool? showIcon,
    VoidCallback? onVisible,
    SnackBarAction? action,
  }) {
    show(
      context,
      message: message,
      type: SnackbarType.info,
      duration: duration,
      textStyle: textStyle,
      showIcon: showIcon,
      onVisible: onVisible,
      action: action,
    );
  }

  /// Show snackbar with custom colors and no predefined type
  static void custom(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    Color textColor = Colors.white,
    IconData? icon,
    Duration? duration,
    TextStyle? textStyle,
    bool? showCloseIcon,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? borderRadius,
    SnackBarBehavior? behavior,
    DismissDirection? dismissDirection,
    VoidCallback? onVisible,
    SnackBarAction? action,
  }) {
    // Hide any current snackbar before showing new one
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Build content with optional custom icon
    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            color: textColor,
            size: 20,
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            message,
            style: textStyle ??
                TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

    // Use default config values if not provided
    final config = defaultConfig;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: content,
        backgroundColor: backgroundColor,
        duration: duration ?? config.duration,
        showCloseIcon: showCloseIcon ?? config.showCloseIcon,
        elevation: elevation ?? config.elevation,
        margin: margin ?? config.margin,
        padding: padding ?? config.padding,
        behavior: behavior ?? config.behavior,
        dismissDirection: dismissDirection ?? config.dismissDirection,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? config.borderRadius),
        ),
        action: action,
        onVisible: onVisible,
      ),
    );
  }

  /// Update the default configuration for all snackbars
  static void updateDefaultConfig(SnackbarConfig config) {
    defaultConfig = config;
  }

  /// Hide current snackbar
  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  /// Clear all snackbars
  static void clearAll(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}
