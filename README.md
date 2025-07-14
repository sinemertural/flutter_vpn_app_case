# 🌐 Flutter VPN App

Bu proje, Flutter ile geliştirilen bir VPN kullanıcı arayüzü simülasyonudur. Uygulama, kullanıcıların ülke listesi üzerinden VPN bağlantısı kurmasını ve bağlantı istatistiklerini görselleştirmesini sağlar. Gerçek VPN bağlantısı yerine mock veri üzerinden etkileşimler gerçekleştirilmiştir.

## 📸 Genel Özellikler

- Ücretsiz ülkeler listesine bağlanma / bağlantıyı kesme
- Gerçek zamanlı bağlantı süresi (HH:mm:ss)
- İndirme ve yükleme hızı simülasyonu
- Sinyal gücü animasyonu (%)
- Premium sunucular için erişim engeli simülasyonu
- Lottie tabanlı animasyonlar (bağlanırken / bağlantıyı keserken)
- Koyu / Açık tema desteği
- Responsive kullanıcı arayüzü

## 🧱 Proje Mimarisi

Uygulama, MVVM ve BLoC mimarisi ile organize edilmiştir.

### 📁 Dosya Yapısı

lib/
├── core/
│ └── theme/
│ └── app_theme.dart # Tema ayarları
├── data/
│ ├── entity/
│ │ ├── country.dart # Country veri modeli
│ │ └── connection_stats.dart # Bağlantı istatistik modeli
│ └── repository/
│ ├── mock_vpn_repository.dart # Mock veri sağlayıcı
│ └── vpn_repository.dart # Repository arayüzü
├── ui/
│ ├── cubit/
│ │ ├── base_page_cubit.dart
│ │ ├── home_page_cubit.dart
│ │ └── connection_selection_page_cubit.dart
│ ├── views/
│ │ ├── base_page.dart
│ │ ├── home_page.dart
│ │ └── country_selection_page.dart
│ └── widgets/
│ └── country_card.dart # Ülke kartı bileşeni
└── main.dart # Uygulama başlatıcısı


## 🛠 Teknik Detaylar

- **State Management**: `flutter_bloc`
- **Mock Veri**: `MockVpnRepository` üzerinden sağlanır
- **Bağlantı Akışı**:
  - Kullanıcı bir ülkeye bağlanır
  - Her saniye bağlantı süresi güncellenir (Timer)
  - Download / upload değerleri statik kalır
  - Bağlantı sonlandırıldığında değerler sıfırlanır
- **Tema Yönetimi**: `ThemeData` ile koyu / açık mod
- **Animasyon**: `Lottie` ile dinamik geçişler

## 📦 Kullanılan Paketler

| Paket             | Açıklama                            |
|------------------|-------------------------------------|
| flutter_bloc      | BLoC mimarisi için Cubit kullanımı  |
| lottie            | JSON tabanlı animasyonlar           |
| flutter           | UI, navigasyon, state, theme yönetimi |

## 🚀 Kurulum

- https://github.com/sinemertural/flutter_vpn_app_case.git
- cd vpn_app_case
- flutter pub get
- flutter run

📌 Notlar

- Bu proje, gerçek bir VPN bağlantısı sağlamaz.
- Uygulamanın amacı Flutter UI geliştirme, mimari yapı kurma ve state yönetimi pratiklerini göstermektir.
- Veriler MockVpnRepository sınıfı içinde sabitlenmiş örnek veri ile çalışır.

  
✍️ Bu uygulama, Flutter'da temiz kod, modüler yapı ve modern UI/UX uygulamalarını bir araya getirerek örnek bir case niteliğindedir. Uygulama geliştirme sürecinde ThemeData, Lottie, Cubit, Stream, Timer, BlocBuilder gibi pek çok Flutter özelliği etkili şekilde kullanılmıştır.

🧑‍💻 Developed by Sinem ERTURAL


