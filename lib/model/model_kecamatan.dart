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
