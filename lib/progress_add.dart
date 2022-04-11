import 'package:flutter/material.dart';

import 'account.dart';

class AccountProcessAdd extends StatefulWidget {

  List<Account> accountProcess = [];
  AccountProcessAdd(this.accountProcess);

  @override
  State<StatefulWidget> createState() {
    return _AccountProcessAddState();
  }
}

class _AccountProcessAddState extends State<AccountProcessAdd> {
  var formKey = GlobalKey<FormState>();
  var lastProcess = Account(0,"",0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yeni ıslem Ekrai"),),
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

  buildDescriptionField(){
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Islem Aciklamasi",
          hintText: "Kira Odemesi vb.",
      ),
      onSaved: (String? value){
        lastProcess.description = value!;
      },
    );
  }
  buildCostField(){
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Fiyat",
          hintText: "Ornek: '100' vb.",
      ),
      onSaved: (String? value){
        lastProcess.cost = double.parse(value!);
      },
    );
  }

  Widget buildSubmitButton(){
    return ElevatedButton(
      child: Text("Kaydet"),
      onPressed: (){
        formKey.currentState?.save();
        widget.accountProcess.add(lastProcess);
        Navigator.pop(context);
      },
    );
  }
}
