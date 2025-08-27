// Test dosyası için Flutter test framework'ü import edildi
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snackbar_cs/snackbar_cs.dart';

/// Test app widget - Snackbar testleri için basit bir MaterialApp oluşturur
class TestApp extends StatelessWidget {
  const TestApp({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }
}

/// Test için kullanılacak basit buton widget'ı
class TestButton extends StatelessWidget {
  const TestButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

void main() {
  /// Test grup: Snackbar Type enum testleri
  group('SnackbarType enum tests', () {
    test('SnackbarType should have correct colors and icons', () {
      // Success type test - Başarı tipinin doğru renk ve ikona sahip olduğunu kontrol eder
      expect(SnackbarType.success.color, const Color(0xFF4CAF50));
      expect(SnackbarType.success.icon, Icons.check_circle);

      // Error type test - Hata tipinin doğru renk ve ikona sahip olduğunu kontrol eder
      expect(SnackbarType.error.color, const Color(0xFFF44336));
      expect(SnackbarType.error.icon, Icons.error);

      // Warning type test - Uyarı tipinin doğru renk ve ikona sahip olduğunu kontrol eder
      expect(SnackbarType.warning.color, const Color(0xFFFF9800));
      expect(SnackbarType.warning.icon, Icons.warning);

      // Info type test - Bilgi tipinin doğru renk ve ikona sahip olduğunu kontrol eder
      expect(SnackbarType.info.color, const Color(0xFF2196F3));
      expect(SnackbarType.info.icon, Icons.info);
    });
  });

  /// Test grup: SnackbarConfig konfigürasyon testleri
  group('SnackbarConfig tests', () {
    test('SnackbarConfig should have correct default values', () {
      // Varsayılan konfigürasyon oluşturulur
      const config = SnackbarConfig();

      // Varsayılan değerlerin doğru olduğunu kontrol eder
      expect(config.duration, const Duration(seconds: 3));
      expect(config.showCloseIcon, true);
      expect(config.showIcon, true);
      expect(config.elevation, 6.0);
      expect(config.borderRadius, 8.0);
      expect(config.behavior, SnackBarBehavior.floating);
      expect(config.dismissDirection, DismissDirection.down);
      expect(config.margin, null);
      expect(config.padding, null);
      expect(config.textStyle, null);
      expect(config.onVisible, null);
    });

    test('SnackbarConfig should accept custom values', () {
      // Özel değerlerle konfigürasyon oluşturulur
      const customConfig = SnackbarConfig(
        duration: Duration(seconds: 5),
        showCloseIcon: false,
        showIcon: false,
        elevation: 10.0,
        borderRadius: 12.0,
        behavior: SnackBarBehavior.fixed,
        dismissDirection: DismissDirection.up,
      );

      // Özel değerlerin doğru ayarlandığını kontrol eder
      expect(customConfig.duration, const Duration(seconds: 5));
      expect(customConfig.showCloseIcon, false);
      expect(customConfig.showIcon, false);
      expect(customConfig.elevation, 10.0);
      expect(customConfig.borderRadius, 12.0);
      expect(customConfig.behavior, SnackBarBehavior.fixed);
      expect(customConfig.dismissDirection, DismissDirection.up);
    });
  });

  /// Test grup: CSSnackbar widget testleri
  group('CSSnackbar widget tests', () {
    testWidgets('CSSnackbar.success should show success snackbar', (WidgetTester tester) async {
      // Test widget'ı oluşturulur
      await tester.pumpWidget(
        TestApp(
          child: Builder(
            builder: (context) => TestButton(
              onPressed: () => CSSnackbar.success(context, 'Success message'),
              text: 'Show Success',
            ),
          ),
        ),
      );

      // Butona tıklanır
      await tester.tap(find.text('Show Success'));
      await tester.pump();

      // Success snackbar'ın göründüğünü kontrol eder
      expect(find.text('Success message'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('CSSnackbar.error should show error snackbar', (WidgetTester tester) async {
      // Test widget'ı oluşturulur
      await tester.pumpWidget(
        TestApp(
          child: Builder(
            builder: (context) => TestButton(
              onPressed: () => CSSnackbar.error(context, 'Error message'),
              text: 'Show Error',
            ),
          ),
        ),
      );

      // Butona tıklanır
      await tester.tap(find.text('Show Error'));
      await tester.pump();

      // Error snackbar'ın göründüğünü kontrol eder
      expect(find.text('Error message'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('CSSnackbar.warning should show warning snackbar', (WidgetTester tester) async {
      // Test widget'ı oluşturulur
      await tester.pumpWidget(
        TestApp(
          child: Builder(
            builder: (context) => TestButton(
              onPressed: () => CSSnackbar.warning(context, 'Warning message'),
              text: 'Show Warning',
            ),
          ),
        ),
      );

      // Butona tıklanır
      await tester.tap(find.text('Show Warning'));
      await tester.pump();

      // Warning snackbar'ın göründüğünü kontrol eder
      expect(find.text('Warning message'), findsOneWidget);
      expect(find.byIcon(Icons.warning), findsOneWidget);
    });

    testWidgets('CSSnackbar.info should show info snackbar', (WidgetTester tester) async {
      // Test widget'ı oluşturulur
      await tester.pumpWidget(
        TestApp(
          child: Builder(
            builder: (context) => TestButton(
              onPressed: () => CSSnackbar.info(context, 'Info message'),
              text: 'Show Info',
            ),
          ),
        ),
      );

      // Butona tıklanır
      await tester.tap(find.text('Show Info'));
      await tester.pump();

      // Info snackbar'ın göründüğünü kontrol eder
      expect(find.text('Info message'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('CSSnackbar.custom should show custom snackbar', (WidgetTester tester) async {
      // Test widget'ı oluşturulur
      await tester.pumpWidget(
        TestApp(
          child: Builder(
            builder: (context) => TestButton(
              onPressed: () => CSSnackbar.custom(
                context,
                message: 'Custom message',
                backgroundColor: Colors.purple,
                icon: Icons.star,
              ),
              text: 'Show Custom',
            ),
          ),
        ),
      );

      // Butona tıklanır
      await tester.tap(find.text('Show Custom'));
      await tester.pump();

      // Custom snackbar'ın göründüğünü kontrol eder
      expect(find.text('Custom message'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('CSSnackbar should show without icon when showIcon is false', (WidgetTester tester) async {
      // Test widget'ı oluşturulur
      await tester.pumpWidget(
        TestApp(
          child: Builder(
            builder: (context) => TestButton(
              onPressed: () => CSSnackbar.success(
                context,
                'Success without icon',
                showIcon: false,
              ),
              text: 'Show Without Icon',
            ),
          ),
        ),
      );

      // Butona tıklanır
      await tester.tap(find.text('Show Without Icon'));
      await tester.pump();

      // Mesajın göründüğünü ama ikonun görünmediğini kontrol eder
      expect(find.text('Success without icon'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsNothing);
    });

    testWidgets('CSSnackbar should accept SnackBarAction', (WidgetTester tester) async {
      // Test widget'ı oluşturulur
      await tester.pumpWidget(
        TestApp(
          child: Builder(
            builder: (context) => TestButton(
              onPressed: () => CSSnackbar.success(
                context,
                'Success with action',
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {},
                ),
              ),
              text: 'Show With Action',
            ),
          ),
        ),
      );

      // Butona tıklanır
      await tester.tap(find.text('Show With Action'));
      await tester.pump();

      // Mesaj ve action butonunun göründüğünü kontrol eder
      expect(find.text('Success with action'), findsOneWidget);
      expect(find.text('UNDO'), findsOneWidget);
    });

    testWidgets('CSSnackbar.hide should hide current snackbar', (WidgetTester tester) async {
      // Test widget'ı oluşturulur
      await tester.pumpWidget(
        TestApp(
          child: Builder(
            builder: (context) => Column(
              children: [
                TestButton(
                  onPressed: () => CSSnackbar.success(context, 'Success message'),
                  text: 'Show Success',
                ),
                TestButton(
                  onPressed: () => CSSnackbar.hide(context),
                  text: 'Hide Snackbar',
                ),
              ],
            ),
          ),
        ),
      );

      // İlk butona tıklanır ve snackbar gösterilir
      await tester.tap(find.text('Show Success'));
      await tester.pump();
      expect(find.text('Success message'), findsOneWidget);

      // Hide butonuna tıklanır
      await tester.tap(find.text('Hide Snackbar'));
      await tester.pump();

      // Snackbar'ın animasyonla kaybolması için biraz bekler
      await tester.pump(const Duration(milliseconds: 100));

      // Snackbar'ın gizlendiğini kontrol eder
      expect(find.text('Success message'), findsNothing);
    });

    testWidgets('CSSnackbar should handle long messages with ellipsis', (WidgetTester tester) async {
      const longMessage = 'This is a very long message that should be truncated with ellipsis when it exceeds the maximum number of lines allowed for the snackbar content';

      // Test widget'ı oluşturulur
      await tester.pumpWidget(
        TestApp(
          child: Builder(
            builder: (context) => TestButton(
              onPressed: () => CSSnackbar.info(context, longMessage),
              text: 'Show Long Message',
            ),
          ),
        ),
      );

      // Butona tıklanır
      await tester.tap(find.text('Show Long Message'));
      await tester.pump();

      // Uzun mesajın göründüğünü kontrol eder (Text widget'ı maxLines ve overflow özelliklerini test eder)
      final textWidget = tester.widget<Text>(find.text(longMessage));
      expect(textWidget.maxLines, 3);
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });
  });

  /// Test grup: Konfigürasyon yönetimi testleri
  group('CSSnackbar configuration tests', () {
    testWidgets('CSSnackbar should use updated default config', (WidgetTester tester) async {
      // Özel konfigürasyon ayarlanır
      const customConfig = SnackbarConfig(
        duration: Duration(seconds: 10),
        showCloseIcon: false,
        elevation: 15.0,
      );

      CSSnackbar.updateDefaultConfig(customConfig);

      // Test widget'ı oluşturulur
      await tester.pumpWidget(
        TestApp(
          child: Builder(
            builder: (context) => TestButton(
              onPressed: () => CSSnackbar.info(context, 'Test message'),
              text: 'Show Info',
            ),
          ),
        ),
      );

      // Butona tıklanır
      await tester.tap(find.text('Show Info'));
      await tester.pump();

      // Mesajın göründüğünü kontrol eder
      expect(find.text('Test message'), findsOneWidget);

      // Varsayılan konfigürasyonu eski haline döndürür
      CSSnackbar.updateDefaultConfig(const SnackbarConfig());
    });

    testWidgets('CSSnackbar.clearAll should clear all snackbars', (WidgetTester tester) async {
      // Test widget'ı oluşturulur
      await tester.pumpWidget(
        TestApp(
          child: Builder(
            builder: (context) => Column(
              children: [
                TestButton(
                  onPressed: () => CSSnackbar.info(context, 'Info message'),
                  text: 'Show Info',
                ),
                TestButton(
                  onPressed: () => CSSnackbar.clearAll(context),
                  text: 'Clear All',
                ),
              ],
            ),
          ),
        ),
      );

      // İlk butona tıklanır ve snackbar gösterilir
      await tester.tap(find.text('Show Info'));
      await tester.pump();
      expect(find.text('Info message'), findsOneWidget);

      // Clear all butonuna tıklanır
      await tester.tap(find.text('Clear All'));
      await tester.pump();

      // Snackbar'ın temizlendiğini kontrol eder
      expect(find.text('Info message'), findsNothing);
    });
  });

  /// Test grup: Edge case testleri
  group('CSSnackbar edge cases', () {
    testWidgets('CSSnackbar should handle empty message', (WidgetTester tester) async {
      // Test widget'ı oluşturulur
      await tester.pumpWidget(
        TestApp(
          child: Builder(
            builder: (context) => TestButton(
              onPressed: () => CSSnackbar.info(context, ''),
              text: 'Show Empty',
            ),
          ),
        ),
      );

      // Butona tıklanır
      await tester.tap(find.text('Show Empty'));
      await tester.pump();

      // Boş mesajla snackbar'ın gösterildiğini kontrol eder
      expect(find.text(''), findsOneWidget);
    });

    testWidgets('CSSnackbar should handle null optional parameters', (WidgetTester tester) async {
      // Test widget'ı oluşturulur
      await tester.pumpWidget(
        TestApp(
          child: Builder(
            builder: (context) => TestButton(
              onPressed: () => CSSnackbar.success(
                context,
                'Test message',
                duration: null,
                textStyle: null,
                showIcon: null,
                onVisible: null,
                action: null,
              ),
              text: 'Show With Nulls',
            ),
          ),
        ),
      );

      // Butona tıklanır
      await tester.tap(find.text('Show With Nulls'));
      await tester.pump();

      // Null parametrelerle snackbar'ın gösterildiğini kontrol eder
      expect(find.text('Test message'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });
  });
}
