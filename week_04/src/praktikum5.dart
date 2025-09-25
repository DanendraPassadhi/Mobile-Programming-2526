void main() {
  // var record = ('first', a: 2, b: true, 'last');
  // print(record);

  // var record = (1, 2);
  // print(tukar(record));

  // Record type annotation in a variable declaration:
  // (String, int) mahasiswa = ('Danendra', 2341720144);
  // print(mahasiswa);

  var mahasiswa2 = ('Danendra', a: 2, b: true, 2341720144);

  print(mahasiswa2.$1);
  print(mahasiswa2.a); // Prints 2
  print(mahasiswa2.b); // Prints true
  print(mahasiswa2.$2);
}

// (int, int) tukar((int, int) record) {
//   var (a, b) = record;
//   return (b, a);
// }
