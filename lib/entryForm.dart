//ENTRY FORM DENGAN SQLITE

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:aplikasi_buku_tamu/dbhelper.dart';
import 'package:aplikasi_buku_tamu/model/cases.dart';
import 'package:aplikasi_buku_tamu/model/tamu.dart';
import 'package:aplikasi_buku_tamu/services/api_services.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:signature/signature.dart';
import 'dart:core';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EntryForm extends StatefulWidget {
  String imagePath;
  CameraController controller;
  List cameras;
  int selectedCameraIdx;
  final Tamu tamu;
  EntryForm(this.tamu);

  @override
  EntryFormState createState() => EntryFormState(this.tamu);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Tamu tamu;

  var dbHelper;
  bool formIsValidated = false;
  var isUserNameValidate;
  EntryFormState(this.tamu);
  final ApiService api = ApiService();
  final GlobalKey<FormState> _formKey = new GlobalKey();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController instansiController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telpController = TextEditingController();
  final TextEditingController tujuanController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  TextEditingController createDateController = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  double textSize = 20;
  File cameraFile;
  String _imgTtd;
  String fileName;
  File uploadimage;
  var now = DateTime.now();

  final SignatureController ttdController = SignatureController(
    penStrokeWidth: 2,
    exportBackgroundColor: Colors.white,
    penColor: Colors.black,
  );

  Future addRecord() async {
    var db = DbHelper();
    String dateNow = DateFormat('dd-MM-yyyy / kk:mm:ss').format(now);

    var tamu = Tamu(
        namaController.text,
        alamatController.text,
        instansiController.text,
        emailController.text,
        telpController.text,
        tujuanController.text,
        keteranganController.text,
        dateNow,
        cameraFile.path.toString(),
        _imgTtd);
    await db.insert(tamu);
  }

  // var Share;
  void clearInputText() {
    namaController.text = "";
    alamatController.text = "";
    instansiController.text = "";
    emailController.text = "";
    telpController.text = "";
    tujuanController.text = "";
    keteranganController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    selectFromCamera() async {
      cameraFile = await ImagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 20,
      );
      setState(() {
        uploadimage = cameraFile;
      });
      GallerySaver.saveImage(cameraFile.path);
      print(cameraFile);
      setState(() {});
    }

    Future<String> saveImage(Uint8List bytes) async {
      await [Permission.storage].request();
      final time = DateTime.now()
          .toIso8601String()
          .replaceAll(".", "-")
          .replaceAll(":", "-");
      final name = "ttd-$time";
      final result =
          await ImageGallerySaver.saveImage(bytes, name: name, quality: 10);
      var path = await FlutterAbsolutePath.getAbsolutePath(result['filePath']);
      print(path);
      setState(
        () {
          _imgTtd = path.toString();
        },
      );
      return result['filePath'];
    }

    Future<void> uploadImage() async {
      //show your own loading or progressing code here

      String uploadurl =
          "http://114.4.37.148/bukutamu/index.php/daftartamu/uploadfoto";

      try {
        List<int> imageBytes = uploadimage.readAsBytesSync();
        String baseimage = base64Encode(imageBytes);
        String formattedDate = DateFormat('yyyy_MM_dd_kk_mm_ss').format(now);
        fileName = tamu.nama + "-$formattedDate.jpg";
        //print(fileName);
        Map data = {
          'name': fileName,
          'image': "data:image/jpeg;base64," + baseimage
        };

        var body = json.encode(data);
        print(data);

        //convert file image to Base64 encoding
        var response = await http.post(uploadurl,
            headers: {
              'Content-Type': 'application/json',
            },
            body: body);
        print(response.body);
      } catch (e) {
        print("Error during converting to Base64");
        //there is error during converting file image to base64 encoding.
      }
    }

    //rubah
    return Scaffold(
      // appBar: AppBar(
      backgroundColor: Colors.blue[50],
      // leading: Icon(Icons.keyboard_arrow_left),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: Form(
            key: _formKey,
            onChanged: () {
              setState(() {
                if (_formKey.currentState.validate()) {
                  formIsValidated = true;
                } else {
                  formIsValidated = false;
                }
              });
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              children: <Widget>[
                Container(
                  child: Positioned(
                    child: Container(
                      child: Align(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/l tt.png'),
                              //fit: BoxFit.cover,
                            ),
                          ),
                          width: 200,
                          height: 300,
                        ),
                      ),
                      height: 150,
                    ),
                  ),
                ),

                //Nama
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: namaController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Nama',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // onChanged: (value) {
                    //   //
                    // },
                    validator: (text) {
                      if (text == null || text.isEmpty || text.length <= 1) {
                        return "Isi Form Lebih dari 1 Karakter!";
                      }
                      return null;
                    },
                  ),
                ),

                //alamat
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: alamatController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Alamat',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // onChanged: (value) {
                    //   //
                    // },
                    validator: (text) {
                      if (text == null || text.isEmpty || text.length <= 1) {
                        return "Isi Form Lebih dari 1 Karakter!";
                      }
                      return null;
                    },
                  ),
                ),

                //instansi
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: instansiController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Instansi',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // onChanged: (value) {
                    //   //
                    // },
                    validator: (text) {
                      if (text == null || text.isEmpty || text.length <= 1) {
                        return "Isi Form Lebih dari 1 Karakter!";
                      }
                      return null;
                    },
                  ),
                ),

                // email
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // onChanged: (value) {
                    //   //
                    // },
                    validator: (text) {
                      if (text == null || text.isEmpty || text.length <= 1) {
                        return "Isi Form Lebih dari 1 Karakter!";
                      }
                      return null;
                    },
                  ),
                ),

                //telp
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: telpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Telepon',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // onChanged: (value) {
                    //   //
                    // },
                    validator: (text) {
                      if (text == null || text.isEmpty || text.length <= 1) {
                        return "Isi Form Lebih dari 1 Karakter!";
                      }
                      return null;
                    },
                  ),
                ),

                //tujuan
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: tujuanController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Tujuan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // onChanged: (value) {
                    //   //
                    // },
                    validator: (text) {
                      if (text == null || text.isEmpty || text.length <= 1) {
                        return "Isi Form Lebih dari 1 Karakter!";
                      }
                      return null;
                    },
                  ),
                ),

                //Keterangan
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: keteranganController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Keterangan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // onChanged: (value) {
                    //   //
                    // },
                    validator: (text) {
                      if (text == null || text.isEmpty || text.length <= 1) {
                        return "Isi Form Lebih dari 1 Karakter!";
                      }
                      return null;
                    },
                  ),
                ),

                // Tanda Tangan
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      width: 470.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(
                                Icons.refresh,
                                size: 28,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    ttdController.clear();
                                  },
                                );
                              },
                            ),
                          ),
                          Text(
                            'Ulangi',
                            style: TextStyle(color: Colors.blue, fontSize: 18.0
                                //fontWeight: FontWeight.bold
                                ),
                          ),
                        ],
                      ),
                    ),
                    Screenshot(
                      controller: screenshotController,
                      child: Signature(
                        height: 300,
                        width: 475,
                        backgroundColor: Colors.white,
                        controller: ttdController,
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: 470.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                icon: Icon(Icons.camera_alt_rounded,
                                    size: 28, color: Colors.blueGrey),
                                onPressed: selectFromCamera),
                          ),
                          Text(
                            'Kamera',
                            style: TextStyle(color: Colors.blue, fontSize: 18.0
                                //fontWeight: FontWeight.bold
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //kamera
                Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerRight,
                      ),
                      SizedBox(
                        height: 350.0,
                        width: 500.0,
                        child: cameraFile == null
                            ? Center(
                                child: new Text('Ambil Foto Terlebih Dahulu!'))
                            : Center(child: new Image.file(cameraFile)),
                      )
                    ],
                  ),
                ),

                // tombol
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // tombol simpan
                      Container(
                        width: 150,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorLight,
                          textColor: Theme.of(context).primaryColorDark,
                          child:
                              Text('Simpan', style: TextStyle(fontSize: 20.0)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () async {
                            // _saveForm();
                            if (formIsValidated) {
                              final image =
                                  await screenshotController.capture();
                              if (image == null) return;
                              await saveImage(image);
                              if (tamu == null) {
                                // tambah data
                                tamu = Tamu(
                                    namaController.text,
                                    alamatController.text,
                                    instansiController.text,
                                    emailController.text,
                                    telpController.text,
                                    tujuanController.text,
                                    keteranganController.text,
                                    createDateController.text,
                                    cameraFile.path.toString(),
                                    _imgTtd);

                                //menambahkan waktu sekarang

                                addRecord(); //menyimpan data
                                uploadImage();

                                print("nama file : " + fileName.toString());
                                api.createCase(Cases(
                                    nama: namaController.text,
                                    alamat: alamatController.text,
                                    instansi: instansiController.text,
                                    email: emailController.text,
                                    telp: telpController.text,
                                    tujuan: tujuanController.text,
                                    keterangan: keteranganController.text,
                                    namafile: fileName.toString()));

                                // // kembali ke layar sebelumnya dengan membawa objek tamu

                                Navigator.pop(context, tamu);
                              }
                            } else {
                              // Showing Alert Dialog with Response JSON Message.
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: new Text("Isi Form Terlebih Dahulu"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: new Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      Container(
                        width: 25.0,
                      ),
                      // tombol batal
                      Container(
                        width: 150,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorLight,
                          textColor: Theme.of(context).primaryColorDark,
                          child:
                              Text('Kembali', style: TextStyle(fontSize: 20.0)),
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
        ),
      ),
    );
  }
}
