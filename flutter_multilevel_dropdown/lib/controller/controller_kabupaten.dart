import 'dart:convert';
import 'package:flutter_multilevel_dropdown/connection/url.dart';
import 'package:http/http.dart' as http;
import '../model/model_kabupaten.dart';

// ignore: missing_return
Future<ModelKabupaten> getJsonCity(provinsiID) async {
  final response = await http.get(Urls.kabupatenUrl + provinsiID + "/kabupaten");
  var responseDecode = json.decode(response.body);

  return ModelKabupaten.fromJson(responseDecode);
}
