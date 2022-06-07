import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kisisel_muhasebe_programi/account.dart';
import 'package:kisisel_muhasebe_programi/progress_add.dart';
import 'package:kisisel_muhasebe_programi/progress_delete.dart';
import 'package:kisisel_muhasebe_programi/progress_update.dart';
import 'about.dart';

import 'package:kisisel_muhasebe_programi/sql.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  List<Map<String, dynamic>> _databaseData = [];


  List<Account> accountProcessList = [];
  Account selectedAccountProcess = Account(0, "", 0.0);

  bool _isLoading = true;
  var id_list = new Map();

  void _refresh_db_item() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _databaseData = data;
      _isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    _refresh_db_item(); // Loading the diary when the app starts
  }

  @override
  Widget build(BuildContext context) {
    _refresh_db_item();

    var x =  Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Kişisel Muhasebe Programi")),
        ),
        body: showLastProgress());

    return x;
  }

  void navigateNewProcessPage() {
    Route route = MaterialPageRoute(
        builder: (context) => AccountProcessAdd(accountProcessList));
    Navigator.push(context, route).then((onGoBack));
  }

  void navigateDeleteProcessPage() {
    Route route = MaterialPageRoute(
        builder: (context) =>
            AccountProcessDelete(accountProcessList, selectedAccountProcess));
    Navigator.push(context, route).then((onGoBack));
  }

  void navigateUpdateProcessPage() {
    Route route = MaterialPageRoute(
        builder: (context) =>
            AccountProcessUpdate(accountProcessList, selectedAccountProcess));
    Navigator.push(context, route).then((onGoBack));
  }

  void navigateAboutProcessPage() {
    Route route = MaterialPageRoute(
        builder: (context) =>
            aboutProgram());
    Navigator.push(context, route).then((onGoBack));
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {
      _refresh_db_item();
    });
  }

  Widget showLastProgress() {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: _databaseData.length,
                itemBuilder: (BuildContext context, int index) {
                  id_list.clear();

                  return ListTile(
                    // title: Text(accountProcessList[index].description),
                    title: Text(_databaseData[index]['description']),
                    subtitle: Text(_databaseData[index]['cost'].toString()),
                    onLongPress: () {
                      setState(() {
                        id_list[index] = _databaseData[index]['id'];
                        selectedAccountProcess.id = id_list[index];
                        selectedAccountProcess.description = _databaseData[index]['description'];
                        selectedAccountProcess.cost = _databaseData[index]['cost'].toDouble();
                      });
                    },
                  );
                })),
        Text("Toplam Gelir-Gider Durumu (TL): " + accountCalculator().toString(), style: Theme.of(context).textTheme.headline6),
        Text("Seçili İşlem: " + selectedAccountProcess.description, style: Theme.of(context).textTheme.headline6),
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
                  navigateNewProcessPage();
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
                  navigateUpdateProcessPage();
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
                  navigateDeleteProcessPage();
                },
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Text("HAKKINDA")
                  ],
                ),
                onPressed: () {
                  navigateAboutProcessPage();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
  accountCalculator(){
    _refresh_db_item();
    double sum = 0.0;
    for (int i = 0; i<_databaseData.length; i++){
      sum += _databaseData[i]['cost'];
    }
    return sum;
  }
}
