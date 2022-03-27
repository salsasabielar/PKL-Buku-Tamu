//LIST TAMU DENGAN API

import 'package:aplikasi_buku_tamu/API/detailTamu.dart';
import 'package:aplikasi_buku_tamu/dbhelper.dart';
import 'package:aplikasi_buku_tamu/model/daftarTamu.dart';
import 'package:aplikasi_buku_tamu/model/tamu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';

class ListTamu extends StatefulWidget {
  @override
  _ListTamuState createState() => new _ListTamuState();
}

class _ListTamuState extends State<ListTamu> {
  final String sUrl =
      "http://114.4.37.148/bukutamu/index.php/daftartamu/getlisttamu";
  List<DaftarTamu> listtamu;
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Tamu> tamuList;

  @override
  void initState() {
    super.initState();
  }

  Future<List<DaftarTamu>> _fetchData() async {
    try {
      var jsonResponse = await http.post(sUrl);
      if (jsonResponse.statusCode == 200) {
        final jsonItems =
            json.decode(jsonResponse.body).cast<Map<String, dynamic>>();
        listtamu = jsonItems.map<DaftarTamu>((json) {
          return DaftarTamu.fromJson(json);
        }).toList();
      }
    } catch (e) {}
    return listtamu;
  }

  Future<Null> _refresh() {
    return _fetchData().then((_listtamu) {
      setState(() => listtamu = _listtamu);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
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

            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Center(
                child: Wrap(
                  // spacing: 20,
                  // runSpacing: 20.0,
                  children: <Widget>[
                    SizedBox(
                      width: 1000.0,
                      height: 60.0,
                      child: Card(
                        color: Colors.blue[100],
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Daftar Tamu",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0),
                              ),
                            ],
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: buildRefreshIndicator(),
            ),

            // tombol
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  // tombol kembali
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

  RefreshIndicator buildRefreshIndicator() {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<List<DaftarTamu>>(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return Container(
            margin: EdgeInsets.only(bottom: 0.0),
            child: ListView(
              padding: EdgeInsets.only(bottom: 160.0),
              children: snapshot.data
                  .map(
                    (_data) => Column(children: <Widget>[
                      Card(
                        color: Colors.grey[200],
                        elevation: 2.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue[200],
                                child: Icon(Icons.account_circle),
                              ),
                              title: Text(
                                _data.nama,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              subtitle: Text(_data.instansi),
                              trailing: GestureDetector(
                                child: Icon(Icons.delete_outline_rounded),
                                onTap: () async {
                                  //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan tamu
                                  int result = await dbHelper
                                      .delete(_data.id);
                                  if (result > 0) {
                                    updateListView();
                                  }
                                },
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailTamu(daftarTamu: _data),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }

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
}
