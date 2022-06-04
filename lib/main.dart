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
  List<Map<String, dynamic>> _DatabaseData = [];

  List<Account> accountProcessList = [
    Account(0, "Kiraa", -3000.0),
    Account(1, "Maaş ", 7000.0),
    Account(2, "Market Alışverişi ", 27.0),
  ];
  Account selectedAccountProcess = Account(0, "", 0.0);

  bool _isLoading = true;

  void _refresh_db_item() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _DatabaseData = data;
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
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Kişisel Muhasebe Programi")),
        ),
        body: showLastProgress());
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
    setState(() {});
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
    double sum = 0.0;
    for (int i = 0; i<accountProcessList.length; i++){
      sum += accountProcessList[i].cost;
    }
    return sum;
  }
}
