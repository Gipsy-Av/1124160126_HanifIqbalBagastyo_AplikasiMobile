### Tabel Traceability (Business Rule to Code)

| Kode Business Rule | Aturan Bisnis (*Business Rule*) | Fungsi Implementasi (Dart) | Skenario Uji di `main()` |
| :---: | :--- | :--- | :--- |
| **BR-01** | Anggota maksimal meminjam 3 buku yang belum dikembalikan. | `hitungBukuDipinjam()`, `pinjamBuku()` | **Skenario 3** (Uji coba meminjam buku ke-4 saat kuota penuh) |
| **BR-02** | Buku yang sedang dipinjam tidak dapat dipinjam kembali oleh orang lain. | `cekKetersediaan()`, `pinjamBuku()` | **Skenario 2** (Azmi mencoba meminjam B01 yang sedang dipinjam Hanif) |
| **BR-03** | Denda keterlambatan sebesar Rp1.000 per hari dari jatuh tempo. | `hitungDenda()`, `kembalikanBuku()` | **Skenario 4** (Pengembalian B01 terlambat 3 hari → Denda Rp3.000) |