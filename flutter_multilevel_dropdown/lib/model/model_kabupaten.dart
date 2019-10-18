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