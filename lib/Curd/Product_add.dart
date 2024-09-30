import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/Curd/Product_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Product_add extends StatefulWidget {
  const Product_add({super.key});

  @override
  State<Product_add> createState() => _Product_addState();
}

class _Product_addState extends State<Product_add> {
  var Name_ctrl = TextEditingController();
  var Details_ctrl = TextEditingController();

  Future<void> Add_product() async {
    FirebaseFirestore.instance.collection('productlist').add(
        {"productname": Name_ctrl.text, "productdetail": Details_ctrl.text});
    print(
        "Added Successfully/////////////////////////////////////////////////////");
    Navigator.of(context).pop();
  }

  final formkey = GlobalKey<FormState>();

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Enter The Values'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            "Add",
            style: TextStyle(color: Colors.white),
          )),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        controller: Name_ctrl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Any Value";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Name',
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(5)),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        controller: Details_ctrl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Any Value";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Details',
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(5)),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 90, right: 90),
                  child: InkWell(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        Add_product();
                      } else {
                        _showSnackBar(context);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 360,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        ));
  }
}
