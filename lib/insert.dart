import 'package:flutter/material.dart';
import 'package:form/model.dart';
import 'package:form/viewpage.dart';
import 'package:sqflite/sqflite.dart';

class insertcon extends StatefulWidget {
  const insertcon({Key? key}) : super(key: key);

  @override
  State<insertcon> createState() => _insertconState();
}

class _insertconState extends State<insertcon> {
  TextEditingController tname = TextEditingController();
  TextEditingController tcont = TextEditingController();
  Database? db;

  @override

 void initState() {
  super.initState();
  model().cratedb().then((value) {
    db=value;
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
      child: Scaffold(
        appBar: AppBar(title: Text("Insert"), leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return view();
            },
          ));
        }, icon: Icon(Icons.arrow_back)),),
        body:ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: tname,
                decoration: InputDecoration(
                  hintText: "Enter Name",
                  labelText: "Name",

                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: tcont,
                keyboardType: TextInputType.number,
                maxLength: 10,

                decoration: InputDecoration(
                    hintText: "Enter Contact",
                    labelText: "Contact",
                  counterText: "",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(onPressed: () {
              String name1 = tname.text;
              String cont1 =tcont.text;

              String qry = "insert into cont${model.tabnam}  (name,contact) values ('$name1','$cont1')";

              db!.rawInsert(qry).then((value) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return view();
                },));
              });


            }, child: Text("Save")),

          ],
        )
      ),
   onWillPop:goback, );
  }


}
