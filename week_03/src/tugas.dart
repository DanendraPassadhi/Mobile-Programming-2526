void main() {
  String namaLengkap = "Danendra Nayaka Passadhi";
  String nim = "2341720144";

  print("Mencari bilangan prima antara 0 dan 201:");
  print("----------------------------------------");

  for (int i = 0; i <= 201; i++) {
    if (isPrima(i)) {
      print('$i $namaLengkap ($nim)');
    } else {
      print('$i');
    }
  }
}

bool isPrima(int n) {
  if (n <= 1) {
    return false;
  }
  for (int i = 2; i * i <= n; i++) {
    if (n % i == 0) {
      return false;
    }
  }
  return true;
}