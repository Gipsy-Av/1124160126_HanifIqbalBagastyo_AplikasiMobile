BAGIAN A — DOKUMEN ANALISIS

1. Problem Statement
Sistem perpustakaan memerlukan modul pengelolaan peminjaman dan pengembalian buku yang terintegrasi. Sistem harus mampu memvalidasi identitas anggota, mengecek ketersediaan stok buku, membatasi kuota pinjaman aktif, serta menghitung denda keterlambatan secara otomatis berdasarkan durasi peminjaman.

2. Actor
- Mahasiswa / Anggota: Peminjam buku perpustakaan.
- Sistem Perpustakaan: Validasi aturan bisnis, pencatatan transaksi, dan perhitungan denda.

3. Input & Output
- Input:
  * ID Mahasiswa (idMahasiswa)
  * ID Buku (idBuku)
  * Tanggal Pinjam (tglPinjam)
  * Tanggal Kembali (tglKembali)
- Output:
  * Status transaksi (Berhasil / Gagal beserta alasannya)
  * Rincian denda keterlambatan (Rp)

4. Functional Requirement
- FR-01: Sistem dapat mencatat transaksi peminjaman buku oleh mahasiswa.
- FR-02: Sistem dapat melakukan pencarian data mahasiswa dan data buku berdasarkan ID.
- FR-03: Sistem dapat menghitung jumlah buku yang sedang aktif dipinjam oleh mahasiswa.
- FR-04: Sistem dapat mengecek status ketersediaan buku sebelum dipinjam.
- FR-05: Sistem dapat memproses pengembalian buku dan menghitung denda keterlambatan.

5. Business Rules
- BR-01: Anggota/Mahasiswa maksimal meminjam 3 buku yang belum dikembalikan.
- BR-02: Buku yang sedang dipinjam tidak dapat dipinjam kembali oleh mahasiswa lain.
- BR-03: Denda keterlambatan dihitung sebesar Rp1.000 per hari jika melewati tanggal jatuh tempo.

6. Computational Thinking
- Decomposition: Memecah sistem perpustakaan menjadi beberapa fungsi kecil (cariMahasiswa, cariBuku, hitungBukuDipinjam, cekKetersediaan, hitungDenda).
- Pattern Recognition: Menggunakan pola Guard Clause (Early Return) untuk memvalidasi syarat peminjaman di awal fungsi sebelum memproses data.
- Abstraction: Menyederhanakan objek dunia nyata menjadi struktur data di program menggunakan enum StatusBuku serta class Mahasiswa, Buku, dan Transaksi.
- Algorithm: Menyusun urutan langkah-langkah sistematis untuk alur peminjaman dan pengembalian buku.

7. Pseudocode

PROCEDURE pinjamBuku(idMahasiswa, idBuku, tglPinjam)
    mhs = cariMahasiswa(idMahasiswa)
    IF mhs IS NULL THEN
        RETURN "Gagal: Mahasiswa tidak ditemukan."
    END IF

    buku = cariBuku(idBuku)
    IF buku IS NULL THEN
        RETURN "Gagal: Buku tidak ditemukan."
    END IF

    IF NOT cekKetersediaan(buku) THEN
        RETURN "Gagal: Buku sedang dipinjam."
    END IF

    IF hitungBukuDipinjam(idMahasiswa) >= 3 THEN
        RETURN "Gagal: Maksimal pinjam 3 buku."
    END IF

    jatuhTempo = tglPinjam + 7 HARI
    idPinjam = GENERATE_ID()
    SIMPAN Transaksi(idPinjam, idMahasiswa, idBuku, tglPinjam, jatuhTempo)
    SET buku.status = dipinjam

    RETURN "Berhasil meminjam buku: " + buku.judul
END PROCEDURE

PROCEDURE kembalikanBuku(idMahasiswa, idBuku, tglKembali)
    trx = CARI Transaksi WHERE idMahasiswa = idMahasiswa AND idBuku = idBuku AND tglKembali IS NULL
    IF trx IS NULL THEN
        RETURN "Gagal: Data peminjaman tidak ditemukan."
    END IF

    trx.tglKembali = tglKembali
    denda = hitungDenda(trx.tglJatuhTempo, tglKembali)
    trx.denda = denda

    buku = cariBuku(idBuku)
    IF buku IS NOT NULL THEN
        SET buku.status = tersedia
    END IF

    IF denda > 0 THEN
        RETURN "Pengembalian berhasil. Denda: Rp" + denda
    ELSE
        RETURN "Pengembalian berhasil. Tidak ada denda."
    END IF
END PROCEDURE