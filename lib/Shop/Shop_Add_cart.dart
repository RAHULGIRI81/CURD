import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/Shop/Shop_View_cart.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class ShopAddCart extends StatefulWidget {
  const ShopAddCart({super.key});

  @override
  State<ShopAddCart> createState() => _ShopAddCartState();
}

class _ShopAddCartState extends State<ShopAddCart> {
  var Name_ctrl = TextEditingController();
  var Price_ctrl = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Future<void> Add_cart() async {
    FirebaseFirestore.instance.collection('cartlist').add(
        {"Itemname": Name_ctrl.text, "price": Price_ctrl.text,"catogry":_selectedItem});
    print(
        "Added Successfully/////////////////////////////////////////////////////");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return View_product();
    },));
  }

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

  String _selectedItem = 'Select';
  final List<String> _options = [
    'Fruit',
    'Vegitable',
    'Grocery',
    'Select',
  ];

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
                Container(width: 200,height: 200,decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/gocery.png'),fit:BoxFit.cover),color:Colors.white,borderRadius: BorderRadius.circular(40) ),),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Productname',style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: Name_ctrl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Any Value";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Product Name',
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(5)),
                            fillColor: Colors.white,
                            filled: true),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Select',style: TextStyle(color: Colors.black),
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
                                  padding: const EdgeInsets.only(left: 230),
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
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    children: [Row(
                      children: [
                        Text(
                          'Product price',style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                      TextFormField(
                        controller: Price_ctrl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Any Value";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Price',
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(5)),
                            fillColor: Colors.white,
                            filled: true),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    if (formkey.currentState!.validate() &&
                        _selectedItem != 'Select') {
                      print('Detail Submited');

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return View_product();
                        },
                      ));
                      Add_cart();
                    } else {
                      _showSnackBar(context);
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.purple,borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
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
