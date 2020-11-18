import "package:flutter/material.dart";
import 'package:flutter_multilevel_dropdown/widget/widget_lib.dart';
import 'dart:async';
import 'package:toast/toast.dart';
import 'package:flutter_multilevel_dropdown/controller/controller_kecamatan.dart';
import 'package:flutter_multilevel_dropdown/controller/controller_kabupaten.dart';

import 'package:flutter_multilevel_dropdown/controller/controller_provinsi.dart';
import 'package:flutter_multilevel_dropdown/model/model_provinsi.dart';
import 'package:flutter_multilevel_dropdown/model/model_kecamatan.dart';
import 'package:flutter_multilevel_dropdown/model/model_kabupaten.dart';

class MultiDropdown extends StatefulWidget {
  @override
  _MultiDropdownState createState() => _MultiDropdownState();
}

class _MultiDropdownState extends State<MultiDropdown> {
  String _provinsiSelection, _kabupatenSelection, _kecamatanSelection;
  ModelProvinsi provinsiModel;
  ModelKabupaten kabupatenModel;
  ModelKecamatan kecamatanModel;

  String provinsiID = "";
  String kabupatenID = "";
  String provinsiNama = "";
  String kabupatenNama = "";
  String kecamatanNama = "";

  List<Provinsi> dataProvinsi = [];
  List<KotaKabupaten> dataKabupaten = [];
  List<Kecamatan> dataKecamatan = [];

  bool enableButton = false;

  Future<void> getProvinsi() async {
    getJson().then((provinsi) {
      setState(() {
        provinsiModel = provinsi;
        dataProvinsi = provinsiModel.provinsi;
      });
    });
  }

  Future<void> getKabupaten() async {
    getJsonCity(provinsiID).then((kabupaten) {
      setState(() {
        kabupatenModel = kabupaten;
        dataKabupaten = kabupatenModel.kotaKabupaten;
        dataKabupaten.forEach((element) {
          print(element.nama);
        });
      });
    });
  }

  Future<void> getKecamatan() async {
    getJsonKecamatan(kabupatenID).then((kecamatan) {
      setState(() {
        kecamatanModel = kecamatan;
        dataKecamatan = kecamatanModel.kecamatan;
      });
    });
  }

  void checkValue() {
    if (kabupatenNama.length > 0 &&
        kecamatanNama.length > 0 &&
        provinsiNama.length > 0) {
      enableButton = true;
    } else {
      enableButton = false;
    }
  }

  @override
  void initState() {
    super.initState();
    this.getProvinsi();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text("Wilayah Indonesia"),
      ),
      body: dataProvinsi.length > 0 ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              padding: EdgeInsets.only(left: 10, right: 5),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(30),
              ),
              child: new DropdownButton(
                underline: Container(),
                isExpanded: true,
                hint: Text("Select Provinsi"),
                items: dataProvinsi.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(item.nama),
                    value: item.id.toString() + item.nama,
                  );
                }).toList(),
                onChanged: (newVal) {
                  int lengthString = newVal.length;
                  String id = newVal.substring(0, 2);
                  setState(() {
                    checkValue();
                    _provinsiSelection = newVal;
                    provinsiNama = newVal.substring(2, lengthString);
                    if (provinsiID == id) {
                      _kabupatenSelection = _kabupatenSelection;
                      _kecamatanSelection = _kecamatanSelection;
                      dataKecamatan = dataKecamatan;
                      checkValue();
                    } else {
                      dataKecamatan = [];
                      _kabupatenSelection = null;
                      _kecamatanSelection = null;
                      kabupatenNama = "";
                      kecamatanNama = "";
                      checkValue();
                    }
                    provinsiID = id;
                    getKabupaten();
                  });
                },
                value: _provinsiSelection,
              ),
            ),
            Container(
              width: 300,
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.only(left: 10, right: 5),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(30),
              ),
              child: new DropdownButton(
                underline: Container(),
                isExpanded: true,
                hint: Text("Select Kota/Kabupaten"),
                items: dataKabupaten.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(item.nama),
                    value: item.id.toString() + item.nama,
                  );
                }).toList(),
                onChanged: (newVal) {
                  checkValue();
                  int lengthString = newVal.length;
                  String id = newVal.substring(0, 4);
                  setState(() {
                    _kabupatenSelection = newVal;
                    kabupatenNama = newVal.substring(4, lengthString);
                    if (kabupatenID == id) {
                      _kecamatanSelection = _kecamatanSelection;
                      checkValue();
                    } else {
                      _kecamatanSelection = null;
                      kecamatanNama = "";
                      checkValue();
                    }
                    kabupatenID = id;
                    getKecamatan();
                  });
                },
                value: _kabupatenSelection,
              ),
            ),
            Container(
              width: 300,
              margin: EdgeInsets.only(top: 5, bottom: 10),
              padding: EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(30),
              ),
              child: new DropdownButton(
                underline: Container(),
                isExpanded: true,
                hint: Text("Select Kecamatan"),
                items: dataKecamatan.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(item.nama),
                    value: item.id.toString() + item.nama,
                  );
                }).toList(),
                onChanged: (newVal) {
                  checkValue();
                  int lengthString = newVal.length;
                  String id = newVal.substring(0, 7);
                  setState(() {
                    kecamatanNama = newVal.substring(7, lengthString);
                    _kecamatanSelection = newVal;
                    checkValue();
                  });
                },
                value: _kecamatanSelection,
              ),
            ),
            MaterialButton(
              minWidth: 200,
              height: 50,
              color: Colors.pink[400],
              child: Text(
                'PROSES',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: enableButton == true
                  ? () {
                getDialog(context, kecamatanNama,
                    source2: kabupatenNama, source3: provinsiNama);
              }
                  : (){
                showToast(context, "Lengkapi alamat anda!",gravity: Toast.BOTTOM);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ],
        ),
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}