import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisisel_muhasebe_programi/account.dart';
import 'package:kisisel_muhasebe_programi/progress_add.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State {
  List<Account> accountProcessList = [
    Account(0, "acıklama ", 10.0),
    Account(1, "acıklama2 ", 23.0),
    Account(2, "buda son harcama ", 27.0),
  ];
  Account selectedAccountProcess = Account(0, "", 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Kişisel Muhasebe Programi")),
        ),
        body: showLastProgress()
    );
  }

  Widget showLastProgress() {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: accountProcessList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(accountProcessList[index].description),
                    subtitle: Text(accountProcessList[index].cost.toString()),
                    onLongPress: () {
                      setState(() {
                        selectedAccountProcess = accountProcessList[index];
                      });
                    },
                  );
                })),
        Text("Seçili İşlem: " + selectedAccountProcess.description),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Yeni islem")
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>AccountProcessAdd(accountProcessList)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black12,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.update),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Guncelle")
                  ],
                ),
                onPressed: () {
                  print("Guncelle butonuna basildi.");
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.amberAccent,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.remove_circle_outline),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Sil"),
                  ],
                ),
                onPressed: () {
                  print("Sil butonuna basildi.");
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
