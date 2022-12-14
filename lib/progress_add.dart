import 'package:flutter/material.dart';
import 'account.dart';
import 'package:kisisel_muhasebe_programi/sql.dart';


class AccountProcessAdd extends StatefulWidget {
  List<Account> accountProcessList = [];
  AccountProcessAdd(this.accountProcessList);

  @override
  State<StatefulWidget> createState() {
    return _AccountProcessAddState();
  }
}

class _AccountProcessAddState extends State<AccountProcessAdd> {
  var formKey = GlobalKey<FormState>();
  var lastProcess = Account(0, "", 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni İşlem Ekranı"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              buildDescriptionField(),
              buildCostField(),
              buildSubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Islem Aciklamasi",
        hintText: "Kira Odemesi vb.",
      ),
      onSaved: (String? value) {
        lastProcess.description = value!;
      },
    );
  }

  buildCostField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Fiyat",
        hintText: "Ornek: '100' vb.",
      ),
      onSaved: (String? value) {
        lastProcess.cost = double.parse(value!);
      },
    );
  }

  Future<void> _addItem(lastProcess) async {
    await SQLHelper.createItem(lastProcess.description, lastProcess.cost);
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
      child: Text("Kaydet"),
      onPressed: () {
        lastProcess.id = widget.accountProcessList.length;
        formKey.currentState?.save();
        widget.accountProcessList.add(lastProcess);
        _addItem(lastProcess);
        Navigator.pop(context);
      },
    );
  }

  /*
  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _titleController.text, _descriptionController.text);
    _refreshJournals();
  }
*/


}
