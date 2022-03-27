//DETAIL LIST TAMU DENGAN API

import 'dart:io';
import 'package:aplikasi_buku_tamu/dbhelper.dart';
import 'package:aplikasi_buku_tamu/model/daftarTamu.dart';
import 'package:aplikasi_buku_tamu/model/tamu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DetailTamu extends StatefulWidget {
  final DaftarTamu daftarTamu;
  DetailTamu({Key key, @required this.daftarTamu}) : super(key: key);

  @override
  DetailTamuState createState() => DetailTamuState(daftarTamu: daftarTamu);
}

class DetailTamuState extends State<DetailTamu> {
  DaftarTamu daftarTamu;
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Tamu> tamuList = [];
  DetailTamuState({@required this.daftarTamu}) : super();

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      
      Future<List<Tamu>> tamuListFuture = dbHelper.getTamuList();
      tamuListFuture.then((tamuList) {
        setState(() {
          this.tamuList = tamuList;
          this.count = tamuList.length;
        });
      });
    });
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
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              height: 30.0,
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
                                    daftarTamu.nama,
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
                                    daftarTamu.alamat,
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
                                    daftarTamu.instansi,
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
                                    daftarTamu.email,
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
                                    daftarTamu.telp,
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
                                    daftarTamu.tujuan,
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
                                    daftarTamu.keterangan,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25.0),
                                  ),
                                )
                              ],
                            ),

                            // Text(
                            //   'Tanggal / Waktu: ' + daftarTamu.createDate,
                            //   style:
                            //       TextStyle(color: Colors.black, fontSize: 25.0
                            //           //fontWeight: FontWeight.bold
                            //           ),
                            // ),

                            Text(
                              "Tanda Tangan & Foto :",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20.0
                                      //fontWeight: FontWeight.bold
                                      ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...tamuList.map(
                                  (e) => e.email == daftarTamu.email
                                      ? Container(
                                          margin: EdgeInsets.all(5),
                                          height: 150,
                                          width: 140,
                                          alignment: Alignment.center,
                                          color: Colors.blueGrey[100],
                                          child: Image.file(
                                            File(e.imgTtd),
                                            fit: BoxFit.fill,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                          ),
                                        )
                                      : Text(""),
                                ),
                                ...tamuList.map(
                                  (e) => e.email == daftarTamu.email
                                      ? Container(
                                          margin: EdgeInsets.all(5),
                                          height: 150,
                                          width: 140,
                                          alignment: Alignment.center,
                                          color: Colors.blueGrey[100],
                                          child: Image.file(
                                            File(e.imgPhoto),
                                            fit: BoxFit.fill,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                          ),
                                        )
                                      : Text(""),
                                ),

                                // Container(
                                //   margin: EdgeInsets.all(5),
                                //   height: 150,
                                //   width: 140,
                                //   alignment: Alignment.center,
                                //   color: Colors.blueGrey[100],
                                //   child: Image.file(
                                //     File("${tamuList.map((e) => e.imgTtd)}"),
                                //     fit: BoxFit.fill,
                                //     width: MediaQuery.of(context).size.width,
                                //     height: MediaQuery.of(context).size.height,
                                //   ),
                                // ),
                                // Container(
                                //   margin: EdgeInsets.all(5),
                                //   height: 150,
                                //   width: 150,
                                //   alignment: Alignment.center,
                                //   color: Colors.blueGrey[100],
                                //   child: Text("data"),
                                //   // Image.file(
                                //   //   File("${tamuList.map((e) => e.imgPhoto)}"),
                                //   //   fit: BoxFit.fill,
                                //   //   width: MediaQuery.of(context).size.width,
                                //   //   height: MediaQuery.of(context).size.height,
                                //   // ),
                                // ),
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
