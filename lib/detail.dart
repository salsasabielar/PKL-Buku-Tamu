//DETAIL TAMU DENGAN DB LOCAL

import 'dart:io';
import 'package:flutter/material.dart';
import 'model/tamu.dart';

class Detail extends StatefulWidget {
  final Tamu tamu;
  Detail({Key key, @required this.tamu}) : super(key: key);

  @override
  DetailState createState() => DetailState(tamu: tamu);
}

class DetailState extends State<Detail> {
  Tamu tamu;
  DetailState({@required this.tamu}) : super();

  @override
  
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
        child: Column(
          children: [
            Positioned(
              child: Container(
                child: Align(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/l tt.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 200,
                    height: 200,
                  ),
                ),
                height: 150,
              ),
            ),
            Expanded(
              child: buildListView(context),
            ),

            // tombol
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: SizedBox(
                    width: 50,
                  )),
                  Expanded(
                      child: SizedBox(
                    width: 50,
                  )),
                  Expanded(
                      child: SizedBox(
                    width: 30,
                  )),
                  // tombol kembali
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorLight,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text('Kembali', style: TextStyle(fontSize: 20.0)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView buildListView(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Center(
            child: Wrap(
              spacing: 20,
              runSpacing: 20.0,
              children: <Widget>[
                Expanded(
                  // width: 400.0,
                  // height: 450.0,
                  child: Card(
                    color: Colors.blue[50],
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Detail Informasi",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  fontSize: 30.0),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Nama :',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 25.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    tamu.nama,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25.0),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Alamat :',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 25.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    tamu.alamat,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25.0),
                                  ),
                                )
                              ],
                            ),
                           Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Instansi :',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 25.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    tamu.instansi,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25.0),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Email :',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 25.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    tamu.email,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25.0),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Telepon :',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 25.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    tamu.telp,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25.0),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Tujuan :',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 25.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    tamu.tujuan,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25.0),
                                  ),
                                )
                              ],
                            ),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Keterangan :',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 25.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    tamu.keterangan,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25.0),
                                  ),
                                )
                              ],
                            ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Tanggal / Waktu :',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 25.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    tamu.createDate,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25.0),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "Tanda Tangan & Foto: ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20.0
                                      //fontWeight: FontWeight.bold
                                      ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    margin: EdgeInsets.all(5),
                                    height: 150,
                                    width: 140,
                                    alignment: Alignment.center,
                                    color: Colors.blueGrey[100],
                                    child: Image.file(
                                      File("${tamu.imgTtd}"),
                                      fit: BoxFit.fill,
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                    )),
                                Container(
                                    margin: EdgeInsets.all(5),
                                    height: 150,
                                    width: 150,
                                    alignment: Alignment.center,
                                    color: Colors.blueGrey[100],
                                    child: Image.file(
                                      File("${tamu.imgPhoto}"),
                                      fit: BoxFit.fill,
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
