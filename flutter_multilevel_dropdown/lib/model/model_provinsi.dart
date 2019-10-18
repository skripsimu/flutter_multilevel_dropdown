class ModelProvinsi {
  bool error;
  String message;
  List province;

  ModelProvinsi(this.error, this.message, this.province);

  factory ModelProvinsi.fromJson(Map<String, dynamic> json) {
    final model = ModelProvinsi(
      json['error'],
      json['message'],
      json['semuaprovinsi'],
    );

    return model;
  }
}



