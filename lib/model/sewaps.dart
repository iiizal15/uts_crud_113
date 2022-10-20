class SewaPS {
  int? id;
  String? nama;
  String? noHP;
  String? email;
  String? jenisPS;

  SewaPS({this.id, this.nama, this.noHP, this.email, this.jenisPS});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['nama'] = nama;
    map['noHP'] = noHP;
    map['email'] = email;
    map['jenisPS'] = jenisPS;

    return map;
  }

  SewaPS.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nama = map['nama'];
    this.noHP = map['noHP'];
    this.email = map['email'];
    this.jenisPS = map['jenisPS'];
  }
}
