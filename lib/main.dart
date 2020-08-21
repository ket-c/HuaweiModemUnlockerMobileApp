//Author: Kwaku AMoh-Aboagye
//twitter: @MrKwakuAmoh
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Huawei Modem Unlocker', home: MyCustomForm());
  }
}

//variables
String v1Unlock = '';
String v2Unlock = '';
String v3Unlock = '';
String flashToDisplay = '';
String imeiToDisplay = '';
String errMessage = '';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  // connect to my unlock api
  Future<dynamic> unlockModem() async {
    if (myController.text.length < 15) {
      setState(() {
        errMessage = 'IMEI should be 15 digits';
      });
    } else {
      errMessage = '';
      try {
        setState(() {
          errMessage = 'Processing.. Make sure IMEI is valid';
        });
        final response = await http.post("https://hwcalc.ga/unlock.php",
            body: {"imei": myController.text});
        if (response.body.isNotEmpty) {
          errMessage = 'Done';
          return response.body;
        } else {
          errMessage = 'Error! Make sure the IMEI is valid';
          v1Unlock = '';
          v2Unlock = '';
          v3Unlock = '';
          flashToDisplay = '';
          imeiToDisplay = '';
        }
      } on SocketException catch (e) {
        errMessage = 'Error! Check connection, internet needed';
      }
    }
  }

  // call unlock
  dynamic unlock() => unlockModem();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Huawei Modem Unlocker'),
        centerTitle: true,
        backgroundColor: Color(0xff2c2c2c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: myController,
              decoration: new InputDecoration(
                labelText: "Enter device IMEI",
                fillColor: Colors.redAccent,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                if (val.length <= 14) {
                  return "IMEI Can not be less than 15";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.number,
              maxLength: 15,
              style: new TextStyle(fontFamily: "Poppins", fontSize: 25),
            ),
            Text(
              errMessage,
              style:
                  new TextStyle(fontFamily: "Poppins", color: Colors.redAccent),
            ),
            Text('RESULTS',
                style: new TextStyle(fontFamily: "Poppins", fontSize: 20)),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('IMEI',
                          style: new TextStyle(
                              fontFamily: "Poppins", fontSize: 20)),
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(7),
                        width: 300,
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(8.0),
                            border: Border.all(
                              width: 5,
                              color: Colors.black12,
                            ),
                            color: Color(0xffEEE8E8)),
                        child: Text(
                          imeiToDisplay,
                          style: new TextStyle(
                              fontFamily: "Poppins", fontSize: 20),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Text(''),
                    ),
                    Container(
                        child: Text('UNLOCK CODES',
                            style: new TextStyle(
                                fontFamily: "Poppins", fontSize: 20)))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('V1',
                          style: new TextStyle(
                              fontFamily: "Poppins", fontSize: 20)),
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(7),
                        width: 200,
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(8.0),
                            border: Border.all(
                              width: 5,
                              color: Colors.black12,
                            ),
                            color: Color(0xffEEE8E8)),
                        child: Text(
                          v1Unlock,
                          style: new TextStyle(
                              fontFamily: "Poppins", fontSize: 20),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('V2',
                          style: new TextStyle(
                              fontFamily: "Poppins", fontSize: 20)),
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(7),
                        width: 200,
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(8.0),
                            border: Border.all(
                              width: 5,
                              color: Colors.black12,
                            ),
                            color: Color(0xffEEE8E8)),
                        child: Text(
                          v2Unlock,
                          style: new TextStyle(
                              fontFamily: "Poppins", fontSize: 20),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('V3',
                          style: new TextStyle(
                              fontFamily: "Poppins", fontSize: 20)),
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(7),
                        width: 200,
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(8.0),
                            border: Border.all(
                              width: 5,
                              color: Colors.black12,
                            ),
                            color: Color(0xffEEE8E8)),
                        child: Text(
                          v3Unlock,
                          style: new TextStyle(
                              fontFamily: "Poppins", fontSize: 20),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('Flash',
                          style: new TextStyle(
                              fontFamily: "Poppins", fontSize: 20)),
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(7),
                        width: 200,
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(8.0),
                            border: Border.all(
                              width: 5,
                              color: Colors.black12,
                            ),
                            color: Color(0xffEEE8E8)),
                        child: Text(
                          flashToDisplay,
                          style: new TextStyle(
                              fontFamily: "Poppins", fontSize: 20),
                        ))
                  ],
                ),
              ],
            ),

            //notice
            Text(
                'Note: Different devices will require different unlock codes. If you are unsure which unlock code to use for your device, kindly consult any specialist.',
                style: new TextStyle(fontFamily: "Poppins", fontSize: 15))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () async {
          errMessage = 'Processing...';
          dynamic imeiList = await unlock();
          Map<String, dynamic> map = jsonDecode(imeiList);
          //String imei = await map['imei'];
          dynamic imeiDisplay = map['imei'];
          dynamic v1 = map['v1'];
          dynamic v2 = map['v2'];
          dynamic v3 = map['v3'];
          dynamic flash = map['flash'];
          // dynamic errorMessage = map['errorMessage'];
          // if (errorMessage = !null) {
          //     errMessage = errorMessage.toString();
          //   }
          setState(() {
            v1Unlock = v1.toString() ?? '';
            v2Unlock = v2.toString() ?? '';
            v3Unlock = v3.toString() ?? '';
            flashToDisplay = flash.toString() ?? '';
            imeiToDisplay = imeiDisplay.toString() ?? '';
          });
          // return showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(
          //       backgroundColor: Color(0xff2c2c2c),
          //       contentTextStyle: new TextStyle(color: Colors.white),
          //       content: Text('IMEI: ' +
          //           imeiDisplay.toString() +
          //           '\n \n Unlock Codes \n V1: ' +
          //           v1.toString() +
          //           '\n V2: ' +
          //           v2.toString() +
          //           '\n V3: ' +
          //           v3.toString() +
          //           '\n Flash: ' +
          //           flash.toString() +
          //           '\n  \n Note: Different devices will require different V unlock codes \n' +
          //           'If you are unsure which unlock code to use for your device, kindly consult'),
          //     );
          //   },
          // );
        },
        tooltip: 'Calculate Unock Code',
        child: Icon(Icons.lock_open),
        backgroundColor: Color(0xff2c2c2c),
      ),
    );
  }
}
