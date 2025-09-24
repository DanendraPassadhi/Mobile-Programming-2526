// Langkah 1
// void main() {
//   var list = [1, 2, 3];
//   assert(list.length == 3);
//   assert(list[1] == 2);
//   print(list.length);
//   print(list[1]);

//   list[1] = 1;
//   assert(list[1] == 1);
//   print(list[1]);
// }

// Langkah 2
void main() {
  final list = [null, 'Danendra', '2341720144', null, null];
  assert(list.length == 5);
  assert(list[1] == 'Danendra');
  print(list.length);
  print(list[1]);

  list[1] = '2341720144';
  assert(list[1] == '2341720144');
  print(list[1]);
}
