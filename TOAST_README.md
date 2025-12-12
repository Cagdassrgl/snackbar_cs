# Toast CS - Flexible Toast Notification System

`toast_cs` paketi, Flutter uygulamalarınız için esnek ve özelleştirilebilir toast bildirimleri sağlar.

## 🎯 Özellikler

### Pozisyon Seçenekleri
- ✅ **9 farklı pozisyon**: Sol üst, üst orta, sağ üst, sol orta, orta, sağ orta, sol alt, alt orta, sağ alt
- ✅ **Safe area uyumlu**: Notch, status bar ve navigation bar ile uyumlu

### Animasyon Seçenekleri
- ✅ **Fade**: Belirme/Kaybolma
- ✅ **Slide**: Kaydırma
- ✅ **Scale**: Büyüme/Küçülme
- ✅ **SlideAndFade**: Kaydırma ve belirme kombinasyonu

### Toast Tipleri
- ✅ **Success**: Yeşil arka plan, onay ikonu
- ✅ **Error**: Kırmızı arka plan, hata ikonu
- ✅ **Warning**: Turuncu arka plan, uyarı ikonu
- ✅ **Info**: Mavi arka plan, bilgi ikonu
- ✅ **Custom**: Özel renk, ikon ve davranış

### Diğer Özellikler
- ✅ Otomatik kapatma (özelleştirilebilir süre)
- ✅ Kapatma butonu (opsiyonel)
- ✅ Tıklanabilir toast'lar
- ✅ Çoklu toast desteği
- ✅ Elevation ve border radius özelleştirmesi
- ✅ Max genişlik kontrolü

## 📦 Kurulum

```yaml
dependencies:
  snackbar_cs: ^latest_version
```

## 🚀 Kullanım

### Basit Kullanım

```dart
import 'package:snackbar_cs/toast_cs.dart';

// Success toast (sağ üst köşede)
CSToast.success(context, 'İşlem başarılı!');

// Error toast
CSToast.error(context, 'Bir hata oluştu!');

// Warning toast
CSToast.warning(context, 'Dikkat gerekli!');

// Info toast
CSToast.info(context, 'Bilgilendirme mesajı');
```

### Pozisyon Belirtme

```dart
// Sol üst köşede göster
CSToast.success(
  context,
  'Başarılı!',
  position: ToastPosition.topLeft,
);

// Alt ortada göster
CSToast.error(
  context,
  'Hata!',
  position: ToastPosition.bottomCenter,
);

// Ekranın tam ortasında göster
CSToast.info(
  context,
  'Bilgi',
  position: ToastPosition.center,
);
```

### Özel Toast

```dart
CSToast.custom(
  context,
  message: 'Özel mesaj',
  backgroundColor: Colors.purple,
  textColor: Colors.white,
  icon: Icons.star,
  position: ToastPosition.topRight,
  showCloseButton: true,
  duration: Duration(seconds: 5),
  onTap: () {
    print('Toast\'a tıklandı!');
  },
);
```

### Detaylı Özelleştirme

```dart
CSToast.show(
  context,
  message: 'Detaylı toast',
  type: ToastType.success,
  position: ToastPosition.topRight,
  animation: ToastAnimation.slideAndFade,
  duration: Duration(seconds: 4),
  backgroundColor: Colors.green,
  textColor: Colors.white,
  showIcon: true,
  showCloseButton: true,
  elevation: 8.0,
  borderRadius: 16.0,
  maxWidth: 400.0,
  onTap: () {
    print('Tıklandı!');
  },
  onDismiss: () {
    print('Kapatıldı!');
  },
);
```

### Global Yapılandırma

```dart
// Tüm toast'lar için varsayılan ayarları belirle
CSToast.updateDefaultConfig(
  ToastConfig(
    duration: Duration(seconds: 4),
    position: ToastPosition.topCenter,
    animation: ToastAnimation.slideAndFade,
    showIcon: true,
    showCloseButton: false,
    elevation: 6.0,
    borderRadius: 12.0,
  ),
);
```

### Toast Yönetimi

```dart
// Aktif toast sayısını öğren
int count = CSToast.activeCount;

// Tüm toast'ları kapat
CSToast.clearAll();
```

## 📍 Tüm Pozisyonlar

```dart
enum ToastPosition {
  topLeft,       // Sol üst
  topCenter,     // Üst orta
  topRight,      // Sağ üst
  centerLeft,    // Sol orta
  center,        // Tam orta
  centerRight,   // Sağ orta
  bottomLeft,    // Sol alt
  bottomCenter,  // Alt orta
  bottomRight,   // Sağ alt
}
```

## 🎬 Animasyon Tipleri

```dart
enum ToastAnimation {
  fade,          // Belirme/kaybolma
  slide,         // Kaydırma
  scale,         // Büyüme/küçülme
  slideAndFade,  // Kaydırma + belirme (varsayılan)
}
```

## 💡 İpuçları

1. **Pozisyon seçimi**: Uygulamanızın UI düzenine göre en uygun pozisyonu seçin
2. **Süre ayarı**: Önemli mesajlar için daha uzun süre kullanın
3. **Çoklu toast**: Birden fazla toast gösterecekseniz farklı pozisyonlar kullanın
4. **Kapatma butonu**: Uzun mesajlar için kapatma butonunu aktif edin
5. **Animasyon**: Pozisyona göre uygun animasyon seçin (üst pozisyonlar için slide ideal)

## 🧪 Test

Example uygulamayı çalıştırın:

```bash
cd example
flutter run
```

Uygulamada:
- 9 farklı pozisyonu test edebilirsiniz
- 4 farklı animasyon tipini deneyebilirsiniz
- Tüm toast tiplerini görebilirsiniz
- Özel toast'ları test edebilirsiniz

## 📱 Desteklenen Platformlar

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Desktop (Windows, macOS, Linux)

## 🤝 Katkıda Bulunma

Pull request'ler memnuniyetle karşılanır! Büyük değişiklikler için lütfen önce bir issue açın.

## 📄 Lisans

MIT License
