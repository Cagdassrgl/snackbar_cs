import 'package:flutter/material.dart';
import 'package:snackbar_cs/toast_cs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toast CS Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      home: const ToastTestPage(),
    );
  }
}

class ToastTestPage extends StatefulWidget {
  const ToastTestPage({super.key});

  @override
  State<ToastTestPage> createState() => _ToastTestPageState();
}

class _ToastTestPageState extends State<ToastTestPage> {
  ToastPosition _selectedPosition = ToastPosition.topRight;
  ToastAnimation _selectedAnimation = ToastAnimation.slideAndFade;
  int _messageCounter = 0;

  void _showToast(ToastType type, String message) {
    _messageCounter++;
    switch (type) {
      case ToastType.success:
        CSToast.success(context, '$message $_messageCounter', position: _selectedPosition);
        break;
      case ToastType.error:
        CSToast.error(context, '$message $_messageCounter', position: _selectedPosition);
        break;
      case ToastType.warning:
        CSToast.warning(context, '$message $_messageCounter', position: _selectedPosition);
        break;
      case ToastType.info:
        CSToast.info(context, '$message $_messageCounter', position: _selectedPosition);
        break;
    }
  }

  Widget _buildPositionButton(ToastPosition position, String label) {
    final isSelected = _selectedPosition == position;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedPosition = position;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.deepPurple : Colors.grey[300],
          foregroundColor: isSelected ? Colors.white : Colors.black87,
          minimumSize: const Size(100, 40),
        ),
        child: Text(label, textAlign: TextAlign.center),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: const Text('Toast CS Test')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Pozisyon Seçin:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // Top Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPositionButton(ToastPosition.topLeft, 'Sol Üst'),
                _buildPositionButton(ToastPosition.topCenter, 'Üst Orta'),
                _buildPositionButton(ToastPosition.topRight, 'Sağ Üst'),
              ],
            ),

            // Middle Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPositionButton(ToastPosition.centerLeft, 'Sol Orta'),
                _buildPositionButton(ToastPosition.center, 'Orta'),
                _buildPositionButton(ToastPosition.centerRight, 'Sağ Orta'),
              ],
            ),

            // Bottom Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPositionButton(ToastPosition.bottomLeft, 'Sol Alt'),
                _buildPositionButton(ToastPosition.bottomCenter, 'Alt Orta'),
                _buildPositionButton(ToastPosition.bottomRight, 'Sağ Alt'),
              ],
            ),

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            const Text('Animasyon Seçin:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Slide & Fade'),
                  selected: _selectedAnimation == ToastAnimation.slideAndFade,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedAnimation = ToastAnimation.slideAndFade;
                        CSToast.updateDefaultConfig(ToastConfig(animation: _selectedAnimation));
                      });
                    }
                  },
                ),
                ChoiceChip(
                  label: const Text('Slide'),
                  selected: _selectedAnimation == ToastAnimation.slide,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedAnimation = ToastAnimation.slide;
                        CSToast.updateDefaultConfig(ToastConfig(animation: _selectedAnimation));
                      });
                    }
                  },
                ),
                ChoiceChip(
                  label: const Text('Fade'),
                  selected: _selectedAnimation == ToastAnimation.fade,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedAnimation = ToastAnimation.fade;
                        CSToast.updateDefaultConfig(ToastConfig(animation: _selectedAnimation));
                      });
                    }
                  },
                ),
                ChoiceChip(
                  label: const Text('Scale'),
                  selected: _selectedAnimation == ToastAnimation.scale,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedAnimation = ToastAnimation.scale;
                        CSToast.updateDefaultConfig(ToastConfig(animation: _selectedAnimation));
                      });
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            const Text('Toast Tipleri:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Success Toast
            ElevatedButton.icon(
              onPressed: () => _showToast(ToastType.success, 'Başarılı!'),
              icon: const Icon(Icons.check_circle),
              label: const Text('Success Toast'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 12),

            // Error Toast
            ElevatedButton.icon(
              onPressed: () => _showToast(ToastType.error, 'Hata oluştu!'),
              icon: const Icon(Icons.error),
              label: const Text('Error Toast'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 12),

            // Warning Toast
            ElevatedButton.icon(
              onPressed: () => _showToast(ToastType.warning, 'Dikkat!'),
              icon: const Icon(Icons.warning),
              label: const Text('Warning Toast'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 12),

            // Info Toast
            ElevatedButton.icon(
              onPressed: () => _showToast(ToastType.info, 'Bilgi mesajı'),
              icon: const Icon(Icons.info),
              label: const Text('Info Toast'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            const Text('Özel Toast:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Custom Toast
            ElevatedButton.icon(
              onPressed: () {
                _messageCounter++;
                CSToast.custom(
                  context,
                  message: 'Özel renk ve ikon $_messageCounter',
                  backgroundColor: Colors.purple,
                  icon: Icons.star,
                  position: _selectedPosition,
                  showCloseButton: true,
                  onTap: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Toast\'a tıklandı!'), duration: Duration(seconds: 1)));
                  },
                );
              },
              icon: const Icon(Icons.star),
              label: const Text('Custom Toast (Kapatma butonu ile)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 12),

            // Long message toast
            ElevatedButton.icon(
              onPressed: () {
                _messageCounter++;
                CSToast.info(
                  context,
                  'Bu çok uzun bir toast mesajıdır ve birden fazla satıra sarmalanabilir. Test mesajı $_messageCounter',
                  position: _selectedPosition,
                );
              },
              icon: const Icon(Icons.text_fields),
              label: const Text('Uzun Mesaj Toast'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 12),

            // Multiple toasts
            ElevatedButton.icon(
              onPressed: () {
                final position = _selectedPosition;
                CSToast.success(context, 'İlk mesaj', position: position);
                Future.delayed(const Duration(milliseconds: 300), () {
                  if (mounted) CSToast.warning(context, 'İkinci mesaj', position: position);
                });
                Future.delayed(const Duration(milliseconds: 600), () {
                  if (mounted) CSToast.error(context, 'Üçüncü mesaj', position: position);
                });
              },
              icon: const Icon(Icons.layers),
              label: const Text('Çoklu Toast (3 adet)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: Text(
                    'Aktif Toast: ${CSToast.activeCount}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    CSToast.clearAll();
                    setState(() {
                      _messageCounter = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, foregroundColor: Colors.white),
                  child: const Text('Tümünü Temizle'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
