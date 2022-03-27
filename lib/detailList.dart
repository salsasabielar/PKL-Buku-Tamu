//LIST TAMU DENGAN DENGAN DB LOCAL

import 'package:aplikasi_buku_tamu/detail.dart';
import 'package:aplikasi_buku_tamu/entryForm.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dbhelper.dart';
import 'model/tamu.dart';

//pendukung program asinkron
class DetailList extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<DetailList> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Tamu> tamuList;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (tamuList == null) {
      tamuList = List<Tamu>();
    }
    return Scaffold(
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
              child: createListView(),
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

  Future<Tamu> navigateToEntryForm(BuildContext context, Tamu tamu) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EntryForm(tamu);
        },
      ),
    );
    return result;
  }

  Future<Tamu> navigateToDetail(BuildContext context, Tamu tamu) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Detail(tamu: tamu);
        },
      ),
    );
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.grey[200],
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[200],
              child: Icon(Icons.account_circle),
            ),
            title: Text(
              this.tamuList[index].nama,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            subtitle: Text(this.tamuList[index].instansi),
            trailing: GestureDetector(
              child: Icon(Icons.delete_outline_rounded),
              onTap: () async {
                // Showing Alert Dialog with Response JSON Message.
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text(
                          "Apakah anda yakin ingin menghapus data ini?"),
                      actions: <Widget>[
                        FlatButton(
                          child: new Text("Ya"),
                          onPressed: () async {
                            int result =
                                await dbHelper.delete(this.tamuList[index].id);
                            if (result > 0) {
                              updateListView();
                            }
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: new Text("Tidak"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            onTap: () async {
              var tamu = await navigateToDetail(context, this.tamuList[index]);
            },
          ),
        );
      },
    );
  }

  //update List tamu
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
