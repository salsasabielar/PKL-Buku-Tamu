import 'dart:io';
import 'package:aplikasi_buku_tamu/dbhelper.dart';
import 'package:aplikasi_buku_tamu/model/tamu.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class Report extends StatefulWidget {
  @override
  ReportState createState() => ReportState();
}

class ReportState extends State<Report> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Tamu> tamuList = [];

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  // String dropdownvalue = 'Januari';
  // var items = [
  //   'Januari',
  //   'Februari',
  //   'Maret',
  //   'April',
  //   'Mei',
  //   'Juni'
  //       'Juli',
  //   'Agustus',
  //   'September'
  //       'Oktober',
  //   'November',
  //   'Desember'
  // ];

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
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
              child: buildListView(),
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

  ListView buildListView() {
    return ListView(
      children: <Widget>[
        // Positioned(
        //   child: Container(
        //     child: Align(
        //       child: Container(
        //         decoration: BoxDecoration(
        //           image: DecorationImage(
        //             image: AssetImage('assets/l tt.png'),
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //         width: 200,
        //         height: 200,
        //       ),
        //     ),
        //     height: 150,
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Center(
            child: Wrap(
              spacing: 20,
              runSpacing: 20.0,
              children: <Widget>[
                // DropdownButton(
                //   value: dropdownvalue,
                //   icon: Icon(Icons.keyboard_arrow_down),
                //   items: items.map((String items) {
                //     return DropdownMenuItem(
                //         value: items, child: Text(items));
                //   }).toList(),
                //   onChanged: (String newValue) {
                //     setState(() {
                //       dropdownvalue = newValue;
                //     });
                //   },
                // ),
                Expanded(
                  child: Card(
                    color: Colors.blue[50],
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: <DataColumn>[
                          DataColumn(label: Text("Nama")),
                          DataColumn(label: Text("Alamat")),
                          DataColumn(label: Text("Instansi")),
                          DataColumn(label: Text("Email")),
                          DataColumn(label: Text("Telepon")),
                          DataColumn(label: Text("Tujuan")),
                          DataColumn(label: Text("Keterangan")),
                          DataColumn(label: Text("Tanggal / Waktu")),
                          DataColumn(label: Text("Tanda Tangan")),
                          DataColumn(label: Text("Foto")),
                        ],
                        rows:
                            tamuList // Loops through dataColumnText, each iteration assigning the value to element
                                .map(
                                  ((element) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text(element.nama)),
                                          DataCell(Text(element.alamat)),
                                          DataCell(Text(element.instansi)),
                                          DataCell(Text(element.email)),
                                          DataCell(Text(element.telp)),
                                          DataCell(Text(element.tujuan)),
                                          DataCell(Text(element.keterangan)),
                                          DataCell(
                                              Text(element.createDate)),
                                          DataCell(
                                            element.imgTtd != null
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets
                                                            .all(8.0),
                                                    child: Image.file(
                                                      File(
                                                          "${element.imgTtd}"),
                                                      // fit: BoxFit.fill,
                                                      //fit: BoxFit.fill,
                                                      width: 50,
                                                      height: 400,
                                                    ),
                                                  )
                                                : Container(),
                                          ),
                                          DataCell(
                                            element.imgPhoto != null
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets
                                                            .all(8.0),
                                                    child: Image.file(
                                                      File(
                                                          "${element.imgPhoto}"),
                                                      //fit: BoxFit.fill,
                                                      width: 50,
                                                      height: 1000,
                                                    ),
                                                  )
                                                : Container(),
                                          ),
                                        ],
                                      )),
                                )
                                .toList(),
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
