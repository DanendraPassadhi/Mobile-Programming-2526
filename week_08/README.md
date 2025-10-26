<h1 align="center">Laporan Praktikum Week 8</h1>
<h4>
Oleh: <br>

| Nama                     | Kelas | Absen |
| ------------------------ | ----- | ----- |
| Danendra Nayaka Passadhi | TI-3H | 07    |

## Praktikum 1
**Hasil Implementasi:**

<img src="./image/prototype1.gif" alt="Prototype GIF" width="200" />

## Praktikum 2
**Hasil Implementasi:**

<img src="./image/prototype2.gif" alt="Prototype GIF" width="200" />

## Tugas Praktikum
**Hasil Implementasi:**

<img src="./image/prototype3.gif" alt="Prototype GIF" width="200" />

### Jawaban Pertanyaan
1. Jelaskan maksud void async pada praktikum 1?
Maksudnya adalah digunakan untuk event handlers (contoh: tombol yang di klik) yang perlu melakukan task berat tanpa menunggu hasil. Jika dalam program, mengambil foto pada kamera membutuhkan waktu yang lama, sehingga menggunakan `async` agar UI tidaak *freeze*.

2. Jelaskan fungsi dari anotasi @immutable dan @override ?
    -  **@immutable**: Menandai bahwa method/property menimpa (override) definisi yang sama dari parent class atau interface. <br>
    Fungsi: <br>
    ↪ Memberitahu developer dan analyzer bahwa ini
    adalah override, bukan method baru. <br>
    ↪ Analyzer akan error jika Anda menandai
    @override tapi method itu tidak ada di parent
    (typo atau parent berbeda). <br>
    ↪ Meningkatkan readability sehingga membuat kode lebih
    jelas bahwa Anda mengubah perilaku yang sudah
    ada. 
    - **@override**: Menandai bahwa method/property menimpa (override) definisi yang sama dari parent class atau interface. <br>
    Fungsi:
    ↪ Memberitahu developer dan analyzer bahwa ini adalah override, bukan method baru. <br>
    ↪ Analyzer akan error jika Anda menandai `@override` tapi method itu **tidak ada** di parent (typo atau parent berbeda). <br>
    ↪ Meningkatkan readability sehingga membuat kode lebih jelas bahwa Anda mengubah perilaku yang sudah ada.