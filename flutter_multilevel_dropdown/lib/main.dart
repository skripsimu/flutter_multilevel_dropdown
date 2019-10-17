import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model.dart';

void main() => runApp(MaterialApp(
  title: "Indonesian Territory",
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _provinsiSelection, _kabupatenSelection, _kecamatanSelection;
  Model provinsiModel;
  ModelKabupaten kabupatenModel;
  ModelKecamatan kecamatanModel;
  String provinsiID = "";
  String kabupatenID = "";

  String provinsiUrl = "http://dev.farizdotid.com/api/daerahindonesia/provinsi";
  String kabupatenUrl =
      "http://dev.farizdotid.com/api/daerahindonesia/provinsi/";
  String kecamatanUrl =
      "http://dev.farizdotid.com/api/daerahindonesia/provinsi/kabupaten/";

  List dataProvinsi = List();
  List dataKabupaten = List();
  List dataKecamatan = List();
  // ignore: missing_return
  Future<Model> getJson() async {
    var responseDecode;
    try {
      final response = await http.get(provinsiUrl);
      responseDecode = json.decode(response.body);
      setState(() {
        provinsiModel = Model.fromJson(responseDecode);
        dataProvinsi = provinsiModel.province;
      });
      return Model.fromJson(responseDecode);
    } catch (err) {
      print(err);
    }
  }

  // ignore: missing_return
  Future<ModelKabupaten> getJsonCity() async {
    var responseDecode;
    try {
      final response = await http.get(kabupatenUrl + provinsiID + "/kabupaten");
      responseDecode = json.decode(response.body);
      setState(() {
        kabupatenModel = ModelKabupaten.fromJson(responseDecode);
        dataKabupaten = kabupatenModel.kabupaten;
      });
      return ModelKabupaten.fromJson(responseDecode);
    } catch (err) {
      print(err);
    }
  }

  // ignore: missing_return
  Future<ModelKabupaten> getJsonKecamatan() async {
    var responseDecode;
    try {
      final response =
      await http.get(kecamatanUrl + kabupatenID + "/kecamatan");
      responseDecode = json.decode(response.body);
      setState(() {
        kecamatanModel = ModelKecamatan.fromJson(responseDecode);
        dataKecamatan = kecamatanModel.kecamatan;
      });
      return ModelKabupaten.fromJson(responseDecode);
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getJson();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Indonesian Territory"),
      ),
      body: new Center(
          child: Column(
            children: <Widget>[
              Container(
                width: 220,
                child: new DropdownButton(
                  isExpanded: true,
                  hint: Text("Select Provinsi"),
                  items: dataProvinsi.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item['nama']),
                      value: item['id'].toString(),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      _provinsiSelection = newVal;
                      if (provinsiID == newVal) {
                        _kabupatenSelection = _kabupatenSelection;
                        _kecamatanSelection = _kecamatanSelection;
                        dataKecamatan = dataKecamatan;
                      } else {
                        dataKecamatan = [];
                        _kabupatenSelection = null;
                        _kecamatanSelection = null;
                      }
                      provinsiID = newVal;
                      getJsonCity();
                    });
                  },
                  value: _provinsiSelection,
                ),
              ),
              Container(
                width: 220,
                child: new DropdownButton(
                  isExpanded: true,
                  hint: Text("Select Kota/Kabupaten"),
                  items: dataKabupaten.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item['nama']),
                      value: item['id'].toString(),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      _kabupatenSelection = newVal;
                      if (kabupatenID == newVal) {
                        _kecamatanSelection = _kecamatanSelection;
                      } else {
                        _kecamatanSelection = null;
                      }
                      kabupatenID = newVal;
                      getJsonKecamatan();
                    });
                  },
                  value: _kabupatenSelection,
                ),
              ),
              Container(
                width: 220,
                child: new DropdownButton(
                  isExpanded: true,
                  hint: Text("Select Kecamatan"),
                  items: dataKecamatan.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item['nama']),
                      value: item['id'].toString(),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      _kecamatanSelection = newVal;
                    });
                  },
                  value: _kecamatanSelection,
                ),
              ),
            ],
          )),
    );
  }
}
