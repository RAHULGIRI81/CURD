import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Vegitables extends StatefulWidget {
  const Vegitables({super.key});

  @override
  State<Vegitables> createState() => _VegitablesState();
}

class _VegitablesState extends State<Vegitables> {
  String? id;
  var Name_ctrl = TextEditingController();
  var Price_ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('cartlist').where("catogry", isEqualTo: "Vegitable").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: Colors.red,
          );
        }
        if (snapshot.hasError) {
          return Text('error: ${snapshot.error}');
        }
        final cart = snapshot.data?.docs ?? [];
        return ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            final doc = cart[index];
            final cartdetails = doc.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green, width: 4)),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Name :${cartdetails["Itemname"] ?? ''} ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Name :${cartdetails["price"] ?? ''} ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ));
  }
}
