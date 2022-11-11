import 'package:flutter/material.dart';
import 'package:form/insert.dart';
import 'package:form/login.dart';
import 'package:form/model.dart';
import 'package:form/update.dart';
import 'package:sqflite/sqflite.dart';

class view extends StatefulWidget {
  const view({Key? key}) : super(key: key);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  @override
  Database? db;
  String logout ="Log out";
  bool status =false;
  List<Map> l =[];
  @override
  void initState() {
    super.initState();
    model().cratedb().then((value) {
      db=value;
      String qyr ="select * from cont${model.tabnam}  ";
      db!.rawQuery(qyr).then((value) {
        l=value;
        setState(() {
          status = true;
        });
      });
    });
  }
  dbcall()
  async {
    db= await model().cratedb();
  }
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Contact"),
       actions:[
          PopupMenuButton(itemBuilder: (context) => [
         PopupMenuItem(child: Text(logout),value: logout),
      ],onSelected:(value) async {
         if(value==logout)
           {

             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
               return login();

             },));
             await model.prefs!.setInt('logi', 0);
           }
      }, ),

       ],



      ),
      floatingActionButton:FloatingActionButton(onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return insertcon();
        },));
      },child: Icon(Icons.add),),
      body:status? (l.length>0 ?ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
        Map map= l[index];
        String name1 =map['name'];
        String cont1 =map['contact'];
        int id =map['id'];
        return ListTile(onLongPress: () {
          showDialog(context: context, builder: (context) {
            return SimpleDialog(title:Text("Select Choice"),children: [
              ListTile(title: Text("Update"),onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return update(map);
                },));
              },),
              ListTile(title: Text("Delete"),
              onTap: () {
                Navigator.pop(context);
                String qry ="delete from cont${model.tabnam} where id='$id'";
                db!.rawDelete(qry).then((value) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return view();
                  },));

                });


              },)
            ],);
          },);
        },
          title: Text("$name1"),
          subtitle: Text("$cont1"),
        );
      },):Center(child: Text("No Data Found",style: TextStyle(fontSize: 30),),)):Center(child: CircularProgressIndicator(),),
    );
  }
}
