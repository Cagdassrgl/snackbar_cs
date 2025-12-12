import 'package:flutter/material.dart';
import 'package:snackbar_cs/snackbar_cs.dart';
import 'toast_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CS Notifications Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('CS Notifications'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bildirim Sistemini Test Edin', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ToastTestPage()));
              },
              icon: const Icon(Icons.notification_important),
              label: const Text('Toast Sistemi Test'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size(250, 60),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Snackbar CS Test')),
                );
              },
              icon: const Icon(Icons.message),
              label: const Text('Snackbar Sistemi Test'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                minimumSize: const Size(250, 60),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Android Bottom Bar Test', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text(
                'Bu butonlara basarak snackbar\'ın Android\'in alt bar\'ının üstünde göründüğünü test edebilirsiniz:',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Success Snackbar
              ElevatedButton.icon(
                onPressed: () {
                  _counter++;
                  CSSnackbar.success(context, 'Başarılı! İşlem tamamlandı. Mesaj $_counter');
                },
                icon: const Icon(Icons.check_circle),
                label: const Text('Success Snackbar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                ),
              ),
              const SizedBox(height: 16),

              // Error Snackbar
              ElevatedButton.icon(
                onPressed: () {
                  _counter++;
                  CSSnackbar.error(context, 'Hata! Bir şeyler yanlış gitti. Mesaj $_counter');
                },
                icon: const Icon(Icons.error),
                label: const Text('Error Snackbar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                ),
              ),
              const SizedBox(height: 16),

              // Warning Snackbar
              ElevatedButton.icon(
                onPressed: () {
                  _counter++;
                  CSSnackbar.warning(context, 'Dikkat! Bu bir uyarı mesajıdır. Mesaj $_counter');
                },
                icon: const Icon(Icons.warning),
                label: const Text('Warning Snackbar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                ),
              ),
              const SizedBox(height: 16),

              // Info Snackbar
              ElevatedButton.icon(
                onPressed: () {
                  _counter++;
                  CSSnackbar.info(context, 'Bilgi: Bu bir bilgi mesajıdır. Mesaj $_counter');
                },
                icon: const Icon(Icons.info),
                label: const Text('Info Snackbar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                ),
              ),
              const SizedBox(height: 16),

              // Custom Snackbar with action
              ElevatedButton.icon(
                onPressed: () {
                  _counter++;
                  CSSnackbar.custom(
                    context,
                    message: 'Özel renk ve aksiyon ile mesaj $_counter',
                    backgroundColor: Colors.purple,
                    icon: Icons.star,
                    action: SnackBarAction(
                      label: 'GERI AL',
                      textColor: Colors.yellow,
                      onPressed: () {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(const SnackBar(content: Text('Geri alındı!'), duration: Duration(seconds: 1)));
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.star),
                label: const Text('Custom with Action'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                ),
              ),
              const SizedBox(height: 16),

              // Long message test
              ElevatedButton.icon(
                onPressed: () {
                  _counter++;
                  CSSnackbar.info(
                    context,
                    'Bu çok uzun bir mesajdır ve snackbar\'ın alt bar\'ın üstünde düzgün bir şekilde göründüğünü test etmek için kullanılır. Mesaj $_counter',
                  );
                },
                icon: const Icon(Icons.text_fields),
                label: const Text('Long Message Test'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                ),
              ),
              const SizedBox(height: 16),

              // Queue behavior test
              ElevatedButton.icon(
                onPressed: () {
                  // Show multiple snackbars in queue
                  CSSnackbar.success(context, 'Sıralı mesaj 1', queueBehavior: QueueBehavior.queue);
                  CSSnackbar.info(context, 'Sıralı mesaj 2', queueBehavior: QueueBehavior.queue);
                  CSSnackbar.warning(context, 'Sıralı mesaj 3', queueBehavior: QueueBehavior.queue);
                },
                icon: const Icon(Icons.queue),
                label: const Text('Queue Test (3 messages)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                ),
              ),
              const SizedBox(height: 16),

              // Stack behavior test
              ElevatedButton.icon(
                onPressed: () {
                  // Show multiple stacked snackbars
                  CSSnackbar.success(context, 'Üst üste mesaj 1', queueBehavior: QueueBehavior.stack);
                  CSSnackbar.error(context, 'Üst üste mesaj 2', queueBehavior: QueueBehavior.stack);
                  CSSnackbar.warning(context, 'Üst üste mesaj 3', queueBehavior: QueueBehavior.stack);
                },
                icon: const Icon(Icons.layers),
                label: const Text('Stack Test (3 messages)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                ),
              ),
              const SizedBox(height: 40),

              Text('Mesaj sayısı: $_counter', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  CSSnackbar.clearAll(context);
                  setState(() {
                    _counter = 0;
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, foregroundColor: Colors.white),
                child: const Text('Tümünü Temizle'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ayarlar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
