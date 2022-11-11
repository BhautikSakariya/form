import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form/first.dart';
import 'package:form/model.dart';
import 'package:form/viewpage.dart';
import 'package:sqflite/sqflite.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController uid = TextEditingController();
  TextEditingController pas = TextEditingController();
  Database? db;
  List<Map> l =[];
  bool passshow = true;

  void initState() {
    super.initState();
    initdb();
  }

  initdb()
  async {
    db=await model().cratedb();
  }

  @override
  Widget build(BuildContext context) {
    model().getdim(context);
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Expanded(
              child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("images/login.jpg", fit: BoxFit.fill),
          )),
          Center(
            child: Container(
              height: 277,
              width: 277,
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10),color: Colors.white54),
              child: Column(
                children: [
                  Text("Log In",style: TextStyle(fontSize: 30,color: Colors.black),),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      height: 60,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
                      child: TextField(
                        controller: uid,
                        decoration: InputDecoration(
                            hintText: "Email or Phone no"),
                      ),
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
                  child: TextField(
                    obscureText:passshow ,
                    controller: pas,
                    decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(onPressed: () {
                          setState(() {
                            passshow=!passshow;
                          });
                        }, icon: passshow ?Icon(Icons.visibility) :Icon(Icons.visibility_off) )
                    ),
                  ),
                ),
              ),

                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: InkWell(onTap: () async {
                      String password1 = pas.text;
                      String uid1 = uid.text;
                      String pass1="";
                      String qry ="select password from user where email='$uid1' or contact='$uid1'";

                      if(uid1.isEmpty)
                      {
                        Fluttertoast.showToast(
                            msg: "Please Enter Username or Password",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black87,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      db!.rawQuery(qry).then((value1) async {
                        l = value1;
                        if(l.isEmpty)
                        {
                          Fluttertoast.showToast(
                              msg: "Enter Valid Username or Password",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black87,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }

                        print( "query login = $l");
                        Map map = l[1];
                        pass1 = map['password'];
                        print("$pass1");
                        print("$password1");




                        if(password1==pass1)
                        {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) {
                            return view();
                          },));
                          await model.prefs!.setInt('logi', 1);



                          setState(() {

                          });



                        }
                        else
                        {
                                Fluttertoast.showToast(
                                    msg: "Enter valid Username or Password",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black87,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );


                        }
                      });



                      setState(() {

                      });

                    },
                      child: Container(height: 50,
                      width: 100,
                      padding: EdgeInsets.all(05),
                      alignment: Alignment.center,
                      child: Text("Log In",textAlign: TextAlign.center,style:TextStyle(fontSize: 25,color: Colors.white),),

                      decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10), color: Colors.black87,),),
                    ),
                  ),
                  InkWell(onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return first();
                    },));
                  },
                    child: Container(
                      height: 20,
                      child: Text("Ragister" ,style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
