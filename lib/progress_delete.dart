import 'package:flutter/material.dart';

import 'account.dart';

class AccountProcessDelete extends StatefulWidget {

  var selectedProcess = Account(0,"",0.0);
  AccountProcessDelete(this.selectedProcess);

  @override
  State<StatefulWidget> createState() {
    return _AccountProcessDeleteState();
  }
}

class _AccountProcessDeleteState extends State<AccountProcessDelete> {
  var formKey = GlobalKey<FormState>();

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
              buildDeleteButton()
            ],

          ),

        ),
      ),
    );
  }

  Widget buildDeleteButton(){
    return ElevatedButton(
      child: Text("Sil"),
      onPressed: (){
        Navigator.pop(context);
      },
    );
  }
  Widget buildCancelButton(){
    return ElevatedButton(
      child: Text("İptal"),
      onPressed: (){
        Navigator.pop(context);
      },
    );
  }
}
