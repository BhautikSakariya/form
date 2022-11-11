import 'package:flutter/material.dart';
import 'package:form/first.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class model {
static  double theight =0;
static double twidth =0;
static double tappbar =0;
static   double tstatusbar=0;
 static double navigationbar =0;
  static double actual_height =0;
static SharedPreferences? prefs;
static SharedPreferences? tab;
static int tabnam=1;
static int? log;


  getdim(BuildContext context)
  {
    theight=MediaQuery.of(context).size.height;
    twidth=MediaQuery.of(context).size.width;
    tappbar=kToolbarHeight;
    tstatusbar=MediaQuery.of(context).padding.top;
    navigationbar=MediaQuery.of(context).padding.bottom;

    actual_height=theight-tappbar-tstatusbar-navigationbar;

  }







   Future<Database>cratedb() async {
// Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');



// open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {

// When creating the db, create the table
      await db.execute(
          '''CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,email TEXT,contact TEXT,password TEXT,confpassword TEXT,gender TEXT,language TEXT )''');


      await db.execute('''CREATE TABLE cont$tabnam (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,contact TEXT)''');




    });

    print("Database:$database");
    return database;
  }

}
