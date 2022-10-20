// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'databaseSewa/dbsewa_helper.dart';
import 'model/sewaps.dart';

class FormSewa extends StatefulWidget {
  final SewaPS? sewa;

  FormSewa({this.sewa});

  @override
  _FormSewaState createState() => _FormSewaState();
}

class _FormSewaState extends State<FormSewa> {
  DbSewa db = DbSewa();

  TextEditingController? name;
  TextEditingController? lastName;
  TextEditingController? noHP;
  TextEditingController? email;
  TextEditingController? jenisPS;

  String? _jenisPS;
  List _jenis = ["PS3", "PS4", "PS5"];

  @override
  void initState() {
    name = TextEditingController(
        text: widget.sewa == null ? '' : widget.sewa!.nama);

    noHP = TextEditingController(
        text: widget.sewa == null ? '' : widget.sewa!.noHP);

    email = TextEditingController(
        text: widget.sewa == null ? '' : widget.sewa!.email);
    
    _jenisPS = widget.sewa == null ? 'PS3' : widget.sewa!.jenisPS;

    // jenisPS = TextEditingController(
    //     text: widget.sewa == null ? '' : widget.sewa!.jenisPS);
    
    // print (widget.sewa?.toMap()) 

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Sewa PS'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: noHP,
              decoration: InputDecoration(
                  labelText: 'No. HP',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            //   child: TextField(
            //   controller: company,
            //   decoration: InputDecoration(
            //       labelText: 'Company',
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       )),
            // ),
            // Membuat pilihan jenis PS yang akan dipilih
            child: DropdownButton(
              hint: Text('Jenis PS'),
              value: _jenisPS,
              items: _jenis
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _jenisPS = value as String;
                  jenisPS?.text = _jenisPS!;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: (widget.sewa == null)
                  ? Text(
                      'Tambah',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                if (name!.text.isEmpty ||
                    noHP!.text.isEmpty ||
                    email!.text.isEmpty ||
                    _jenisPS!.isEmpty) {
                  showAlertDialogKosong(BuildContext context) {
                    // Membuat widget untuk mengatur tombol
                    Widget okButton = TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
                    // Membuat dialog konfirmasi data jika kosong
                    AlertDialog alertKosong = AlertDialog(
                      title: Text("PERHATIAN!"),
                      content: Text("Ada Data Yang Kosong!"),
                      actions: [
                        okButton,
                      ],
                    );
                    // Untuk Menampilkan dialog data jika kosong
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alertKosong;
                      },
                    );
                  }

                  print("Alert Kosong");
                  showAlertDialogKosong(context);
                }else{
                  upsertSewa();
                }
                // upsertSewa();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertSewa() async {
    if (widget.sewa != null) {
      //update data Sewa PS
      await db.updateSewa(SewaPS.fromMap({
        'id': widget.sewa!.id,
        'nama': name!.text,
        'noHP': noHP!.text,
        'email': email!.text,
        'jenisPS': _jenisPS,
      }));
      Navigator.pop(context, 'update');
    } else {
      // Untuk tambah data Sewa PS
      await db.saveSewa(SewaPS(
        nama: name!.text,
        noHP: noHP!.text,
        email: email!.text,
        jenisPS: _jenisPS,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
