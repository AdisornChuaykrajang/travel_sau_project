// ignore_for_file: prefer_const_constructors, sort_child_properties_last, non_constant_identifier_names

import "dart:io";

import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:google_fonts/google_fonts.dart";
import "package:image_picker/image_picker.dart";
import "package:intl/intl.dart";
import "package:path_provider/path_provider.dart";
import "package:travel_sau_project/models/travel.dart";
import "package:travel_sau_project/utils/db_helper.dart";
import "package:uuid/uuid.dart";

class AddTravelUI extends StatefulWidget {
  const AddTravelUI({super.key});

  @override
  State<AddTravelUI> createState() => _AddTravelUIState();
}

class _AddTravelUIState extends State<AddTravelUI> {
  File? showImage;
  String? saveImage;

  SelectPhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    //เก็บรูปลงเครื่อง
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String newDirectory = appDirectory.path + Uuid().v4();
    File newImageFile = File(newDirectory);

    //เก็บรูปในตัวแปรที่สร้างไว้ใน DB
    saveImage = newDirectory;

    await newImageFile.writeAsBytes(File(image.path).readAsBytesSync());
    setState(() {
      showImage = newImageFile;
    });
  }

  TextEditingController placeTravelCtrl = TextEditingController(text: '');
  TextEditingController costTravelCtrl = TextEditingController(text: '');
  TextEditingController dateTravelCtrl = TextEditingController(text: '');
  TextEditingController dayTravelCtrl = TextEditingController(text: '');

  opencalendar() async {
    DateTime? dateSelect = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),
    );

    if (dateSelect != null) {
      setState(() {
        dateTravelCtrl.text = DateFormat('dd MMMM yyyy').format(dateSelect);
      });
    }
  }

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
          'เพิ่มข้อมูลการเดินทาง',
          style: GoogleFonts.kanit(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  showImage == null
                      ? CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.2,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/logo.png',
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            showImage!,
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.width * 0.4,
                            fit: BoxFit.cover,
                          ),
                        ),
                  IconButton(
                    onPressed: () {
                      SelectPhoto();
                    },
                    icon: Icon(
                      FontAwesomeIcons.photoFilm,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                  right: MediaQuery.of(context).size.width * 0.15,
                  bottom: MediaQuery.of(context).size.width * 0.05,
                ),
                child: TextField(
                  controller: placeTravelCtrl,
                  decoration: InputDecoration(
                    labelText: 'ป้อนสถานที่ที่เดินทางไป',
                    labelStyle: GoogleFonts.kanit(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                  right: MediaQuery.of(context).size.width * 0.15,
                  bottom: MediaQuery.of(context).size.width * 0.05,
                ),
                child: TextField(
                  controller: costTravelCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'ป้อนค่าใช้จ่ายในการเดินทาง (บาท)',
                    labelStyle: GoogleFonts.kanit(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                  right: MediaQuery.of(context).size.width * 0.15,
                  bottom: MediaQuery.of(context).size.width * 0.05,
                ),
                child: TextField(
                  controller: dateTravelCtrl,
                  keyboardType: TextInputType.datetime,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'เลือกวันที่เดินทาง',
                    labelStyle: GoogleFonts.kanit(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffix: IconButton(
                      onPressed: () {
                        opencalendar();
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15,
                  right: MediaQuery.of(context).size.width * 0.15,
                  bottom: MediaQuery.of(context).size.width * 0.05,
                ),
                child: TextField(
                  controller: dayTravelCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'ป้อนจำนวนวันที่เดินทางไป',
                    labelStyle: GoogleFonts.kanit(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  //Validate หน้าจอ
                  if (placeTravelCtrl.text.trim().isEmpty == true) {
                    showWarningMessage(context, 'ป้อนสถานที่ที่ไปด้วย');
                  } else if (costTravelCtrl.text.trim().isEmpty == true) {
                    showWarningMessage(context, 'ป้อนค่าใช้จ่ายในการเดินทางด้วย');
                  } else if (dateTravelCtrl.text.trim().isEmpty == true) {
                    showWarningMessage(context, 'เลือกวันที่ไปด้วย');
                  } else if (dayTravelCtrl.text.trim().isEmpty == true) {
                    showWarningMessage(context, 'ป้อนจำนวนวันที่เดินทางไปด้วย');
                  } else if (saveImage == null) {
                    showWarningMessage(context, 'เลือกรูปด้วย');
                  } else {
                    //บันทึกลงฐานข้อมูล
                    int result = await DBHelper.insertTravel(
                      Travel(
                        placeTravel: placeTravelCtrl.text,
                        costTravel: costTravelCtrl.text,
                        dateTravel: dateTravelCtrl.text,
                        dayTravel: dayTravelCtrl.text,
                        pictureTravel: saveImage,
                      ),
                    );

                    if (result != 0) {
                      Navigator.pop(context);
                    } else {
                      showWarningMessage(context,
                          'พบปัญหาในการบันทึกข้อมูล กรุณาลองใหม่อีกครั้ง');
                    }
                  }
                },
                child: Text(
                  'บันทึก',
                  style: GoogleFonts.kanit(),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.7,
                    MediaQuery.of(context).size.width * 0.125,
                  ),
                  backgroundColor: Colors.amber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}