// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:travel_sau_project/models/user.dart';
import 'package:travel_sau_project/utils/db_helper.dart';
import 'package:travel_sau_project/views/home_ui.dart';
import 'package:travel_sau_project/views/register_ui.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  bool pwdStatus = true;
  bool chkStatus = false;

  TextEditingController usernameCtrl = TextEditingController(text: '');
  TextEditingController passwordCtrl = TextEditingController(text: '');

  showWarningMessage(context, msg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('คำเตือน'),
          content: Text(msg),
          actions: <Widget>[
            ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'บันทึกการเดินทาง',
          style: TextStyle(color: Colors.grey[800]),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Text(
                  'เข้าใช้งานแอปพลิเคชัน',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'บันทึกการเดินทาง',
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Row(
                  children: [
                    Text(
                      'ชื่อผู้ใช้ :',
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextField(
                  controller: usernameCtrl,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  children: [
                    Text(
                      'รหัสผ่าน :',
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextField(
                  controller: passwordCtrl,
                  obscureText: pwdStatus,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              pwdStatus = pwdStatus == true ? false : true;
                            });
                          },
                          icon: Icon(
                            pwdStatus == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.amber,
                          ))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (usernameCtrl.text.trim().isEmpty == true) {
                      showWarningMessage(context, 'ป้อนชื่อผู้ใช้ด้วย');
                    } else if (passwordCtrl.text.trim().isEmpty == true) {
                      showWarningMessage(context, 'ป้อนรหัสผ่านด้วย');
                    } else {
                      User? user = await DBHelper.checkSignin(
                          usernameCtrl.text, passwordCtrl.text);

                      if (user == null) {
                        showWarningMessage(
                            context, 'ชื่อผู้ใช้ รหัสผ่านไม่ถูกต้อง');
                      } else {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => HomeUI()));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      fixedSize: Size(
                        MediaQuery.of(context).size.width * 0.7,
                        MediaQuery.of(context).size.height * 0.05,
                      )),
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    'จำค่าการเข้าใช่งานแอปฯ',
                  ),
                  value: chkStatus,
                  activeColor: Colors.amber,
                  onChanged: (paraValue) {
                    setState(() {
                      chkStatus = paraValue!;
                    });
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterUI(),
                        ));
                  },
                  child: Text(
                    'ลงทะเบียนเข้าใช้งาน',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
