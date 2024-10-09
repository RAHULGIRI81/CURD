import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class Fruits extends StatefulWidget {
  const Fruits({super.key});

  @override
  State<Fruits> createState() => _FruitsState();
}

class _FruitsState extends State<Fruits> {
  String? id;
  var Name_ctrl = TextEditingController();
  var Price_ctrl = TextEditingController();
  Future<void> delete(String id) async {
    await FirebaseFirestore.instance.collection("cartlist").doc(id).delete();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('cartlist')
          .where("catogry", isEqualTo: "Fruit")
          .snapshots(),
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
              child: Slidable(

                key: const ValueKey(0),

                // The start action pane is the one at the left or the top side.
                startActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const ScrollMotion(),

                  // A pane can dismiss the Slidable.
                  dismissible: DismissiblePane(onDismissed: () {
                    delete(doc.id);
                  }),

                  // All actions are defined in the children parameter.
                  children:  [
                    // A SlidableAction can have an icon and/or a label.
                    SlidableAction(
                      onPressed: (context) {
                           delete(doc.id);
                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),

                // The end action pane is the one at the right or the bottom side.


                // The child of the Slidable is what the user sees when the
                // component is not dragged.

                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.purple, width: 4)),
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
              ),
            );
          },
        );
      },
    ));
  }
}
