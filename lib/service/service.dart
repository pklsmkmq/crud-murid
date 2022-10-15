// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps
import 'dart:convert';

import 'package:curd_api/model/murid.dart';
import 'package:http/http.dart' as http;

class MuridService {
  String url = "https://app-sekolah.herokuapp.com/api/murid";

  Future getMurid() async {
    Uri urlData = Uri.parse(url);

    final response = await http.get(urlData);

    if (response.statusCode == 200) {
      List<DataMurid> data = dataMuridFromJson(response.body.toString());
      print("berhasil");
      return data;
    } else {
      print("gagal");
      return false;
    }
  }

  Future saveMurid(int nisn, String nama, String email, String phone,
      String address, String gender, int kelas) async {
    Uri urlData = Uri.parse(url);

    Map data = {
      "nisn": nisn,
      "name_murid": nama,
      "email_murid": email,
      "number_phone_murid": phone,
      "address": address,
      "gender": gender,
      "kelas_id": kelas
    };

    var body = json.encode(data);

    final response = await http.post(urlData,
        body: body, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      print("berhasil");
      return true;
    } else {
      print("gagal");
      return false;
    }
  }

  Future updateMurid(int nisn, String nama, String email, String phone,
      String address, String gender, int kelas) async {
    Uri urlData = Uri.parse(url + "/${nisn}");  

    Map data = { 
      "name_murid": nama,
      "email_murid": email,
      "number_phone_murid": phone,
      "address": address,
      "gender": gender,
      "kelas_id": kelas
    };

    var body = json.encode(data);

    final response = await http.put(urlData,
        body: body, headers: {"Content-Type": "application/json"});

    print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      print("berhasil");
      return true;
    } else {
      // print("gagal");
      print(response.body);
      return false;
    }
  }

  Future deleteMurid(int nisn) async { //ganti
    Uri urlData = Uri.parse(url + "/${nisn}"); //ganti

    final response = await http.delete(urlData); //ganti

    if (response.statusCode == 200) {
      print("berhasil");
      return true; //hapus data & ubah jadi true
    } else {
      print("gagal");
      return false;
    }
  }
}
