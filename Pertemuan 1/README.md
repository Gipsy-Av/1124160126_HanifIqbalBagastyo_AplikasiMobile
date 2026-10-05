# Latihan Dasar Dart - Pertemuan 1

**Nama:** Hanif Iqbal Bagastyo {Hazuto}  
**NIM:** 1124160126  
**Mata Kuliah:** Aplikasi Mobile

```dart
void main() {
  String karakter = 'Hazuto';
  int id = 123456789;
  double level = 99.5;
  bool aktif = true;

  print('Karakter: $karakter | ID: $id | Level: $level | Aktif: $aktif');

  String? jurus;
  String status = jurus ?? 'Belum ada jurus';

  jurus = 'Pukulan Petir';
  String? temp = jurus;
  String teks = temp!.toUpperCase();

  print('Status: $status');
  print('Jurus: $teks');

  final DateTime waktu = DateTime.now();
  const double critical = 0.11; 

  print('Waktu: $waktu | Critical Rate: $critical');

  late int umur;
  umur = 103;

  print('Umur: $umur tahun');

  num poin = 999.5;
  List<String> skill = ['Teleport', 'Sihir Api'];
  Set<String> hobi = {'Bertarung', 'Tidur'};
  Map<String, dynamic> profil = {
    'nama': karakter,
    'id': id,
    'umur': umur,
  };
  Object senjata = 'Pedang';
  dynamic koin = 10000;

  print('Poin: $poin');
  print('Skill Utama: ${skill[0]} | Hobi: $hobi');
  print('Profil: ${profil['nama']}');
  print('Senjata: $senjata | Koin: $koin');
}

```
