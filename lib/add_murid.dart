// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, prefer_final_fields, sized_box_for_whitespace, non_constant_identifier_names

import 'dart:developer';

import 'package:curd_api/service/service.dart';
import 'package:flutter/material.dart';

class AddMurid extends StatefulWidget {
  @override
  State<AddMurid> createState() => _AddMuridState();
}

class _AddMuridState extends State<AddMurid> {
  TextEditingController _nisn = TextEditingController();
  TextEditingController _nama = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _kelas = TextEditingController();
  bool status = false;

  void simpanData() {
    MuridService()
        .saveMurid(int.parse(_nisn.text), _nama.text, _email.text, _phone.text,
            _address.text, _gender.text, int.parse(_kelas.text))
        .then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, "/");
      } else {
        setState(() {
          status = false;
        });
        log("gagal");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Murid"),
      ),
      body: SingleChildScrollView(
          // ignore: prefer_const_constructors
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Custom_TextField(_nisn, "Masukkan Nisn"),
            Custom_TextField(_nama, "Masukkan Nama"),
            Custom_TextField(_email, "Masukkan Email"),
            Custom_TextField(_phone, "Masukkan Nomor Telepon"),
            Custom_TextField(_address, "Masukkan Alamat"),
            Custom_TextField(_gender, "Masukkan Jenis Kelamin"),
            Custom_TextField(_kelas, "Masukkan ID Kelas"),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    if (!status) {
                      simpanData();
                      setState(() {
                        status = true;
                      });
                    }
                  },
                  child: status
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("Simpan Data")),
            )
          ],
        ),
      )),
    );
  }
}

Widget Custom_TextField(TextEditingController controller, String label) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
          label: Text(label),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.blue))),
    ),
  );
}
