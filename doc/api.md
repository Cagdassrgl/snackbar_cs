## Snackbar CS API Dokümantasyonu

### CSSnackbar Sınıfı

Ana snackbar sınıfı - Tüm snackbar işlemlerini yönetir

#### Statik Metodlar

##### 1. success()

Başarı mesajı gösterir (yeşil arka plan, check icon)

```dart
CSSnackbar.success(
  BuildContext context,
  String message, {
  Duration? duration,
  TextStyle? textStyle,
  bool? showIcon,
  VoidCallback? onVisible,
  SnackBarAction? action,
})
```

##### 2. error()

Hata mesajı gösterir (kırmızı arka plan, error icon)

```dart
CSSnackbar.error(
  BuildContext context,
  String message, {
  Duration? duration,
  TextStyle? textStyle,
  bool? showIcon,
  VoidCallback? onVisible,
  SnackBarAction? action,
})
```

##### 3. warning()

Uyarı mesajı gösterir (turuncu arka plan, warning icon)

```dart
CSSnackbar.warning(
  BuildContext context,
  String message, {
  Duration? duration,
  TextStyle? textStyle,
  bool? showIcon,
  VoidCallback? onVisible,
  SnackBarAction? action,
})
```

##### 4. info()

Bilgi mesajı gösterir (mavi arka plan, info icon)

```dart
CSSnackbar.info(
  BuildContext context,
  String message, {
  Duration? duration,
  TextStyle? textStyle,
  bool? showIcon,
  VoidCallback? onVisible,
  SnackBarAction? action,
})
```

##### 5. custom()

Özel renkler ve icon ile snackbar gösterir

```dart
CSSnackbar.custom(
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
})
```

##### 6. show()

Tam kontrol ile snackbar gösterir

```dart
CSSnackbar.show(
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
})
```

##### 7. hide()

Mevcut snackbar'ı gizler

```dart
CSSnackbar.hide(BuildContext context)
```

##### 8. clearAll()

Tüm snackbar'ları temizler

```dart
CSSnackbar.clearAll(BuildContext context)
```

##### 9. updateDefaultConfig()

Global varsayılan konfigürasyonu günceller

```dart
CSSnackbar.updateDefaultConfig(SnackbarConfig config)
```

### SnackbarType Enum

Önceden tanımlı snackbar tipleri

```dart
enum SnackbarType {
  success(Color(0xFF4CAF50), Icons.check_circle),
  error(Color(0xFFF44336), Icons.error),
  warning(Color(0xFFFF9800), Icons.warning),
  info(Color(0xFF2196F3), Icons.info);
}
```

**Özellikler:**

- `color`: Tip için varsayılan arka plan rengi
- `icon`: Tip için varsayılan icon

### SnackbarConfig Sınıfı

Snackbar görünüm ve davranış konfigürasyonu

```dart
class SnackbarConfig {
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
}
```

**Özellikler:**

- `duration`: Snackbar gösterim süresi
- `showCloseIcon`: Kapatma iconunu göster/gizle
- `showIcon`: Tip iconunu göster/gizle
- `elevation`: Snackbar yüksekliği
- `margin`: Snackbar etrafındaki boşluk
- `padding`: Snackbar içindeki boşluk
- `borderRadius`: Köşe yuvarlaklığı
- `textStyle`: Metin stili
- `behavior`: Floating veya fixed davranış
- `dismissDirection`: Kaydırma yönü
- `onVisible`: Görünür olduğunda çağrılan callback

### Kullanım Örnekleri

#### Temel Kullanım

```dart
// Başarı mesajı
CSSnackbar.success(context, 'İşlem başarılı!');

// Hata mesajı
CSSnackbar.error(context, 'Bir hata oluştu!');

// Uyarı mesajı
CSSnackbar.warning(context, 'Dikkat!');

// Bilgi mesajı
CSSnackbar.info(context, 'Bilgi mesajı');
```

#### Action Buton ile

```dart
CSSnackbar.warning(
  context,
  'Bu işlem geri alınamaz!',
  action: SnackBarAction(
    label: 'GERİ AL',
    onPressed: () {
      // Geri alma işlemi
    },
  ),
);
```

#### Özel Süre

```dart
CSSnackbar.success(
  context,
  'Başarılı!',
  duration: Duration(seconds: 5),
);
```

#### İkonsuz

```dart
CSSnackbar.info(
  context,
  'İkonsuz mesaj',
  showIcon: false,
);
```

#### Özel Snackbar

```dart
CSSnackbar.custom(
  context,
  message: 'Özel mesaj',
  backgroundColor: Colors.purple,
  icon: Icons.star,
  textColor: Colors.white,
);
```

#### Global Konfigürasyon

```dart
CSSnackbar.updateDefaultConfig(
  SnackbarConfig(
    duration: Duration(seconds: 4),
    elevation: 10.0,
    borderRadius: 12.0,
    behavior: SnackBarBehavior.fixed,
  ),
);
```

### İpuçları

1. **Context Kullanımı**: Snackbar göstermek için `BuildContext` gereklidir
2. **Async İşlemler**: Async işlemlerde context'in hala geçerli olduğundan emin olun
3. **Ardışık Mesajlar**: Yeni snackbar otomatik olarak eskisini değiştirir
4. **Performance**: Snackbar'lar lightweight'tır, performance endişesi yoktur
5. **Accessibility**: Flutter'ın built-in accessibility desteği kullanılır

### Sınırlamalar

1. **Platform**: Flutter'ın desteklediği tüm platformlarda çalışır
2. **Tema**: Material Design temasını kullanır
3. **Context**: Scaffold içerisinde kullanılmalıdır
4. **Null Safety**: Tam null safety desteği vardır
