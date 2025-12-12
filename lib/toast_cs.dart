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

/// Toast queue behavior
enum ToastBehavior {
  /// Show immediately, stack with offset if multiple (default)
  stack,

  /// Queue toasts and show one at a time
  queue,
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
    this.behavior = ToastBehavior.stack,
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

  /// Behavior when multiple toasts are shown
  final ToastBehavior behavior;
}

/// Internal class to hold toast data for queue
class _ToastItem {
  final BuildContext context;
  final String message;
  final ToastType type;
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
  final Duration duration;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;
  final IconData? customIcon;

  _ToastItem({
    required this.context,
    required this.message,
    required this.type,
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
    required this.duration,
    this.onTap,
    this.onDismiss,
    this.customIcon,
  });
}

/// Toast queue manager
class _ToastQueue {
  static final List<_ToastItem> _queue = [];
  static bool _isProcessing = false;

  static void enqueue(_ToastItem item) {
    _queue.add(item);
    if (!_isProcessing) {
      _processQueue();
    }
  }

  static Future<void> _processQueue() async {
    if (_queue.isEmpty || _isProcessing) return;

    _isProcessing = true;

    while (_queue.isNotEmpty) {
      final item = _queue.removeAt(0);
      await _showToastItem(item);
      await Future.delayed(item.duration + const Duration(milliseconds: 200));
    }

    _isProcessing = false;
  }

  static Future<void> _showToastItem(_ToastItem item) async {
    final completer = Completer<void>();

    CSToast._showToastDirect(
      item.context,
      message: item.message,
      type: item.type,
      position: item.position,
      animation: item.animation,
      duration: item.duration,
      backgroundColor: item.backgroundColor,
      textColor: item.textColor,
      textStyle: item.textStyle,
      showIcon: item.showIcon,
      showCloseButton: item.showCloseButton,
      elevation: item.elevation,
      borderRadius: item.borderRadius,
      maxWidth: item.maxWidth,
      margin: item.margin,
      padding: item.padding,
      onTap: item.onTap,
      onDismiss: () {
        item.onDismiss?.call();
        completer.complete();
      },
      customIcon: item.customIcon,
    );

    return completer.future;
  }

  static void clearQueue() {
    _queue.clear();
  }

  static int get queueLength => _queue.length;
}

/// Toast manager for displaying toast messages
class CSToast {
  static ToastConfig defaultConfig = const ToastConfig();
  static final List<OverlayEntry> _activeToasts = [];
  static final Map<ToastPosition, int> _toastCountByPosition = {};

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
    ToastBehavior? behavior,
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
    final finalBehavior = behavior ?? config.behavior;

    final defaultTextStyle = TextStyle(
      color: textColor ?? Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
    final finalTextStyle = textStyle ?? config.textStyle ?? defaultTextStyle;

    // Handle queue behavior
    if (finalBehavior == ToastBehavior.queue) {
      _ToastQueue.enqueue(_ToastItem(
        context: context,
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
        duration: finalDuration,
        onTap: onTap,
        onDismiss: onDismiss,
      ));
      return;
    }

    // Stack behavior with offset
    _showToastDirect(
      context,
      message: message,
      type: type,
      position: finalPosition,
      animation: finalAnimation,
      duration: finalDuration,
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
      onDismiss: onDismiss,
    );
  }

  /// Show toast directly (internal method)
  static void _showToastDirect(
    BuildContext context, {
    required String message,
    required ToastType type,
    required ToastPosition position,
    required ToastAnimation animation,
    required Duration duration,
    required Color backgroundColor,
    required Color textColor,
    required TextStyle textStyle,
    required bool showIcon,
    required bool showCloseButton,
    required double elevation,
    required double borderRadius,
    required double maxWidth,
    required EdgeInsetsGeometry margin,
    required EdgeInsetsGeometry padding,
    VoidCallback? onTap,
    VoidCallback? onDismiss,
    IconData? customIcon,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    // Calculate stack index for this position
    final stackIndex = _toastCountByPosition[position] ?? 0;
    _toastCountByPosition[position] = stackIndex + 1;

    overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        type: customIcon == null ? type : null,
        customIcon: customIcon,
        position: position,
        animation: animation,
        backgroundColor: backgroundColor,
        textColor: textColor,
        textStyle: textStyle,
        showIcon: showIcon,
        showCloseButton: showCloseButton,
        elevation: elevation,
        borderRadius: borderRadius,
        maxWidth: maxWidth,
        margin: margin,
        padding: padding,
        stackIndex: stackIndex,
        onTap: onTap,
        onDismiss: () {
          overlayEntry.remove();
          _activeToasts.remove(overlayEntry);
          final currentCount = _toastCountByPosition[position] ?? 0;
          if (currentCount > 0) {
            _toastCountByPosition[position] = currentCount - 1;
          }
          onDismiss?.call();
        },
      ),
    );

    _activeToasts.add(overlayEntry);
    overlay.insert(overlayEntry);

    // Auto dismiss after duration
    Timer(duration, () {
      if (_activeToasts.contains(overlayEntry)) {
        overlayEntry.remove();
        _activeToasts.remove(overlayEntry);
        final currentCount = _toastCountByPosition[position] ?? 0;
        if (currentCount > 0) {
          _toastCountByPosition[position] = currentCount - 1;
        }
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
    ToastBehavior? behavior,
    VoidCallback? onTap,
  }) {
    final config = defaultConfig;
    final finalPosition = position ?? config.position;
    final finalDuration = duration ?? config.duration;
    final finalShowCloseButton = showCloseButton ?? config.showCloseButton;
    final finalBehavior = behavior ?? config.behavior;

    if (finalBehavior == ToastBehavior.queue) {
      _ToastQueue.enqueue(_ToastItem(
        context: context,
        message: message,
        type: ToastType.info, // Dummy type for custom
        position: finalPosition,
        animation: config.animation,
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
        duration: finalDuration,
        onTap: onTap,
        customIcon: icon,
      ));
      return;
    }

    _showToastDirect(
      context,
      message: message,
      type: ToastType.info,
      position: finalPosition,
      animation: config.animation,
      duration: finalDuration,
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
      customIcon: icon,
    );
  }

  /// Clear all active toasts and queue
  static void clearAll() {
    for (final entry in _activeToasts) {
      entry.remove();
    }
    _activeToasts.clear();
    _toastCountByPosition.clear();
    _ToastQueue.clearQueue();
  }

  /// Update default configuration
  static void updateDefaultConfig(ToastConfig config) {
    defaultConfig = config;
  }

  /// Get count of active toasts
  static int get activeCount => _activeToasts.length;

  /// Get count of queued toasts
  static int get queueLength => _ToastQueue.queueLength;
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
  final int stackIndex;
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
    this.stackIndex = 0,
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

    // Stack offset: 70px per toast
    final stackOffset = widget.stackIndex * 70.0;

    switch (widget.position) {
      case ToastPosition.topLeft:
        return Positioned(
          top: topPadding + 16 + stackOffset,
          left: 16,
          child: child,
        );
      case ToastPosition.topCenter:
        return Positioned(
          top: topPadding + 16 + stackOffset,
          left: (screenWidth - widget.maxWidth) / 2,
          child: child,
        );
      case ToastPosition.topRight:
        return Positioned(
          top: topPadding + 16 + stackOffset,
          right: 16,
          child: child,
        );
      case ToastPosition.centerLeft:
        return Positioned(
          top: (screenHeight - 100) / 2 + stackOffset,
          left: 16,
          child: child,
        );
      case ToastPosition.center:
        return Positioned(
          top: (screenHeight - 100) / 2 + stackOffset,
          left: (screenWidth - widget.maxWidth) / 2,
          child: child,
        );
      case ToastPosition.centerRight:
        return Positioned(
          top: (screenHeight - 100) / 2 + stackOffset,
          right: 16,
          child: child,
        );
      case ToastPosition.bottomLeft:
        return Positioned(
          bottom: bottomPadding + 16 + stackOffset,
          left: 16,
          child: child,
        );
      case ToastPosition.bottomCenter:
        return Positioned(
          bottom: bottomPadding + 16 + stackOffset,
          left: (screenWidth - widget.maxWidth) / 2,
          child: child,
        );
      case ToastPosition.bottomRight:
        return Positioned(
          bottom: bottomPadding + 16 + stackOffset,
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
                    color: widget.textColor.withValues(alpha: 0.7),
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
