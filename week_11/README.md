<h1 align="center">Laporan Praktikum Week 12 <br> 
<code>Streams</code>
</h1>
<h4>
Oleh: <br>

| Nama                     | Kelas | Absen |
| ------------------------ | ----- | ----- |
| Danendra Nayaka Passadhi | TI-3H | 07    |

## Tugas Praktikum 1: <br> `Dart Streams`

> **Soal 1** <br>
> Tambahkan nama panggilan Anda pada title app sebagai identitas hasil pekerjaan Anda.

```Dart
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Danenn',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const StreamHomePage(),
    );
  }
```

> **Soal 2** <br>
> Tambahkan 5 warna lainnya sesuai keinginan Anda pada variabel colors tersebut.

```Dart
  final List<Color> colors = [
    Colors.blueGrey,
    Colors.amber,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.teal,
    Colors.indigo,
    Colors.cyan,
    Colors.lime,
    Colors.pink,
    Colors.orange,
  ];
```

> **Soal 3** <br>
>
> - Jelaskan fungsi keyword yield\* pada kode tersebut!

↪ yield\* digunakan untuk mendelegasikan keluaran (delegate the output) dari generator function saat ini ke generator lain atau Stream atau Iterable. Pada kode program, generator akan menghasilkan elemen (warna) bukan satu per satu menggunakan yield, tetapi secara otomatis meneruskan semua elemen yang datang.

> - Apa maksud isi perintah kode tersebut?

↪ yield\*: Seperti dijelaskan di atas, ini adalah keyword yang mendelegasikan keluaran Stream ke fungsi generator saat ini. <br>
↪ Stream.periodic(const Duration(seconds: 1), (int t) { ... });: Menciptakan sebuah Stream tak terbatas yang menghasilkan event (warna) secara berulang. <br>
↪ int index = t % colors.length;: Menghitung indeks warna secara berputar (0, 1, 2, 0, 1, 2,...) sehingga daftar colors diulang terus-menerus. <br>
↪ return colors[index];: Mengambil elemen (warna) dari daftar colors pada index yang telah dihitung dan menjadikannya sebagai peristiwa yang dihasilkan oleh Stream.periodic.

> **Soal 4** <br>
> Capture hasil praktikum Anda berupa GIF dan lampirkan di README.

<img src="./image/p1-1.gif" alt="Prototype GIF" width="200" />

> **Soal 5** <br>
> Jelaskan perbedaan menggunakan listen dan await for (langkah 9) !

| **Fitur** | **`Stream.listen()`** | **`await for`** |
| --- | --- | --- |
| **Aliran Kontrol** | Non-blokir (Fire and Forget) | Blokir (Menunggu setiap event secara berurutan) |
| **Diperlukan `async`** | Tidak | Ya, harus berada di fungsi `async` |
| **Pengelolaan Langganan** | Manual (Perlu .cancel() di dispose()) | Otomatis (Berhenti saat Stream selesai/fungsi dibatalkan) |
| **Kapan Digunakan** | Untuk Stream yang berjalan lama/latar belakang, atau di widget state. | Untuk memproses Stream secara berurutan hingga selesai dalam satu scope. |

---

## Tugas Praktikum 2: <br> `Stream controllers dan sinks`

> **Soal 6** <br>
> Jelaskan maksud kode langkah 8 dan 10 tersebut!
↪ Langkah 8 bermaksud untuk menginisialisasi Stream, mulai berlangganan (subscribe) untuk menerima angka baru, dan memastikan antarmuka pengguna (UI) diperbarui setiap kali ada angka baru yang masuk. <br>
↪ Langkah 10 bermaksud untuk mendefinisikan cara untuk membuat angka acak baru dan memasukkannya ke dalam Stream. Setelah angka ini dikirim, callback stream.listen() pada Langkah 8 akan langsung menangkapnya dan memperbarui UI.

> Capture hasil praktikum Anda berupa GIF dan lampirkan di README.

<img src="./image/p2-1.gif" alt="Prototype GIF" width="200" />