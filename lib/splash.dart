import 'package:flutter/material.dart';
import 'package:form/first.dart';
import 'package:form/login.dart';
import 'package:form/model.dart';
import 'package:form/viewpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override


  void initState() {
    super.initState();
    spl();
    intipref();
  }
  intipref()
  async {
     model.prefs = await SharedPreferences.getInstance();
      model.log = model.prefs!.getInt('logi') ?? 0;
     model.tab = await SharedPreferences.getInstance();
     model.tabnam = model.prefs!.getInt('tabname') ?? 1;

      setState(() {

      });

  }
  spl()
  async {
     await Future.delayed(Duration(milliseconds: 1500));
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
       return model.log==0? login(): view() ;
     },));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Ragister\n   form",style: TextStyle(fontSize: 50),),),
    );
  }


}
