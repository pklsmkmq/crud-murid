// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_is_empty, avoid_print, unused_element

import 'dart:developer';

import 'package:curd_api/add_murid.dart';
import 'package:curd_api/edit_murid.dart';
import 'package:curd_api/model/murid.dart';
import 'package:curd_api/service/service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // home: HomeMurid(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeMurid(),
        '/addMurid': (context) => AddMurid(),
        '/editMurid': (context) => EditMurid(
            data: ModalRoute.of(context)?.settings.arguments as DataMurid)
      },
    );
  }
}

class HomeMurid extends StatefulWidget {
  @override
  State<HomeMurid> createState() => _HomeMuridState();
}

class _HomeMuridState extends State<HomeMurid> {
  List<DataMurid> data = [];
  _getData() {
    MuridService().getMurid().then((value) {
      if (value != false) {
        setState(() {
          print(value);
          data = value;
          data.sort((a, b) =>
              a.nameMurid.toLowerCase().compareTo(b.nameMurid.toLowerCase()));
        });
      }
    });
  }

  _hapusData(int nisn) {
    MuridService().deleteMurid(nisn).then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, "/");
      } else {
        log("Gagal Hapus");
      }
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Murid"),
        automaticallyImplyLeading: false, //Mengha..
      ),
      body: data.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(data[index].nameMurid),
                    subtitle: Text(data[index].nisn.toString()),
                    // ignore: prefer_const_literals_to_create_immutables
                    trailing: InkWell(
                      child: Icon(Icons.delete_outline, color: Colors.red),
                      onTap: () {
                        _hapusData(data[index].nisn);
                      },
                    ),
                    onTap: (() => Navigator.pushNamed(context, "/editMurid",
                        arguments: data[index])));
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addMurid');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
