class ModelKecamatan {
  List<Kecamatan> kecamatan;

  ModelKecamatan({this.kecamatan});

  ModelKecamatan.fromJson(Map<String, dynamic> json) {
    if (json['kecamatan'] != null) {
      kecamatan = new List<Kecamatan>();
      json['kecamatan'].forEach((v) {
        kecamatan.add(new Kecamatan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.kecamatan != null) {
      data['kecamatan'] = this.kecamatan.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Kecamatan {
  int id;
  String idKota;
  String nama;

  Kecamatan({this.id, this.idKota, this.nama});

  Kecamatan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idKota = json['id_kota'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_kota'] = this.idKota;
    data['nama'] = this.nama;
    return data;
  }
}
