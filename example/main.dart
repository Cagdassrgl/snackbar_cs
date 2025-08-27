// ignore_for_file: inference_failure_on_instance_creation, avoid_print, use_build_context_synchronously, deprecated_member_use

// Snackbar CS paketinin örnek kullanım uygulaması
// Bu dosya, paket kullanıcılarına nasıl kullanacaklarını gösterir

import 'package:flutter/material.dart';
import 'package:snackbar_cs/snackbar_cs.dart';

void main() {
  runApp(const MyApp());
}

/// Ana uygulama widget'ı - MaterialApp ile snackbar desteği sağlar
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snackbar CS Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Snackbar CS Demo'),
    );
  }
}

/// Ana sayfa widget'ı - Tüm snackbar örneklerini gösterir
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    // Uygulama başladığında global konfigürasyon ayarları
    CSSnackbar.updateDefaultConfig(
      const SnackbarConfig(
        duration: Duration(seconds: 3),
        showCloseIcon: true,
        elevation: 8.0,
        borderRadius: 12.0,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
      ),
    );
  }

  /// Counter'ı artırır ve başarı mesajı gösterir
  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    CSSnackbar.success(
      context,
      'Counter increased to $_counter!',
      duration: const Duration(seconds: 2),
    );
  }

  /// Başarı snackbar'ı örneği
  void _showSuccessSnackbar() {
    CSSnackbar.success(
      context,
      'Operation completed successfully!',
      action: SnackBarAction(
        label: 'VIEW',
        onPressed: () {
          CSSnackbar.info(context, 'Viewing results...');
        },
      ),
    );
  }

  /// Hata snackbar'ı örneği
  void _showErrorSnackbar() {
    CSSnackbar.error(
      context,
      'Something went wrong! Please try again.',
      action: SnackBarAction(
        label: 'RETRY',
        onPressed: () {
          CSSnackbar.info(context, 'Retrying operation...');
        },
      ),
    );
  }

  /// Uyarı snackbar'ı örneği
  void _showWarningSnackbar() {
    CSSnackbar.warning(
      context,
      'This action cannot be undone. Are you sure?',
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () {
          CSSnackbar.success(context, 'Action cancelled!');
        },
      ),
    );
  }

  /// Bilgi snackbar'ı örneği
  void _showInfoSnackbar() {
    CSSnackbar.info(
      context,
      'Here is some useful information for you.',
      onVisible: () {
        print('Info snackbar is now visible');
      },
    );
  }

  /// İkonsuz snackbar örneği
  void _showWithoutIcon() {
    CSSnackbar.success(
      context,
      'Success message without icon',
      showIcon: false,
    );
  }

  /// Özel snackbar örneği
  void _showCustomSnackbar() {
    CSSnackbar.custom(
      context,
      message: 'This is a custom purple snackbar!',
      backgroundColor: Colors.purple,
      icon: Icons.star,
      textColor: Colors.white,
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        label: 'AWESOME',
        textColor: Colors.yellow,
        onPressed: () {
          CSSnackbar.success(context, 'You clicked awesome!');
        },
      ),
    );
  }

  /// Uzun mesaj snackbar örneği
  void _showLongMessage() {
    CSSnackbar.info(
      context,
      'This is a very long message that demonstrates how the snackbar handles text overflow with ellipsis when the content exceeds the maximum number of lines.',
    );
  }

  /// Hızlı ardışık snackbar örneği
  void _showSequentialSnackbars() {
    CSSnackbar.info(context, 'First message');

    Future.delayed(const Duration(milliseconds: 500), () {
      CSSnackbar.warning(context, 'Second message (replaces first)');
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      CSSnackbar.success(context, 'Final message');
    });
  }

  /// Tüm snackbar'ları temizle
  void _clearAllSnackbars() {
    CSSnackbar.clearAll(context);
    CSSnackbar.info(context, 'All snackbars cleared!');
  }

  /// Ana sayfa UI'ı oluşturur
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Counter section - Temel kullanım örneği
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Counter Demo',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'You have pushed the button this many times:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _incrementCounter,
                      icon: const Icon(Icons.add),
                      label: const Text('Increment Counter'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Predefined types section - Önceden tanımlı tipler
            const Text(
              'Predefined Snackbar Types',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildButton(
              'Show Success',
              Icons.check_circle,
              Colors.green,
              _showSuccessSnackbar,
            ),

            _buildButton(
              'Show Error',
              Icons.error,
              Colors.red,
              _showErrorSnackbar,
            ),

            _buildButton(
              'Show Warning',
              Icons.warning,
              Colors.orange,
              _showWarningSnackbar,
            ),

            _buildButton(
              'Show Info',
              Icons.info,
              Colors.blue,
              _showInfoSnackbar,
            ),

            const SizedBox(height: 24),

            // Customization section - Özelleştirme örnekleri
            const Text(
              'Customization Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildButton(
              'Without Icon',
              Icons.visibility_off,
              Colors.grey,
              _showWithoutIcon,
            ),

            _buildButton(
              'Custom Purple',
              Icons.star,
              Colors.purple,
              _showCustomSnackbar,
            ),

            _buildButton(
              'Long Message',
              Icons.text_fields,
              Colors.teal,
              _showLongMessage,
            ),

            const SizedBox(height: 24),

            // Advanced section - Gelişmiş özellikler
            const Text(
              'Advanced Features',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildButton(
              'Sequential Messages',
              Icons.queue,
              Colors.indigo,
              _showSequentialSnackbars,
            ),

            _buildButton(
              'Clear All',
              Icons.clear_all,
              Colors.red.shade300,
              _clearAllSnackbars,
            ),
          ],
        ),
      ),
    );
  }

  /// Tutarlı buton stilleri için yardımcı method
  Widget _buildButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(color.red, color.green, color.blue, 0.1),
          foregroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
