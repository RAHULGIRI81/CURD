import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product_Description extends StatefulWidget {
  const Product_Description({super.key, required this.id});
  final id;

  @override
  State<Product_Description> createState() => _Product_DescriptionState();
}

class _Product_DescriptionState extends State<Product_Description> {
  Future<void> GetbyId() async {
    product = await FirebaseFirestore.instance
        .collection("productlist")
        .doc(widget.id)
        .get();
  }

  DocumentSnapshot? product;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetbyId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasError) return Text("error=${snapshot.error}");
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Center(
              child: Text("Name",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
          body: Column(
            children: [
              Card(
                  child:Text(
            product!["productdetail"],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,),
          ),)
            ],
          ),
        );
      },
    );
  }
}