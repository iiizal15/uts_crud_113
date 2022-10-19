// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, unused_element, unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'form_sewaps.dart';

import 'databaseSewa/dbsewa_helper.dart';
import 'model/sewaps.dart';

class ListSewaPage extends StatefulWidget {
  const ListSewaPage({Key? key}) : super(key: key);

  @override
  _ListSewaPageState createState() => _ListSewaPageState();
}

class _ListSewaPageState extends State<ListSewaPage> {
  List<SewaPS> listSewa = [];
  DbSewa db = DbSewa();

  @override
  void initState() {
    //menjalankan fungsi getallSewa saat pertama kali dimuat
    _getAllSewa();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Aplikasi Penyewaan Rental PS"),
        ),
      ),
      body: ListView.builder(
          itemCount: listSewa.length,
          itemBuilder: (context, index) {
            SewaPS sewa = listSewa[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                shape: Border(bottom: BorderSide(color: Colors.grey)),
                // leading: Icon(
                //   Icons.person,
                //   size: 50,
                // ),
                title: Text('${sewa.name}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Email: ${sewa.email}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Phone: ${sewa.mobileNo}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Company: ${sewa.company}"),
                    )
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(sewa);
                          },
                          icon: Icon(Icons.edit)),
                      // button hapus
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          //membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: Text("Information"),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      "Apakah ingin Menghapus Data ${sewa.name} ?")
                                ],
                              ),
                            ),
                            //terdapat 2 button.
                            //jika ya maka jalankan _deleteSewa() dan tutup dialog
                            //jika tidak maka tutup dialog
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _deleteSewa(sewa, index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ya")),
                              TextButton(
                                child: Text('Tidak'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      //membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }

  //mengambil semua data Sewa
  Future<void> _getAllSewa() async {
    //list menampung data dari database
    var list = await db.getAllKontak();

    //ada perubahanan state
    setState(() {
      //hapus data pada listSewa
      listSewa.clear();

      //lakukan perulangan pada variabel list
      list!.forEach((sewa) {
        //masukan data ke listSewa
        listSewa.add(SewaPS.fromMap(sewa));
      });
    });
  }

  //menghapus data Sewa
  Future<void> _deleteSewa(SewaPS sewa, int position) async {
    await db.deleteSewa(sewa.id!);
    setState(() {
      listSewa.removeAt(position);
    });
  }

  // membuka halaman tambah Sewa PS
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormSewa()));
    if (result == 'save') {
      await _getAllSewa();
    }
  }

  //membuka halaman edit Sewa PS
  Future<void> _openFormEdit(SewaPS sewa) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormSewa(sewa: sewa)));
    if (result == 'update') {
      await _getAllSewa();
    }
  }
}
