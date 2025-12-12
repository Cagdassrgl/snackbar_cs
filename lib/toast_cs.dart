// ignore_for_file: inference_failure_on_instance_creation

/// A customizable Flutter toast package with flexible positioning
/// and predefined styles for success, error, warning, and info messages.
library toast_cs;

import 'dart:async';
import 'package:flutter/material.dart';

/// Toast position options
enum ToastPosition {
  /// Top left corner
  topLeft,

  /// Top center
  topCenter,

  /// Top right corner
  topRight,

  /// Center left
  centerLeft,

  /// Center of screen
  center,

  /// Center right
  centerRight,

  /// Bottom left corner
  bottomLeft,

  /// Bottom center
  bottomCenter,

  /// Bottom right corner
  bottomRight,
}

/// Toast animation type
enum ToastAnimation {
  /// Fade in/out
  fade,

  /// Slide from position
  slide,

  /// Scale up/down
  scale,

  /// Slide and fade combined
  slideAndFade,
}

/// Toast type with predefined colors and icons
enum ToastType {
  /// Success type with green color and check icon
  success(Color(0xFF4CAF50), Icons.check_circle),

  /// Error type with red color and error icon
  error(Color(0xFFF44336), Icons.error),

  /// Warning type with orange color and warning icon
  warning(Color(0xFFFF9800), Icons.warning),

  /// Info type with blue color and info icon
  info(Color(0xFF2196F3), Icons.info);

  const ToastType(this.color, this.icon);

  /// Default background color for this toast type
  final Color color;

  /// Default icon for this toast type
  final IconData icon;
}

/// Configuration class for toast appearance and behavior
class ToastConfig {
  const ToastConfig({
    this.duration = const Duration(seconds: 3),
    this.position = ToastPosition.topRight,
    this.animation = ToastAnimation.slideAndFade,
    this.showIcon = true,
    this.showCloseButton = false,
    this.elevation = 6.0,
    this.borderRadius = 12.0,
    this.textStyle,
    this.maxWidth = 350.0,
    this.margin = const EdgeInsets.all(16.0),
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  });

  /// Duration the toast will be displayed
  final Duration duration;

  /// Position where toast will appear
  final ToastPosition position;

  /// Animation type for toast
  final ToastAnimation animation;

  /// Whether to show type icon
  final bool showIcon;

  /// Whether to show close button
  final bool showCloseButton;

  /// Elevation of the toast
  final double elevation;

  /// Border radius of the toast
  final double borderRadius;

  /// Text style for the content
  final TextStyle? textStyle;

  /// Maximum width of the toast
  final double maxWidth;

  /// Margin around the toast
  final EdgeInsetsGeometry margin;

  /// Padding inside the toast
  final EdgeInsetsGeometry padding;
}

/// Toast manager for displaying toast messages
class CSToast {
  static ToastConfig defaultConfig = const ToastConfig();
  static final List<OverlayEntry> _activeToasts = [];

  /// Show a toast with full customization
  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.info,
    ToastPosition? position,
    ToastAnimation? animation,
    Duration? duration,
    Color? backgroundColor,
    Color? textColor,
    TextStyle? textStyle,
    bool? showIcon,
    bool? showCloseButton,
    double? elevation,
    double? borderRadius,
    double? maxWidth,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
    VoidCallback? onDismiss,
  }) {
    final config = defaultConfig;
    final finalPosition = position ?? config.position;
    final finalAnimation = animation ?? config.animation;
    final finalDuration = duration ?? config.duration;
    final finalShowIcon = showIcon ?? config.showIcon;
    final finalShowCloseButton = showCloseButton ?? config.showCloseButton;
    final finalElevation = elevation ?? config.elevation;
    final finalBorderRadius = borderRadius ?? config.borderRadius;
    final finalMaxWidth = maxWidth ?? config.maxWidth;
    final finalMargin = margin ?? config.margin;
    final finalPadding = padding ?? config.padding;

    final defaultTextStyle = TextStyle(
      color: textColor ?? Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
    final finalTextStyle = textStyle ?? config.textStyle ?? defaultTextStyle;

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        type: type,
        position: finalPosition,
        animation: finalAnimation,
        backgroundColor: backgroundColor ?? type.color,
        textColor: textColor ?? Colors.white,
        textStyle: finalTextStyle,
        showIcon: finalShowIcon,
        showCloseButton: finalShowCloseButton,
        elevation: finalElevation,
        borderRadius: finalBorderRadius,
        maxWidth: finalMaxWidth,
        margin: finalMargin,
        padding: finalPadding,
        onTap: onTap,
        onDismiss: () {
          overlayEntry.remove();
          _activeToasts.remove(overlayEntry);
          onDismiss?.call();
        },
      ),
    );

    _activeToasts.add(overlayEntry);
    overlay.insert(overlayEntry);

    // Auto dismiss after duration
    Timer(finalDuration, () {
      if (_activeToasts.contains(overlayEntry)) {
        overlayEntry.remove();
        _activeToasts.remove(overlayEntry);
      }
    });
  }

  /// Show success toast
  static void success(
    BuildContext context,
    String message, {
    ToastPosition? position,
    Duration? duration,
    bool? showIcon,
    VoidCallback? onTap,
  }) {
    show(
      context,
      message: message,
      type: ToastType.success,
      position: position,
      duration: duration,
      showIcon: showIcon,
      onTap: onTap,
    );
  }

  /// Show error toast
  static void error(
    BuildContext context,
    String message, {
    ToastPosition? position,
    Duration? duration,
    bool? showIcon,
    VoidCallback? onTap,
  }) {
    show(
      context,
      message: message,
      type: ToastType.error,
      position: position,
      duration: duration,
      showIcon: showIcon,
      onTap: onTap,
    );
  }

  /// Show warning toast
  static void warning(
    BuildContext context,
    String message, {
    ToastPosition? position,
    Duration? duration,
    bool? showIcon,
    VoidCallback? onTap,
  }) {
    show(
      context,
      message: message,
      type: ToastType.warning,
      position: position,
      duration: duration,
      showIcon: showIcon,
      onTap: onTap,
    );
  }

  /// Show info toast
  static void info(
    BuildContext context,
    String message, {
    ToastPosition? position,
    Duration? duration,
    bool? showIcon,
    VoidCallback? onTap,
  }) {
    show(
      context,
      message: message,
      type: ToastType.info,
      position: position,
      duration: duration,
      showIcon: showIcon,
      onTap: onTap,
    );
  }

  /// Show custom toast with custom colors
  static void custom(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    ToastPosition? position,
    Color textColor = Colors.white,
    IconData? icon,
    Duration? duration,
    bool? showCloseButton,
    VoidCallback? onTap,
  }) {
    final config = defaultConfig;
    final finalPosition = position ?? config.position;
    final finalAnimation = config.animation;
    final finalDuration = duration ?? config.duration;
    final finalShowCloseButton = showCloseButton ?? config.showCloseButton;

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        type: null,
        customIcon: icon,
        position: finalPosition,
        animation: finalAnimation,
        backgroundColor: backgroundColor,
        textColor: textColor,
        textStyle: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        showIcon: icon != null,
        showCloseButton: finalShowCloseButton,
        elevation: config.elevation,
        borderRadius: config.borderRadius,
        maxWidth: config.maxWidth,
        margin: config.margin,
        padding: config.padding,
        onTap: onTap,
        onDismiss: () {
          overlayEntry.remove();
          _activeToasts.remove(overlayEntry);
        },
      ),
    );

    _activeToasts.add(overlayEntry);
    overlay.insert(overlayEntry);

    Timer(finalDuration, () {
      if (_activeToasts.contains(overlayEntry)) {
        overlayEntry.remove();
        _activeToasts.remove(overlayEntry);
      }
    });
  }

  /// Clear all active toasts
  static void clearAll() {
    for (final entry in _activeToasts) {
      entry.remove();
    }
    _activeToasts.clear();
  }

  /// Update default configuration
  static void updateDefaultConfig(ToastConfig config) {
    defaultConfig = config;
  }

  /// Get count of active toasts
  static int get activeCount => _activeToasts.length;
}

/// Widget for displaying toast
class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastType? type;
  final IconData? customIcon;
  final ToastPosition position;
  final ToastAnimation animation;
  final Color backgroundColor;
  final Color textColor;
  final TextStyle textStyle;
  final bool showIcon;
  final bool showCloseButton;
  final double elevation;
  final double borderRadius;
  final double maxWidth;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final VoidCallback onDismiss;

  const _ToastWidget({
    required this.message,
    required this.type,
    this.customIcon,
    required this.position,
    required this.animation,
    required this.backgroundColor,
    required this.textColor,
    required this.textStyle,
    required this.showIcon,
    required this.showCloseButton,
    required this.elevation,
    required this.borderRadius,
    required this.maxWidth,
    required this.margin,
    required this.padding,
    this.onTap,
    required this.onDismiss,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    // Determine slide direction based on position
    Offset slideBegin;
    switch (widget.position) {
      case ToastPosition.topLeft:
      case ToastPosition.topCenter:
      case ToastPosition.topRight:
        slideBegin = const Offset(0, -1);
        break;
      case ToastPosition.bottomLeft:
      case ToastPosition.bottomCenter:
      case ToastPosition.bottomRight:
        slideBegin = const Offset(0, 1);
        break;
      case ToastPosition.centerLeft:
        slideBegin = const Offset(-1, 0);
        break;
      case ToastPosition.centerRight:
        slideBegin = const Offset(1, 0);
        break;
      case ToastPosition.center:
        slideBegin = const Offset(0, 0);
        break;
    }

    _slideAnimation = Tween<Offset>(begin: slideBegin, end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() {
    _controller.reverse().then((_) => widget.onDismiss());
  }

  Widget _buildAnimatedToast(Widget child) {
    switch (widget.animation) {
      case ToastAnimation.fade:
        return FadeTransition(opacity: _fadeAnimation, child: child);
      case ToastAnimation.slide:
        return SlideTransition(position: _slideAnimation, child: child);
      case ToastAnimation.scale:
        return ScaleTransition(scale: _scaleAnimation, child: child);
      case ToastAnimation.slideAndFade:
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(opacity: _fadeAnimation, child: child),
        );
    }
  }

  Positioned _buildPositionedToast(Widget child) {
    final topPadding = MediaQuery.of(context).viewPadding.top;
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    switch (widget.position) {
      case ToastPosition.topLeft:
        return Positioned(
          top: topPadding + 16,
          left: 16,
          child: child,
        );
      case ToastPosition.topCenter:
        return Positioned(
          top: topPadding + 16,
          left: (screenWidth - widget.maxWidth) / 2,
          child: child,
        );
      case ToastPosition.topRight:
        return Positioned(
          top: topPadding + 16,
          right: 16,
          child: child,
        );
      case ToastPosition.centerLeft:
        return Positioned(
          top: (screenHeight - 100) / 2,
          left: 16,
          child: child,
        );
      case ToastPosition.center:
        return Positioned(
          top: (screenHeight - 100) / 2,
          left: (screenWidth - widget.maxWidth) / 2,
          child: child,
        );
      case ToastPosition.centerRight:
        return Positioned(
          top: (screenHeight - 100) / 2,
          right: 16,
          child: child,
        );
      case ToastPosition.bottomLeft:
        return Positioned(
          bottom: bottomPadding + 16,
          left: 16,
          child: child,
        );
      case ToastPosition.bottomCenter:
        return Positioned(
          bottom: bottomPadding + 16,
          left: (screenWidth - widget.maxWidth) / 2,
          child: child,
        );
      case ToastPosition.bottomRight:
        return Positioned(
          bottom: bottomPadding + 16,
          right: 16,
          child: child,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final toast = Material(
      elevation: widget.elevation,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      color: widget.backgroundColor,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Container(
          constraints: BoxConstraints(maxWidth: widget.maxWidth),
          padding: widget.padding as EdgeInsets,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showIcon) ...[
                Icon(
                  widget.customIcon ?? widget.type?.icon,
                  color: widget.textColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
              ],
              Flexible(
                child: Text(
                  widget.message,
                  style: widget.textStyle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.showCloseButton) ...[
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _dismiss,
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: widget.textColor.withOpacity(0.7),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );

    return _buildPositionedToast(_buildAnimatedToast(toast));
  }
}
