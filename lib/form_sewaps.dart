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
  TextEditingController? mobileNo;
  TextEditingController? email;
  TextEditingController? company;

  String? _company;
  List _companys = ["PS3", "PS4", "PS5"];

  @override
  void initState() {
    name = TextEditingController(
        text: widget.sewa == null ? '' : widget.sewa!.name);

    mobileNo = TextEditingController(
        text: widget.sewa == null ? '' : widget.sewa!.mobileNo);

    email = TextEditingController(
        text: widget.sewa == null ? '' : widget.sewa!.email);

    company = TextEditingController(
        text: widget.sewa == null ? '' : widget.sewa!.company);

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
              controller: mobileNo,
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
            child: DropdownButton(
              hint: Text('Jenis PS'),
              value: _company,
              items: _companys
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _company = value as String;
                  company?.text = _company!;
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
                    mobileNo!.text.isEmpty ||
                    email!.text.isEmpty ||
                    company!.text.isEmpty) {
                  showAlertDialogKosong(BuildContext context) {
                    // set up the button
                    Widget okButton = TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
                    // set up the AlertDialog
                    AlertDialog alertKosong = AlertDialog(
                      title: Text("PERHATIAN!"),
                      content: Text("Ada Data Yang Kosong!"),
                      actions: [
                        okButton,
                      ],
                    );
                    // show the dialog
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
        'nohp': mobileNo!.text,
        'email': email!.text,
        'company': company!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert data Sewa PS
      await db.saveSewa(SewaPS(
        name: name!.text,
        mobileNo: mobileNo!.text,
        email: email!.text,
        company: company!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
