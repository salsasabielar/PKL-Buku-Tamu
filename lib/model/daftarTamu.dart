//MODEL UNTUK MENAMPILKAN LIST TAMU / GET TAMU

class DaftarTamu {
  final int id;
  final String nama;
  final String alamat;
  final String instansi;
  final String email;
  final String telp;
  final String tujuan;
  final String keterangan;

  DaftarTamu(
      {this.id,
      this.nama,
      this.alamat,
      this.instansi,
      this.email,
      this.telp,
      this.tujuan,
      this.keterangan});

  factory DaftarTamu.fromJson(Map<String, dynamic> json) {
    return DaftarTamu(
      id: json['id'] as int,
      nama: json['nama'] as String,
      alamat: json['alamat'] as String,
      instansi: json['instansi'] as String,
      email: json['email'] as String,
      telp: json['telp'] as String,
      tujuan: json['tujuan'] as String,
      keterangan: json['keterangan'] as String,
    );
  }
}
