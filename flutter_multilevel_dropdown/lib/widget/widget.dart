import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void showToast(BuildContext context, String msg, {int duration, int gravity}) {
  Toast.show(msg, context,
      duration: duration, gravity: gravity, backgroundRadius: 20.0);
}

getDialog(BuildContext context, String source, {String source2, source3}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Proses Alamat",
                  style: TextStyle(fontSize: 18.0, color: Colors.pink[400]),
                ),
                Container(
                  width: 60,
                  child: Divider(
                    color: Colors.pink[400],
                  ),
                ),
                Text(
                  "Apakah alamat anda sudah benar?\n",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      source.substring(1, source.length) +
                          ", " +
                          source2 +
                          "\n" +
                          source3,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  minWidth: 150,
                  color: Colors.pink[400],
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                MaterialButton(
                  minWidth: 150,
                  color: Colors.pink[400],
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ));
}
