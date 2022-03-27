//MODEL UNTUK INSERT KE DB LOCAL

class Tamu {
  int _id;
  String _nama;
  String _alamat;
  String _instansi;
  String _email;
  String _telp;
  String _tujuan;
  String _keterangan;
  String _createDate;
  String _imgPhoto;
  String _imgTtd;

  int get id => _id;

  String get nama => this._nama;
  set nama(String value) => this._nama = value;

  String get alamat => this._alamat;
  set alamat(String value) => this._alamat = value;

  String get instansi => this._instansi;
  set instansi(String value) => this._instansi = value;

  String get email => this._email;
  set email(String value) => this._email = value;

  String get telp => this._telp;
  set telp(String value) => this._telp = value;

  String get tujuan => this._tujuan;
  set tujuan(String value) => this._tujuan = value;

  String get keterangan => this._keterangan;
  set keterangan(String value) => this._keterangan = value;

  String get createDate => this._createDate;
  set createDate(String value) => this._createDate = value;

  String get imgPhoto => this._imgPhoto;
  set imgPhoto(String value) => this._imgPhoto = value;

  String get imgTtd => this._imgTtd;
  set imgTtd(String value) => this._imgTtd = value;

// konstruktor versi 1
  Tamu(this._nama, this._alamat, this._instansi, this._email,this._telp,this._tujuan, this._keterangan, 
      this._createDate, this._imgPhoto, this._imgTtd);

// konstruktor versi 2: konversi dari Map ke Tamu
  Tamu.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nama = map['nama'];
    this._alamat = map['alamat'];
    this._instansi = map['instansi'];
    this._email = map['email'];
    this._telp = map['telp'];
    this._tujuan = map['tujuan'];
    this._keterangan = map['keterangan'];
    this._createDate = map['createDate'];
    this._imgPhoto = map['photo'];
    this._imgTtd = map['ttd'];
  }

  // konversi dari Tamu ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['nama'] = nama;
    map['alamat'] = alamat;
    map['instansi'] = instansi;
    map['email'] = email;
    map['telp'] = telp;
    map['tujuan'] = tujuan;
    map['keterangan'] = keterangan;
    map['createDate'] = createDate;
    map['photo'] = imgPhoto;
    map['ttd'] = imgTtd;
    return map;
  }
}