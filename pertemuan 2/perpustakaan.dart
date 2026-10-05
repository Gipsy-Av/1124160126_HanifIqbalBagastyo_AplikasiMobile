// =============================================
// HW 2 - Computational Thinking dengan Dart
// Nama : Hanif Iqbal Bagastyo
// NIM  : 1124160126
// Kelas: TI 24M SE
// Studi Kasus: Perpustakaan
// =============================================

// ---------- ABSTRACTION ----------

// Status ketersediaan buku
enum StatusBuku {
  tersedia,
  dipinjam,
}

// Model Data Mahasiswa
class Mahasiswa {
  String id;
  String nama;

  Mahasiswa(this.id, this.nama);
}

// Model Data Buku
class Buku {
  String id;
  String judul;
  StatusBuku status;

  Buku(this.id, this.judul, {this.status = StatusBuku.tersedia});
}

// Model Transaksi Peminjaman
class Transaksi {
  String idPinjam;
  String idMahasiswa;
  String idBuku;
  DateTime tglPinjam;
  DateTime tglJatuhTempo;
  DateTime? tglKembali;
  int denda;

  Transaksi({
    required this.idPinjam,
    required this.idMahasiswa,
    required this.idBuku,
    required this.tglPinjam,
    required this.tglJatuhTempo,
    this.tglKembali,
    this.denda = 0,
  });
}

// ---------- DATA STORAGE ----------

List<Mahasiswa> dataMahasiswa = [
  Mahasiswa('S01', 'Hanif Iqbal Bagastyo'),
  Mahasiswa('S02', 'Azmi'),
];

List<Buku> dataBuku = [
  Buku('B01', 'Pemrograman Dart'),
  Buku('B02', 'Struktur Data'),
  Buku('B03', 'Basis Data'),
  Buku('B04', 'Pemrograman Web'),
];

List<Transaksi> listTransaksi = [];

// ---------- DECOMPOSITION ----------

// Mencari data mahasiswa berdasarkan ID
Mahasiswa? cariMahasiswa(String id) {
  for (var m in dataMahasiswa) {
    if (m.id == id) return m;
  }
  return null;
}

// Mencari data buku berdasarkan ID
Buku? cariBuku(String id) {
  for (var b in dataBuku) {
    if (b.id == id) return b;
  }
  return null;
}

// BR-01: Menghitung total buku yang sedang dipinjam mahasiswa
int hitungBukuDipinjam(String idMahasiswa) {
  int total = 0;
  for (var t in listTransaksi) {
    if (t.idMahasiswa == idMahasiswa && t.tglKembali == null) {
      total++;
    }
  }
  return total;
}

// BR-02: Mengecek ketersediaan status buku
bool cekKetersediaan(Buku buku) {
  return buku.status == StatusBuku.tersedia;
}

// BR-03: Menghitung denda keterlambatan (Rp1.000 / hari)
int hitungDenda(DateTime jatuhTempo, DateTime tglKembali) {
  int selisih = tglKembali.difference(jatuhTempo).inDays;
  if (selisih > 0) {
    return selisih * 1000;
  }
  return 0;
}

// ---------- ALGORITMA UTAMA ----------

// Fungsi Peminjaman Buku (Guard Clause Style)
String pinjamBuku(String idMahasiswa, String idBuku, DateTime tglPinjam) {
  var mhs = cariMahasiswa(idMahasiswa);
  if (mhs == null) {
    return 'Gagal: Mahasiswa tidak ditemukan.';
  }

  var buku = cariBuku(idBuku);
  if (buku == null) {
    return 'Gagal: Buku tidak ditemukan.';
  }

  // BR-02: Cek apakah buku sedang dipinjam
  if (!cekKetersediaan(buku)) {
    return 'Gagal: Buku sedang dipinjam.';
  }

  // BR-01: Cek batas maksimal 3 buku dipinjam
  if (hitungBukuDipinjam(idMahasiswa) >= 3) {
    return 'Gagal: Maksimal pinjam 3 buku.';
  }

  // Menentukan tanggal jatuh tempo (7 hari dari pinjam)
  DateTime jatuhTempo = tglPinjam.add(Duration(days: 7));
  String idPinjam = 'TRX-${listTransaksi.length + 1}';

  listTransaksi.add(
    Transaksi(
      idPinjam: idPinjam,
      idMahasiswa: idMahasiswa,
      idBuku: idBuku,
      tglPinjam: tglPinjam,
      tglJatuhTempo: jatuhTempo,
    ),
  );

  buku.status = StatusBuku.dipinjam;
  return 'Berhasil meminjam buku: ${buku.judul}';
}

// Fungsi Pengembalian Buku
String kembalikanBuku(String idMahasiswa, String idBuku, DateTime tglKembali) {
  Transaksi? trx;
  for (var t in listTransaksi) {
    if (t.idMahasiswa == idMahasiswa && t.idBuku == idBuku && t.tglKembali == null) {
      trx = t;
      break;
    }
  }

  if (trx == null) {
    return 'Gagal: Data peminjaman tidak ditemukan.';
  }

  trx.tglKembali = tglKembali;

  // BR-03: Hitung denda jika ada
  int denda = hitungDenda(trx.tglJatuhTempo, tglKembali);
  trx.denda = denda;

  var buku = cariBuku(idBuku);
  if (buku != null) {
    buku.status = StatusBuku.tersedia;
  }

  if (denda > 0) {
    return 'Pengembalian berhasil. Denda: Rp$denda';
  } else {
    return 'Pengembalian berhasil. Tidak ada denda.';
  }
}

// ---------- MAIN & TEST SCENARIOS ----------

void main() {
  DateTime hariIni = DateTime(2026, 10, 1);

  print('=== UJI COBA SYSTEM PERPUSTAKAAN ===\n');

  // Skenario 1: Peminjaman Berhasil
  print('1. Hanif meminjam buku B01:');
  print(pinjamBuku('S01', 'B01', hariIni));

  // Skenario 2 (BR-02): Percobaan pinjam buku yang sedang dipinjam
  print('\n2. Azmi mencoba meminjam buku B01 (BR-02):');
  print(pinjamBuku('S02', 'B01', hariIni));

  // Hanif meminjam buku ke-2 dan ke-3
  pinjamBuku('S01', 'B02', hariIni);
  pinjamBuku('S01', 'B03', hariIni);

  // Skenario 3 (BR-01): Meminjam lebih dari batas maksimal 3 buku
  print('\n3. Hanif mencoba meminjam buku ke-4 / B04 (BR-01):');
  print(pinjamBuku('S01', 'B04', hariIni));

  // Skenario 4 (BR-03): Pengembalian keterlambatan 3 hari
  // (Jatuh tempo: 8 Okt 2026, Dikembalikan: 11 Okt 2026 -> Denda Rp3.000)
  print('\n4. Hanif mengembalikan buku B01 terlambat 3 hari (BR-03):');
  print(kembalikanBuku('S01', 'B01', DateTime(2026, 10, 11)));

  // Skenario 5: Pengembalian tepat waktu
  print('\n5. Hanif mengembalikan buku B02 tepat waktu:');
  print(kembalikanBuku('S01', 'B02', DateTime(2026, 10, 7)));
}