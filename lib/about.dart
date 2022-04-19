import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kisisel_muhasebe_programi/account.dart';
import 'package:kisisel_muhasebe_programi/progress_add.dart';
import 'package:kisisel_muhasebe_programi/progress_delete.dart';
import 'package:kisisel_muhasebe_programi/progress_update.dart';

class aboutProgram extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _AboutProgram();
  }
}

class _AboutProgram extends State<aboutProgram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        title: Center(child: Text("Kişisel Muhasebe Programi")),
      ),
      body: Column(
        children: <Widget>[

          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/selman_tercioglu.jpg'),
          ),
          Text(
            "Ahmet Selman Tercioğlu",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Bilgisayar Mühendisliği",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Öğrenci NO: 20212013123",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
            width: 200,
            child: Divider(
              color: Colors.white,
            ),
          ),
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: ListTile(
              leading: Icon(
                Icons.phone
              ),
              title: Text("+90 551 024 77 66"),
            ),
          ),
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: ListTile(
              leading: Icon(
                  Icons.mail
              ),
              title: Text("selmantercioglu@gmail.com"),
            ),
          ),
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: ListTile(
              leading: Icon(
                  Icons.account_box
              ),
              title: Text("Dr. Öğr. Üyesi Buket İşler"),
            ),
          ),

        ],
      ),
    );
  }
}
