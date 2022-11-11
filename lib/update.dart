import 'package:flutter/material.dart';
import 'package:form/model.dart';
import 'package:form/viewpage.dart';
import 'package:sqflite/sqflite.dart';

class update extends StatefulWidget {
  Map map;
  update(this.map);

 

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  Database? db;
  TextEditingController tname = TextEditingController();
  TextEditingController tcont = TextEditingController();
  @override
  void initState() {
  super.initState();
  tname.text = widget.map['name'];
  tcont.text=widget.map['contact'];
  model().cratedb().then((value) {
    db = value;
  });
  }
  Future<bool> goback()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return view();
      },
    ));
    return Future.value();
  }
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(appBar: AppBar(
        title: Text("Update"),
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return view();
            },
          ));
        }, icon: Icon(Icons.arrow_back)),
      ),
    body:ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: tname,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: tcont,
          ),
        ),
        ElevatedButton(onPressed: () {
          String name1 = tname.text;
          String cont1 = tcont.text;
          int id = widget.map['id'];

          String qry = "update cont${model.tabnam}  set name='$name1',contact='$cont1' where id='$id' ";
          db!.rawUpdate(qry).then((value){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return view();
            },));
          });

        }, child: Text("Update"))
      ],
    ),
      ),
    onWillPop: goback,);
  }


}
