import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/Curd/Product_Details.dart';
import 'package:crud/Curd/Product_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Product_view extends StatefulWidget {
  const Product_view({super.key});

  @override
  State<Product_view> createState() => _Product_viewState();
}

class _Product_viewState extends State<Product_view> {
  var _nameController = TextEditingController();
  var _phone = TextEditingController();

  String? id;
  Future<void> delete(String id) async {
    await FirebaseFirestore.instance.collection("productlist").doc(id).delete();
  }

  Future<void> _updateProduct(
      String id, String name, String description) async {
    _nameController.text = name;
    _phone.text = description;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: _phone,
                decoration: InputDecoration(labelText: 'Product Description'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('productlist')
                    .doc(id)
                    .update({
                  'productname': _nameController.text,
                  'productdetail': _phone.text,
                });
                _nameController.clear();
                _phone.clear();
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Product_add();
              },
            ));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.black,
        title: Text("                    View",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('productlist').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(
              color: Colors.red,
            );
          }
          if (snapshot.hasError) {
            return Text('error: ${snapshot.error}');
          }
          final product = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemBuilder: (context, index) {
              final doc = product[index];
              final productdetails = doc.data() as Map<String, dynamic>;

              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Product_Description(id: doc.id);
                        },
                      ));
                    },
                    child: Card(
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "Name :${productdetails["productname"] ?? ''} ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "Details :,${productdetails["productdetail"] ?? ''}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        _updateProduct(
                                            doc.id,
                                            productdetails["productname"],
                                            productdetails["productdetail"]);
                                      },
                                      child: Icon(Icons.update)),
                                  InkWell(
                                      onTap: () {
                                        delete(doc.id);
                                      },
                                      child: Icon(Icons.delete))
                                ],
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.blue, Colors.purple]),
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
              );

              /* Card(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Name :${productdetails["productname"] ?? ''} ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Details :${productdetails["productdetail"] ?? ''}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 160,
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return Product_update();
                                      },
                                    ));
                                  },
                                  icon: Icon(
                                    Icons.update_sharp,
                                    color: Colors.black,
                                  ))
                            ],
                          ),
                          SizedBox(),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    CupertinoIcons.delete,
                                    color: Colors.black,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),*/
            },
            itemCount: product.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Product_add(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
