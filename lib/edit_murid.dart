// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, prefer_final_fields, sized_box_for_whitespace, non_constant_identifier_names

import 'dart:developer';

import 'package:curd_api/model/murid.dart';
import 'package:curd_api/service/service.dart';
import 'package:flutter/material.dart';

class EditMurid extends StatefulWidget {
  final DataMurid data;

  EditMurid({required this.data});

  @override
  State<EditMurid> createState() => _EditMuridState();
}

class _EditMuridState extends State<EditMurid> {
  TextEditingController _nisn = TextEditingController();
  TextEditingController _nama = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _kelas = TextEditingController();
  bool status = false;

  @override
  void initState() {
    setState(() {
      _nisn.text = widget.data.nisn.toString();
      _nama.text = widget.data.nameMurid;
      _email.text = widget.data.emailMurid;
      _phone.text = widget.data.numberPhoneMurid;
      _address.text = widget.data.address;
      _gender.text = widget.data.gender;
      _kelas.text = widget.data.kelasId.toString();
    });
    super.initState();
  }

  void updateData() {
    MuridService()
        .updateMurid(int.parse(_nisn.text), _nama.text, _email.text,
            _phone.text, _address.text, _gender.text, int.parse(_kelas.text))
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
        title: Text("Edit Murid"),
      ),
      body: SingleChildScrollView(
          // ignore: prefer_const_constructors
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
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
                      updateData();
                      setState(() {
                        status = true;
                      });
                    }
                  },
                  child: status == true
                  ? CircularProgressIndicator(color: Colors.white,)
                  : Text("Ubah Data")),
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
