// ignore_for_file: inference_failure_on_instance_creation, library_private_types_in_public_api

/// A customizable Flutter snackbar package with predefined styles
/// for success, error, warning, and info messages.
library snackbar_cs;

import 'dart:async';
import 'package:flutter/material.dart';

/// Snackbar queue management for multiple snackbars
class SnackbarQueue {
  static final List<_SnackbarItem> _queue = [];
  static bool _isProcessing = false;

  /// Add snackbar to queue and process if not already processing
  static void enqueue(_SnackbarItem item) {
    _queue.add(item);
    if (!_isProcessing) {
      _processQueue();
    }
  }

  /// Process the queue sequentially
  static Future<void> _processQueue() async {
    if (_queue.isEmpty || _isProcessing) return;

    _isProcessing = true;

    while (_queue.isNotEmpty) {
      final item = _queue.removeAt(0);
      await _showSnackbarItem(item);

      // Wait for the snackbar duration plus a small delay
      await Future.delayed(item.duration + const Duration(milliseconds: 500));
    }

    _isProcessing = false;
  }

  /// Show individual snackbar item
  static Future<void> _showSnackbarItem(_SnackbarItem item) async {
    final completer = Completer<void>();

    ScaffoldMessenger.of(item.context).showSnackBar(
      SnackBar(
        content: item.content,
        backgroundColor: item.backgroundColor,
        duration: item.duration,
        showCloseIcon: item.showCloseIcon,
        elevation: item.elevation,
        margin: item.margin,
        padding: item.padding,
        behavior: item.behavior,
        dismissDirection: item.dismissDirection,
        shape: item.shape,
        action: item.action,
        onVisible: () {
          item.onVisible?.call();
          completer.complete();
        },
      ),
    );

    return completer.future;
  }

  /// Clear all queued snackbars
  static void clearQueue() {
    _queue.clear();
  }

  /// Get queue length
  static int get queueLength => _queue.length;
}

/// Internal class to hold snackbar data
class _SnackbarItem {
  final BuildContext context;
  final Widget content;
  final Color? backgroundColor;
  final Duration duration;
  final bool showCloseIcon;
  final double elevation;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final SnackBarBehavior behavior;
  final DismissDirection dismissDirection;
  final ShapeBorder? shape;
  final SnackBarAction? action;
  final VoidCallback? onVisible;

  _SnackbarItem({
    required this.context,
    required this.content,
    this.backgroundColor,
    required this.duration,
    required this.showCloseIcon,
    required this.elevation,
    this.margin,
    this.padding,
    required this.behavior,
    required this.dismissDirection,
    this.shape,
    this.action,
    this.onVisible,
  });
}

/// Queue behavior options
enum QueueBehavior {
  /// Replace current snackbar (default behavior)
  replace,

  /// Add to queue and show sequentially
  queue,

  /// Stack multiple snackbars using overlay
  stack,
}

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
    this.queueBehavior = QueueBehavior.replace,
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

  /// Queue behavior for multiple snackbars
  final QueueBehavior queueBehavior;
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
    QueueBehavior? queueBehavior,
  }) {
    // Determine queue behavior
    final finalQueueBehavior = queueBehavior ?? defaultConfig.queueBehavior;

    // Handle queue behavior
    if (finalQueueBehavior == QueueBehavior.replace) {
      // Hide any current snackbar before showing new one (default behavior)
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }

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

    // Create snackbar shape
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(finalBorderRadius),
    );

    // Handle different queue behaviors
    if (finalQueueBehavior == QueueBehavior.queue) {
      // Add to queue for sequential display
      SnackbarQueue.enqueue(_SnackbarItem(
        context: context,
        content: content,
        backgroundColor: backgroundColor ?? type.color,
        duration: finalDuration,
        showCloseIcon: finalShowCloseIcon,
        elevation: finalElevation,
        margin: finalMargin,
        padding: finalPadding,
        behavior: finalBehavior,
        dismissDirection: finalDismissDirection,
        shape: shape,
        action: action,
        onVisible: onVisible,
      ));
    } else if (finalQueueBehavior == QueueBehavior.stack) {
      // Use overlay to stack multiple snackbars
      _showStackedSnackbar(
        context,
        content: content,
        backgroundColor: backgroundColor ?? type.color,
        duration: finalDuration,
        showCloseIcon: finalShowCloseIcon,
        elevation: finalElevation,
        margin: finalMargin,
        padding: finalPadding,
        behavior: finalBehavior,
        dismissDirection: finalDismissDirection,
        shape: shape,
        action: action,
        onVisible: onVisible,
      );
    } else {
      // Default replace behavior
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
          shape: shape,
          action: action,
          onVisible: onVisible,
        ),
      );
    }
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
    QueueBehavior? queueBehavior,
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
      queueBehavior: queueBehavior,
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
    QueueBehavior? queueBehavior,
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
      queueBehavior: queueBehavior,
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
    QueueBehavior? queueBehavior,
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
      queueBehavior: queueBehavior,
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
    QueueBehavior? queueBehavior,
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
      queueBehavior: queueBehavior,
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
    QueueBehavior? queueBehavior,
  }) {
    // Determine queue behavior
    final finalQueueBehavior = queueBehavior ?? defaultConfig.queueBehavior;

    // Handle queue behavior
    if (finalQueueBehavior == QueueBehavior.replace) {
      // Hide any current snackbar before showing new one (default behavior)
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }

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
    final finalDuration = duration ?? config.duration;
    final finalShowCloseIcon = showCloseIcon ?? config.showCloseIcon;
    final finalElevation = elevation ?? config.elevation;
    final finalMargin = margin ?? config.margin;
    final finalPadding = padding ?? config.padding;
    final finalBehavior = behavior ?? config.behavior;
    final finalDismissDirection = dismissDirection ?? config.dismissDirection;
    final finalBorderRadius = borderRadius ?? config.borderRadius;

    // Create snackbar shape
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(finalBorderRadius),
    );

    // Handle different queue behaviors
    if (finalQueueBehavior == QueueBehavior.queue) {
      // Add to queue for sequential display
      SnackbarQueue.enqueue(_SnackbarItem(
        context: context,
        content: content,
        backgroundColor: backgroundColor,
        duration: finalDuration,
        showCloseIcon: finalShowCloseIcon,
        elevation: finalElevation,
        margin: finalMargin,
        padding: finalPadding,
        behavior: finalBehavior,
        dismissDirection: finalDismissDirection,
        shape: shape,
        action: action,
        onVisible: onVisible,
      ));
    } else if (finalQueueBehavior == QueueBehavior.stack) {
      // Use overlay to stack multiple snackbars
      _showStackedSnackbar(
        context,
        content: content,
        backgroundColor: backgroundColor,
        duration: finalDuration,
        showCloseIcon: finalShowCloseIcon,
        elevation: finalElevation,
        margin: finalMargin,
        padding: finalPadding,
        behavior: finalBehavior,
        dismissDirection: finalDismissDirection,
        shape: shape,
        action: action,
        onVisible: onVisible,
      );
    } else {
      // Default replace behavior
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: content,
          backgroundColor: backgroundColor,
          duration: finalDuration,
          showCloseIcon: finalShowCloseIcon,
          elevation: finalElevation,
          margin: finalMargin,
          padding: finalPadding,
          behavior: finalBehavior,
          dismissDirection: finalDismissDirection,
          shape: shape,
          action: action,
          onVisible: onVisible,
        ),
      );
    }
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
    SnackbarQueue.clearQueue();
    _StackedSnackbarManager.clearAll();
  }

  /// Show stacked snackbar using overlay
  static void _showStackedSnackbar(
    BuildContext context, {
    required Widget content,
    Color? backgroundColor,
    required Duration duration,
    required bool showCloseIcon,
    required double elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    required SnackBarBehavior behavior,
    required DismissDirection dismissDirection,
    ShapeBorder? shape,
    SnackBarAction? action,
    VoidCallback? onVisible,
  }) {
    _StackedSnackbarManager.show(
      context,
      content: content,
      backgroundColor: backgroundColor,
      duration: duration,
      showCloseIcon: showCloseIcon,
      elevation: elevation,
      margin: margin,
      padding: padding,
      behavior: behavior,
      dismissDirection: dismissDirection,
      shape: shape,
      action: action,
      onVisible: onVisible,
    );
  }

  /// Clear queue
  static void clearQueue() {
    SnackbarQueue.clearQueue();
  }

  /// Get queue length
  static int get queueLength => SnackbarQueue.queueLength;

  /// Get active stacked snackbars count
  static int get stackedCount => _StackedSnackbarManager.activeCount;
}

/// Manager for stacked snackbars using overlay
class _StackedSnackbarManager {
  static final List<OverlayEntry> _activeEntries = [];
  static const double _stackOffset = 60.0;

  /// Show a stacked snackbar
  static void show(
    BuildContext context, {
    required Widget content,
    Color? backgroundColor,
    required Duration duration,
    required bool showCloseIcon,
    required double elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    required SnackBarBehavior behavior,
    required DismissDirection dismissDirection,
    ShapeBorder? shape,
    SnackBarAction? action,
    VoidCallback? onVisible,
  }) {
    final overlay = Overlay.of(context);
    final stackIndex = _activeEntries.length;

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _StackedSnackbarWidget(
        content: content,
        backgroundColor: backgroundColor,
        showCloseIcon: showCloseIcon,
        elevation: elevation,
        margin: margin,
        padding: padding,
        shape: shape,
        action: action,
        stackIndex: stackIndex,
        onDismiss: () {
          overlayEntry.remove();
          _activeEntries.remove(overlayEntry);
          _updateStackPositions();
        },
      ),
    );

    _activeEntries.add(overlayEntry);
    overlay.insert(overlayEntry);

    onVisible?.call();

    // Auto dismiss after duration
    Timer(duration, () {
      if (_activeEntries.contains(overlayEntry)) {
        overlayEntry.remove();
        _activeEntries.remove(overlayEntry);
        _updateStackPositions();
      }
    });
  }

  /// Update positions of stacked snackbars
  static void _updateStackPositions() {
    // This could be enhanced to animate position changes
    // For now, the position is calculated in the widget itself
  }

  /// Clear all stacked snackbars
  static void clearAll() {
    for (final entry in _activeEntries) {
      entry.remove();
    }
    _activeEntries.clear();
  }

  /// Get count of active stacked snackbars
  static int get activeCount => _activeEntries.length;
}

/// Widget for individual stacked snackbar
class _StackedSnackbarWidget extends StatefulWidget {
  final Widget content;
  final Color? backgroundColor;
  final bool showCloseIcon;
  final double elevation;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final ShapeBorder? shape;
  final SnackBarAction? action;
  final int stackIndex;
  final VoidCallback onDismiss;

  const _StackedSnackbarWidget({
    required this.content,
    this.backgroundColor,
    required this.showCloseIcon,
    required this.elevation,
    this.margin,
    this.padding,
    this.shape,
    this.action,
    required this.stackIndex,
    required this.onDismiss,
  });

  @override
  State<_StackedSnackbarWidget> createState() => _StackedSnackbarWidgetState();
}

class _StackedSnackbarWidgetState extends State<_StackedSnackbarWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _dismiss() {
    _animationController.reverse().then((_) {
      widget.onDismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomOffset = 16.0 + (widget.stackIndex * _StackedSnackbarManager._stackOffset);

    return Positioned(
      left: 16,
      right: 16,
      bottom: bottomOffset,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            elevation: widget.elevation,
            color: widget.backgroundColor ?? Theme.of(context).snackBarTheme.backgroundColor,
            shape: widget.shape,
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(child: widget.content),
                  if (widget.action != null) ...[
                    const SizedBox(width: 8),
                    widget.action!,
                  ],
                  if (widget.showCloseIcon) ...[
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _dismiss,
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
