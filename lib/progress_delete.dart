import 'package:flutter/material.dart';

import 'account.dart';

class AccountProcessDelete extends StatefulWidget {
  List<Account> accountProcessList = [];
  Account selectedProcess = Account(0, "", 0.0);
  AccountProcessDelete(this.accountProcessList, this.selectedProcess);

  @override
  State<StatefulWidget> createState() {
    return _AccountProcessDeleteState(accountProcessList, selectedProcess);
  }
}

class _AccountProcessDeleteState extends State<AccountProcessDelete> {
  var formKey = GlobalKey<FormState>();
  List<Account> accountProcessList = [];
  Account selectedProcess = Account(0, "", 0.0);

  _AccountProcessDeleteState(this.accountProcessList, this.selectedProcess);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İşlem Silme Ekranı"),
      ),
      body: Column(
        children: <Widget>[
          Text("id: " + selectedProcess.id.toString()),
          Text("Description: " + selectedProcess.description),
          Text("Cost: " + selectedProcess.cost.toString()),
          Text("Yukaridaki  islemi  silmek istediginize emin misiniz ? "),
          buildDeleteButton(),
          buildCancelButton()
        ],
      ),
    );
  }

  Widget buildDeleteButton() {
    return ElevatedButton(
      child: Text("Sil"),
      onPressed: () {
        widget.accountProcessList.remove(selectedProcess);
        Navigator.pop(context);
      },
    );
  }

  Widget buildCancelButton() {
    return ElevatedButton(
      child: Text("İptal"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
