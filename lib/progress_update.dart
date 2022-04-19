import 'package:flutter/material.dart';

import 'account.dart';

class AccountProcessUpdate extends StatefulWidget {

  List<Account> accountProcessList = [];
  Account selectedProcess = Account(0, "", 0.0);

  AccountProcessUpdate(this.accountProcessList,  this.selectedProcess);

  @override
  State<StatefulWidget> createState() {
    return _AccountProcessUpdateState(accountProcessList, selectedProcess);
  }
}

class _AccountProcessUpdateState extends State<AccountProcessUpdate> {
  var formKey = GlobalKey<FormState>();
  List<Account> accountProcessList = [];
  Account selectedProcess = Account(0, "", 0.0);

  _AccountProcessUpdateState(this.accountProcessList, this.selectedProcess);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("İşlem Güncelleme Ekranı"),),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                buildTextFormField(),
                buildDescriptionField(),
                buildCostField(),
                buildSubmitButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildDescriptionField(){
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Islem Aciklamasi",
          hintText: "Onceki deger: " + selectedProcess.description,
      ),
      onSaved: (String? value){
        selectedProcess.description = value!;
      },
    );
  }

  Widget buildTextFormField(){
    return Column(
      children: [
        Text("id: " + selectedProcess.id.toString(), style: Theme.of(context).textTheme.headline6),
        Text("Description: " + selectedProcess.description, style: Theme.of(context).textTheme.headline6),
        Text("Cost: " + selectedProcess.cost.toString(),  style: Theme.of(context).textTheme.headline6),
        Text("Yukarıdaki bilgileri guncellemek isterseniz asagıdakı kutucuklari  yeniden doldurunuz."),
        Text("Eger guncellemek istemezseniz geriye cikabilirsiniz. "),
      ],
    );
  }
  buildCostField(){
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Fiyat",
          hintText: "Onceki  deger: " + selectedProcess.cost.toString(),
      ),
      onSaved: (String? value){
        selectedProcess.cost = double.parse(value!);
      },
    );
  }

  Widget buildSubmitButton(){
    return ElevatedButton(
      child: Text("Kaydet"),
      onPressed: (){
        formKey.currentState?.save();
        widget.accountProcessList[selectedProcess.id] = selectedProcess;
        Navigator.pop(context);
      },
    );
  }
}
