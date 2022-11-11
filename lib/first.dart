import 'package:flutter/material.dart';
import 'package:form/login.dart';
import 'package:form/model.dart';
import 'package:form/viewpage.dart';
import 'package:sqflite/sqflite.dart';

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  @override

  Database? db;

  void initState() {
    super.initState();
    initdb();
  }

  initdb() async {
    db = await model().cratedb();
  }

  TextEditingController tname = TextEditingController();
  TextEditingController temail = TextEditingController();
  TextEditingController tcont = TextEditingController();
  TextEditingController tpass = TextEditingController();
  TextEditingController tconfpass = TextEditingController();
  List<String> lang = [
    "Hindi",
    "Gujrati",
    "English",
    "Marathi",
    "Tamil",
    "Telgu",
    "urdu"
  ];
  List<bool> lang_sel = [false, false, false, false, false, false, false];

  bool name = false;
  bool emailValid = true;
  bool emailemp = false;
  bool contemt = false;
  bool contvalid = true;
  bool passshow = true;
  bool cpassshow = true;
  bool passvalid = true;
  bool passemt = false;
  bool cpassemt = false;
  String emailerr = "";
  String conterr = "";
  String passerr = "";
  String selectval = "Male";
  String? tgender = null;
  String? tlanguage = null;
  String tlang = "";
  int? a;
  @override
  Widget build(BuildContext context) {
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
                height: 500,
                width: 300,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black87),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white54),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Ragister",
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    if (name) {
                                      if (value.isNotEmpty) {
                                        name = false;
                                      }
                                    }
                                  });
                                },
                                controller: tname,
                                decoration: InputDecoration(
                                  hintText: "Enter Name",
                                  labelText: "Name",
                                  errorText: name ? "Please Enter Name" : null,
                                  prefixIcon: Icon(Icons.person),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: temail,
                                onChanged: (value) {
                                  setState(() {
                                    if (emailemp) {
                                      if (value.isNotEmpty) {
                                        emailemp = false;
                                      }
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  hintText: "Enter Email",
                                  errorText: emailemp ? emailerr : null,
                                  prefixIcon: Icon(Icons.mail),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: tcont,
                                onChanged: (value) {
                                  setState(() {
                                    if (contemt) {
                                      if (value.isNotEmpty) {
                                        contemt = false;
                                      }
                                    }
                                  });
                                },
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: "Enter Contact No",
                                  labelText: "Contact",
                                  counterText: "",
                                  errorText: contemt ? conterr : null,
                                  prefixIcon: Icon(Icons.phone),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    if (passemt) {
                                      if (value.isNotEmpty) {
                                        passemt = false;
                                      }
                                    }
                                  });
                                },
                                controller: tpass,
                                obscureText: passshow,
                                decoration: InputDecoration(
                                  hintText: "Enter Password",
                                  labelText: "Password",
                                  errorText: passemt ? passerr : null,
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passshow = !passshow;
                                      });
                                    },
                                    icon: passshow
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    if (cpassemt) {
                                      if (value.isNotEmpty) {
                                        cpassemt = false;
                                      }
                                    }
                                  });
                                },
                                controller: tconfpass,
                                obscureText: cpassshow,
                                decoration: InputDecoration(
                                  hintText: "Enter Confirm Password",
                                  labelText: "Confirm Password",
                                  errorText:
                                      cpassemt ? "Enter Valid Password" : null,
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        cpassshow = !cpassshow;
                                      });
                                    },
                                    icon: cpassshow
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    children: [
                                      Text(
                                        " Gender:  ",
                                        style: TextStyle(fontSize: 15),
                                        textAlign: TextAlign.center,
                                      ),
                                      Expanded(
                                          child: Container(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: "Male",
                                                groupValue: selectval,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectval =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              Text("  Male  "),
                                              Radio(
                                                value: "Female",
                                                groupValue: selectval,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectval =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              Text("  Female  "),
                                            ],
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5)),
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Text(
                                      "  Language:  ",
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                value: lang_sel[0],
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      lang_sel[0] = value;
                                                      if (value) {
                                                        tlang = ("$tlang" +
                                                            "${lang[0]},");
                                                      }
                                                    });
                                                  }
                                                },
                                              ),
                                              Text(lang[0]),
                                              Checkbox(
                                                value: lang_sel[1],
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      lang_sel[1] = value;
                                                      if (value) {
                                                        tlang = ("$tlang" +
                                                            "${lang[1]},");
                                                      }
                                                    });
                                                  }
                                                },
                                              ),
                                              Text(lang[1]),
                                              Checkbox(
                                                value: lang_sel[2],
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      lang_sel[2] = value;
                                                      if (value) {
                                                        tlang = ("$tlang" +
                                                            "${lang[2]},");
                                                      }
                                                    });
                                                  }
                                                },
                                              ),
                                              Text(lang[2]),
                                              Checkbox(
                                                value: lang_sel[3],
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      lang_sel[3] = value;
                                                      if (value) {
                                                        tlang = ("$tlang" +
                                                            "${lang[3]},");
                                                      }
                                                    });
                                                  }
                                                },
                                              ),
                                              Text(lang[3]),
                                              Checkbox(
                                                value: lang_sel[4],
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      lang_sel[4] = value;
                                                      if (value) {
                                                        tlang = ("$tlang" +
                                                            "${lang[4]},");
                                                      }
                                                    });
                                                  }
                                                },
                                              ),
                                              Text(lang[4]),
                                              Checkbox(
                                                value: lang_sel[5],
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      lang_sel[5] = value;
                                                      if (value) {
                                                        tlang = ("$tlang" +
                                                            "${lang[5]},");
                                                      }
                                                    });
                                                  }
                                                },
                                              ),
                                              Text(lang[5]),
                                              Checkbox(
                                                value: lang_sel[6],
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      lang_sel[6] = value;
                                                      if (value) {
                                                        tlang = ("$tlang" +
                                                            "${lang[6]},");
                                                      }
                                                    });
                                                  }
                                                },
                                              ),
                                              Text(lang[6]),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Expanded(
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5)),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        child: TextField(),
                                      )),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Unknown"))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          String txtname = tname.text;
                          String txtemail = temail.text;
                          String txtcont = tcont.text;
                          String txtpass = tpass.text;
                          String txtcpass = tconfpass.text;
                          emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(txtemail);
                          contvalid = txtcont.length == 10;
                          passvalid = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(txtpass);
                          setState(() async {
                            if (txtname.isEmpty) {
                              name = true;
                            } else if (txtemail.isEmpty) {
                              emailemp = true;
                              emailerr = "Please Enter Email";
                            } else if (!emailValid) {
                              emailemp = true;
                              emailerr = "Please Enter Valid Email";
                            } else if (txtcont.isEmpty) {
                              contemt = true;
                              conterr = "Please Enter Contact";
                            } else if (!contvalid) {
                              contemt = true;
                              conterr = "Please Enter Valid Contact";
                            } else if (txtpass.isEmpty) {
                              passemt = true;
                              passerr = "Please Enter Password";
                            } else if (!passvalid) {
                              passemt = true;
                              passerr =
                                  "Please Enter Valid Password \n Minimum 1 Upper case \n Minimum 1 lowercase \n Minimum 1 Numeric Number \n Minimum 1 Special Character";
                            } else if (txtcpass != txtpass) {
                              cpassemt = true;
                            } else {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return view();
                                },
                              ));

                              String insrtqury =
                                  "insert into user(name,email,contact,password,confpassword,gender,language) values('$txtname','$txtemail','$txtcont','$txtpass','$txtcpass','$selectval','$tlang')";

                              db!.rawInsert(insrtqury).then((value) {
                                a = value;
                                print("pid ==== ====== ===== $a");
                              });
                              await model.prefs!.setInt('logi', 1);
                              await model.tab!.setInt('tabname', a!);

                            }

                            setState(() {});
                          });
                        },
                        child: Text("Submit"),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black87))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
