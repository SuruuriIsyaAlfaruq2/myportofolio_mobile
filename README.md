# Aplikasi Mobile Personal Portofolio Berbasis Flutter

## Dibuat oleh
- **Nama:** Suruuri Isya Alfaruq
- **NPM:** 2506548080
- **Kelas:** PBP E

## Deskripsi Aplikasi

MyPortfolio Mobile adalah aplikasi Flutter untuk menampilkan informasi singkat pemilik portofolio dan menyediakan menu menuju bagian portofolio seperti pengalaman, keterampilan, dan pendidikan. Aplikasi menggunakan Material Design dan menyediakan umpan balik berupa SnackBar saat tombol menu ditekan.

Saat ini, tombol menu masih berupa prototipe interaktif: ketika ditekan, aplikasi menampilkan SnackBar dan belum mengelola atau menyimpan data portofolio.

## Struktur Aplikasi

Aplikasi disusun menggunakan widget Flutter:

1. **`lib/main.dart`**
   - Menjadi titik masuk aplikasi dan menjalankan `MyApp`.
   - Mengatur `MaterialApp`, tema, dan warna aplikasi.
2. **`lib/menu.dart`**
   - Menyusun halaman utama, kartu informasi pemilik portofolio, tombol portofolio, dan menu pengalaman, keterampilan, serta pendidikan.
   - Menangani interaksi tombol dan menampilkan SnackBar.
3. **`lib/theme_colors.dart`**
   - Menyediakan palet warna yang digunakan pada tema dan elemen antarmuka.

## Fitur

- Menampilkan NPM, nama, dan kelas pemilik portofolio.
- Menampilkan tombol untuk melihat portofolio.
- Menampilkan menu untuk melihat dan menambah pengalaman, keterampilan, dan pendidikan.
- Menampilkan konfirmasi SnackBar ketika tombol ditekan.
- Menyediakan tombol logout sebagai elemen antarmuka.

## Panduan Setup dan Instalasi Lokal

### Prasyarat

Pastikan perangkat Anda telah memasang:

- **Flutter SDK** yang kompatibel dengan batas SDK proyek (`Dart ^3.13.7`).
- **Git**.
- Emulator Android atau perangkat Android yang terhubung. Untuk menjalankan di platform lain, pastikan platform tersebut didukung oleh Flutter.

Periksa instalasi Flutter dengan perintah:

```bash
flutter doctor
```

### Menjalankan Aplikasi

1. Klon repositori dan masuk ke direktori proyek:

   ```bash
   git clone <URL_REPOSITORI>
   cd myportofolio_mobile
   ```

2. Pasang dependensi:

   ```bash
   flutter pub get
   ```

3. Pastikan emulator atau perangkat telah terdeteksi:

   ```bash
   flutter devices
   ```

4. Jalankan aplikasi:

   ```bash
   flutter run
   ```

## Pengelolaan Konten

Informasi pemilik portofolio dan daftar menu saat ini ditentukan langsung di `lib/menu.dart`. Untuk mengubah warna aplikasi, sesuaikan nilai pada `lib/theme_colors.dart`. Tombol-tombol menu belum terhubung ke penyimpanan atau operasi tambah, ubah, dan hapus data.

## Menjalankan Pengujian

Jalankan pengujian Flutter dengan perintah:

```bash
flutter test
```

## Tugas

### Tugas 7

1. 
    - Widget Tree adalah struktur hierarki (induk-anak) yang menggambarkan tampilan dan konfigurasi antarmuka pengguna.
    - Hubungan Induk-anak:
        a. Root: Widget Utama yang membungkus seluruh komponen di bawahnya
        b. Parent: Widget pengatur konfigurasi/konteks untuk anak-anaknya
        c. Child: Mewarisi konfigurasi/konteks dari parentnya. Tidak bisa mengubah Parent. Bisa menjadi parent untuk child di bawahnya
2. Daftar Widget:
    1. MyApp: Widget Root dan berfungsi mengatur konfigurasi utama aplikasi
    2. MaterialApp: Mengatur ColoScheme dn Mengarahkan ke Hompage
    3. MyHomePage: Menampung semua Widget Utama Aplikasi 
    4. Scaffold: Widget bawaan yang menyediakan fitur-fitur Widget yang dibutuhkan sperti Appbar, dan Body
    5. AppBar: Widget Header untuk menampilkan judul Aplikasi
    6. Text: Menampilkan String
    7. Padding: Mengatur jarak di sekeliling Widget
    8. SingleChildScrollView: Pembungkus yang memungkinkan elemen di dalamnya untuk di-scroll
    9. Column: Mengatur Widget secara Vertikal Atas-Bawah
    10. Row: Mengatur Widget secara Horizontal Kanan-Kiri
    11. InfoCard: Widget Custom untuk menampilkan informasi Text
    12. Card: Widget kartu sebagai tampungan
    13. Container: Pengatur Ukuran, padding, dan Child
    14. SizedBox: Pemisah (memberi jarak) horizontal 
    15. GridView: Menyusun Card dalam bentuk grid
    16. ItemCard: Custom Widget untuk render tombol interaktif berdasarkan ItemHomePage
    17. Material: Mengatur latar belakang warna dan border radius 
    18. InkWell: Widget untuk interaksi tombol dan menampilkan efek
    19. Center: Mengatur widget anak supaya center
    20. Icon: Menampilkan Icon sesuai kebutuhan 
    21. Flexible: Supaya teks pada tombol tidak overflow
3. 
    - MaterialApp berfungsi sebagai pembungkus yang menyediakan infrastruktur dasar aplikasi seperti konfigurasi theme dan routing aplikasi
    - MaterialApp menjadi root karena beberapa Widget membutuhkan konteks untuk pembentukannya, dan MaterialApp menyplai konteks tersebut 
4. 
    - Stateless Widget adalah Widget yang tidak memiliki state internal yang dapat berubah, bersifat statis dan immutable (variabel final), dan hanya rebuild ketika ada data/properti dari parent berubah. Stateless cocok digunakan pada elemen yang tidak berubah karena interaksi pengguna. Contoh: elemen card info dan judul aplikasi
    - Stateful Widget adalag widget yang memiliki state internal yang dapat berubah seiring lifetime-nya, mutable, dan dapat rwbuild kapan saja. Stateful cocok untuk elemen yang berubah ketika ada interaksi pengguna. Contoh: Tombol counter, Input Form, dan tabel data yang bisa diubah pengguna
5. BuildContext adalah objek yang merepresentasikan posisi/lokasi suatu widget di dalam struktur WidgetTree. BuildContex penting karena merupakan cara sebuah child untuk mengakses widget yang berada pada posisi yang lebih tinggi, yang biasanya tidak bisa diakses oleh sebuah child. BuildContext menerima variabel context di dalam metode build, yang kemudian digunakan untuk mengakses konfigurasi dari context tersebut. Contoh: Theme.of(context).colorScheme.primary yang mengakses tema dari context yang diterima.
6. 
    - Hot Reload: Fitur unggulan Flutter berbasis Dart JIT (Just-In-Time) compiler yang menyuntikkan kode baru yang baru saja diubah langsung ke dalam Dart Virtual Machine (VM). Tampilan UI akan langsung ter-rebuild tanpa kehilangan atau reset state aplikasi (preserves app state) dan tanpa menjalankan ulang fungsi main() atau initState().
    - Berbeda dengan Hot Restart, Hot Reload rebuild tanpa reset state aplikasi dan menjalankan ulang main() atau initState(). Sedangkan Hot Restart Restart Aplikasi dari awal, reset aplikasi ke state awal, menjalankan kembali main(), serta Rebuild ulang.
    - Pada beberapa kasus, penggunaan Hot Reload tidak cukup dan membutuhkan Hot Restart. Beberapa contoh kasus sebagai berikut:
        a. Perubahan pada method main() atau initState() yang tidak dieksekusi oleh Hot Reload
        b. Penambahan aset baru seperti gambar/font import baru
        c. Perubahan pada tipe data global dari final menjadi non-final

## AI Disclosure


| Tugas | Deskripsi penggunaan AI | Tautan percakapan AI |
|---|---|---|
| Tugas 7 | Membantu membuat layout pilihan dan membuat panduan setup dan instalasi lokal pada Readme.MD | [Gemini](https://share.gemini.google/yucV2D2NP7sS) |
