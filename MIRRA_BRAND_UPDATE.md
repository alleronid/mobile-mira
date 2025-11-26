# Update Branding Mirra - ReadyPOS Flutter

## Perubahan yang Dilakukan

### 1. Skema Warna Baru
File: `/app/lib/config/app_color.dart`

**Warna Baru:**
- **Primary Color (Biru Mirra):** `#1565C0`
- **Secondary Color (Kuning Mirra):** `#FFD32D`
- **Accent Yellow:** `#FFD32D`

Warna ini sekarang digunakan di seluruh aplikasi untuk:
- Button primary
- Text field focus border
- Accent elements
- Brand highlights

### 2. Logo Baru dengan Tagline
Files: 
- `/app/assets/svgs/logoblack.svg` (Light Mode)
- `/app/assets/svgs/logowhite.svg` (Dark Mode)

**Karakteristik Logo:**
- Huruf "M" berwarna **kuning (#FFD32D)**
- Huruf "irra" berwarna **biru (#1565C0)** untuk light mode, **putih** untuk dark mode
- Tagline: **"TEMAN SETIA USAHA ANDA"** ditampilkan di sebelah kanan logo
- Ukuran: 280x70 pixels (responsive dengan ScreenUtil)

### 3. UI Components Updated

#### Splash Screen (`/app/lib/views/splash/layouts/splash_layout.dart`)
- Logo diposisikan di center screen
- Size: 60h x 280w (responsive)
- Animasi slide dan fade in tetap smooth
- Tagline sudah include dalam logo SVG

#### Login Screen (`/app/lib/views/auth/components/loginBG.dart`)
- Logo di header dengan size disesuaikan
- Background tetap dengan ilustrasi existing
- Warna button login menggunakan biru Mirra baru

#### Buttons & Form Elements
- Semua button otomatis menggunakan `primaryColor` baru (biru Mirra)
- Text field focus border menggunakan warna biru Mirra
- Accent elements menggunakan kuning untuk highlight

### 4. Dark Mode Support
- Logo white version untuk dark mode (huruf "M" tetap kuning, "irra" putih)
- Warna tetap konsisten di kedua mode
- Tagline berwarna putih di dark mode

## Testing
Untuk test perubahan:
1. Build dan run aplikasi: `flutter run`
2. Check splash screen - logo dan tagline harus muncul
3. Check login screen - logo dengan warna baru
4. Check buttons - warna biru baru
5. Toggle dark mode - logo white version harus muncul

## Notes
- Semua perubahan menggunakan AppColor constants, jadi mudah untuk adjust
- Logo SVG lightweight dan scalable
- Responsive design dengan flutter_screenutil
- Backward compatible dengan struktur existing

## Warna Referensi
```dart
primaryColor: Color(0xff1565C0)    // Biru Mirra
secondaryColor: Color(0xffFFD32D)  // Kuning Mirra
```
