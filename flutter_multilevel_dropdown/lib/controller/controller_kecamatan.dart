import 'dart:convert';
import 'package:flutter_multilevel_dropdown/connection/url.dart';
import 'package:http/http.dart' as http;
import '../model/model_kecamatan.dart';

// ignore: missing_return
Future<ModelKecamatan> getJsonKecamatan(kabupatenID) async {
  final response = await http.get(Urls.kecamatanUrl + kabupatenID + "/kecamatan");
  var responseDecode = json.decode(response.body);
  return ModelKecamatan.fromJson(responseDecode);
}
