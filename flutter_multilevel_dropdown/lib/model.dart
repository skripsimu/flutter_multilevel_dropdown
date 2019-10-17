class Model {
  bool error;
  String message;
  List province;

  Model(this.error, this.message, this.province);

  factory Model.fromJson(Map<String, dynamic> json) {
    final model = Model(
      json['error'],
      json['message'],
      json['semuaprovinsi'],
    );

    return model;
  }
}

class ModelKabupaten {
  bool error;
  String message;
  List kabupaten;

  ModelKabupaten(this.error, this.message, this.kabupaten);

  factory ModelKabupaten.fromJson(Map<String, dynamic> json) {
    final model = ModelKabupaten(
      json['error'],
      json['message'],
      json['kabupatens'],
    );

    return model;
  }
}

class ModelKecamatan {
  bool error;
  String message;
  List kecamatan;

  ModelKecamatan(this.error, this.message, this.kecamatan);

  factory ModelKecamatan.fromJson(Map<String, dynamic> json) {
    final model = ModelKecamatan(
      json['error'],
      json['message'],
      json['kecamatans'],
    );

    return model;
  }
}

