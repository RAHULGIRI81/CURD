import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/TODO_App/Todo_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todo_Add extends StatefulWidget {
  const Todo_Add({super.key});

  @override
  State<Todo_Add> createState() => _Todo_AddState();
}

class _Todo_AddState extends State<Todo_Add> {
  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Select Value'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final formkey = GlobalKey<FormState>();
  String _selectedItem = 'Select';

  final List<String> _options = [
    '10th',
    '+2',
    'UG',
    'Select',
  ];
  String Selected_item='Select';

  var Name_ctrl = TextEditingController();
  var Age_ctrl = TextEditingController();
  var Address_ctrl = TextEditingController();
  var Email_ctrl = TextEditingController();
  var Qualification_ctrl = TextEditingController();



  Future<void> Add_Todo() async {
    FirebaseFirestore.instance.collection('Todolist').add({
      "name": Name_ctrl.text,
      "Age": Age_ctrl.text,
      "Address": Address_ctrl.text,
      "Email": Email_ctrl.text,
      "Qualification": _selectedItem,
    });
    print("Add successfully data******************************");
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                      child: Text(
                    'BIO DATA',style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                  )),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Name:',style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter any Value";
                    }
                  },
                  controller: Name_ctrl,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      focusColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: ' Full Name'),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Age:',style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter any Value";
                    }
                  },
                  controller: Age_ctrl,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Age',
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Email:',style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter any Value";
                    }
                  },
                  controller: Email_ctrl,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: '@gmail.com',
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Address:',style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter any Value";
                    }
                  },
                  maxLines: 3,
                  controller: Address_ctrl,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Address',
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Qualification',style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: 400,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: DropdownButton<String>(
                              value: _selectedItem,
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 260),
                                child: Icon(
                                  Icons.arrow_drop_down_outlined,
                                  size: 40,
                                ),
                              ),
                              items: _options.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedItem = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    if (formkey.currentState!.validate() &&
                        _selectedItem != 'Select') {
                      print('Detail Submited');
                      Add_Todo();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Todo_view();
                        },
                      ));
                    } else {
                      _showSnackBar(context);
                    }
                  },
                  child: Container(
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.blue,),
                    child: Center(
                        child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
