// ignore_for_file: inference_failure_on_instance_creation, avoid_print, use_build_context_synchronously, deprecated_member_use

// Snackbar CS paketinin birden fazla snackbar örnek kullanım uygulaması
// Bu dosya, paket kullanıcılarına birden fazla snackbar'ı nasıl kullanacaklarını gösterir

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
      title: 'Snackbar CS Demo - Multiple Snackbars',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

/// Ana sayfa widget'ı - Çoklu snackbar örneklerini gösterir
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  QueueBehavior _currentBehavior = QueueBehavior.replace;

  @override
  void initState() {
    super.initState();

    // Uygulama başladığında global konfigürasyon ayarları
    CSSnackbar.updateDefaultConfig(
      const SnackbarConfig(
        duration: Duration(seconds: 2),
        showCloseIcon: true,
        showIcon: true,
        elevation: 6.0,
        borderRadius: 12.0,
        queueBehavior: QueueBehavior.replace, // Varsayılan davranış
      ),
    );
  }

  /// Queue davranışını değiştirir
  void _changeBehavior(QueueBehavior behavior) {
    setState(() {
      _currentBehavior = behavior;
    });

    String behaviorName = behavior == QueueBehavior.replace
        ? 'Replace (Varsayılan)'
        : behavior == QueueBehavior.queue
            ? 'Queue (Sıralı)'
            : 'Stack (Üst üste)';

    CSSnackbar.info(
      context,
      'Queue davranışı değiştirildi: $behaviorName',
      queueBehavior: QueueBehavior.replace, // Bu bilgilendirme mesajı her zaman replace olsun
    );
  }

  /// Replace modunda birden fazla snackbar göster
  void _showReplaceMode() {
    CSSnackbar.success(context, 'İlk mesaj (değiştirilecek)', queueBehavior: QueueBehavior.replace);

    Future.delayed(const Duration(milliseconds: 500), () {
      CSSnackbar.warning(context, 'İkinci mesaj (ilkini değiştirir)', queueBehavior: QueueBehavior.replace);
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      CSSnackbar.error(context, 'Son mesaj (ikincisini değiştirir)', queueBehavior: QueueBehavior.replace);
    });
  }

  /// Queue modunda birden fazla snackbar göster
  void _showQueueMode() {
    CSSnackbar.success(context, '1. mesaj (sırada)', queueBehavior: QueueBehavior.queue);
    CSSnackbar.info(context, '2. mesaj (sırada)', queueBehavior: QueueBehavior.queue);
    CSSnackbar.warning(context, '3. mesaj (sırada)', queueBehavior: QueueBehavior.queue);
    CSSnackbar.error(context, '4. mesaj (sırada)', queueBehavior: QueueBehavior.queue);

    // Queue bilgisi göster
    CSSnackbar.custom(
      context,
      message: '${CSSnackbar.queueLength} mesaj sıraya eklendi!',
      backgroundColor: Colors.purple,
      queueBehavior: QueueBehavior.replace,
    );
  }

  /// Stack modunda birden fazla snackbar göster
  void _showStackMode() {
    CSSnackbar.success(context, 'Alt snackbar', queueBehavior: QueueBehavior.stack);

    Future.delayed(const Duration(milliseconds: 300), () {
      CSSnackbar.info(context, 'Orta snackbar', queueBehavior: QueueBehavior.stack);
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      CSSnackbar.warning(context, 'Üst snackbar', queueBehavior: QueueBehavior.stack);
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      CSSnackbar.error(context, 'En üst snackbar', queueBehavior: QueueBehavior.stack);
    });
  }

  /// Mevcut seçili davranışa göre snackbar göster
  void _showCurrentBehavior() {
    switch (_currentBehavior) {
      case QueueBehavior.replace:
        _showReplaceMode();
        break;
      case QueueBehavior.queue:
        _showQueueMode();
        break;
      case QueueBehavior.stack:
        _showStackMode();
        break;
    }
  }

  /// Karışık davranışlar örneği
  void _showMixedBehaviors() {
    // Replace ile başla
    CSSnackbar.success(context, 'Replace mesajı', queueBehavior: QueueBehavior.replace);

    // Stack ekle
    Future.delayed(const Duration(milliseconds: 300), () {
      CSSnackbar.info(context, 'Stack mesajı 1', queueBehavior: QueueBehavior.stack);
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      CSSnackbar.warning(context, 'Stack mesajı 2', queueBehavior: QueueBehavior.stack);
    });

    // Queue'ya ekle (stack'ler bittikten sonra görünür)
    Future.delayed(const Duration(milliseconds: 900), () {
      CSSnackbar.error(context, 'Queue mesajı 1', queueBehavior: QueueBehavior.queue);
      CSSnackbar.custom(
        context,
        message: 'Queue mesajı 2',
        backgroundColor: Colors.purple,
        queueBehavior: QueueBehavior.queue,
      );
    });
  }

  /// Uzun süreli snackbar'lar
  void _showLongDuration() {
    CSSnackbar.info(
      context,
      'Bu mesaj 10 saniye kalacak',
      duration: const Duration(seconds: 10),
      queueBehavior: _currentBehavior,
    );

    CSSnackbar.warning(
      context,
      'Bu mesaj da 8 saniye kalacak',
      duration: const Duration(seconds: 8),
      queueBehavior: _currentBehavior,
    );
  }

  /// Action'lu snackbar'lar
  void _showWithActions() {
    CSSnackbar.success(
      context,
      'İşlem başarılı',
      action: SnackBarAction(
        label: 'DETAY',
        onPressed: () {
          CSSnackbar.info(context, 'Detaylar gösteriliyor...', queueBehavior: _currentBehavior);
        },
      ),
      queueBehavior: _currentBehavior,
    );

    CSSnackbar.error(
      context,
      'Bir hata oluştu',
      action: SnackBarAction(
        label: 'YENİDEN DENE',
        onPressed: () {
          CSSnackbar.info(context, 'Tekrar deneniyor...', queueBehavior: _currentBehavior);
        },
      ),
      queueBehavior: _currentBehavior,
    );
  }

  /// Tüm snackbar'ları temizle
  void _clearAll() {
    CSSnackbar.clearAll(context);
    Future.delayed(const Duration(milliseconds: 100), () {
      CSSnackbar.info(context, 'Tüm snackbar\'lar temizlendi!');
    });
  }

  /// Ana sayfa UI'ı oluşturur
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Snackbar CS - Çoklu Snackbar Demo'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Mevcut davranış göstergesi
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Mevcut Queue Davranışı',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _currentBehavior == QueueBehavior.replace
                          ? 'Replace (Varsayılan - Yeni snackbar eskisini değiştirir)'
                          : _currentBehavior == QueueBehavior.queue
                              ? 'Queue (Sıralı - Snackbar\'lar sırayla gösterilir)'
                              : 'Stack (Üst üste - Snackbar\'lar üst üste binir)',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => _changeBehavior(QueueBehavior.replace),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _currentBehavior == QueueBehavior.replace ? Colors.blue : null,
                            foregroundColor: _currentBehavior == QueueBehavior.replace ? Colors.white : null,
                          ),
                          child: const Text('Replace'),
                        ),
                        ElevatedButton(
                          onPressed: () => _changeBehavior(QueueBehavior.queue),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _currentBehavior == QueueBehavior.queue ? Colors.blue : null,
                            foregroundColor: _currentBehavior == QueueBehavior.queue ? Colors.white : null,
                          ),
                          child: const Text('Queue'),
                        ),
                        ElevatedButton(
                          onPressed: () => _changeBehavior(QueueBehavior.stack),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _currentBehavior == QueueBehavior.stack ? Colors.blue : null,
                            foregroundColor: _currentBehavior == QueueBehavior.stack ? Colors.white : null,
                          ),
                          child: const Text('Stack'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Temel örnekler
            const Text(
              'Temel Örnekler',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            _buildButton(
              'Mevcut Davranışla Göster',
              Icons.play_arrow,
              Colors.green,
              _showCurrentBehavior,
            ),

            const SizedBox(height: 16),

            // Gelişmiş örnekler
            const Text(
              'Gelişmiş Örnekler',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            _buildButton(
              'Karışık Davranışlar',
              Icons.shuffle,
              Colors.purple,
              _showMixedBehaviors,
            ),

            _buildButton(
              'Uzun Süreli Mesajlar',
              Icons.access_time,
              Colors.orange,
              _showLongDuration,
            ),

            _buildButton(
              'Action\'lu Snackbar\'lar',
              Icons.touch_app,
              Colors.teal,
              _showWithActions,
            ),

            const SizedBox(height: 16),

            // Kontrol butonları
            const Text(
              'Kontrol',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: _buildButton(
                    'Tümünü Temizle',
                    Icons.clear_all,
                    Colors.red,
                    _clearAll,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('Queue: ${CSSnackbar.queueLength}'),
                          Text('Stack: ${CSSnackbar.stackedCount}'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Açıklama
            Card(
              color: Colors.blue.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kullanım Notları:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('• Replace: Yeni snackbar eskisinin yerini alır (varsayılan)'),
                    Text('• Queue: Snackbar\'lar sırayla, biri bittikten sonra diğeri gösterilir'),
                    Text('• Stack: Snackbar\'lar üst üste binerek aynı anda gösterilir'),
                    SizedBox(height: 8),
                    Text(
                      'Her snackbar gösterirken queueBehavior parametresini belirtebilir '
                      'veya global konfigürasyonda varsayılan davranışı ayarlayabilirsiniz.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
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
