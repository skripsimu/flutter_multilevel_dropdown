import 'dart:convert';
import 'package:flutter_multilevel_dropdown/connection/url.dart';
import 'package:http/http.dart' as http;
import '../model/model_provinsi.dart';

// ignore: missing_return
Future<ModelProvinsi> getJson() async {
  final response = await http.get(Urls.provinsiUrl);
  var responseDecode = json.decode(response.body);

  return ModelProvinsi.fromJson(responseDecode);
}
