import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Todo_Description extends StatefulWidget {
  const Todo_Description({super.key, required this.id});
  final id;

  @override
  State<Todo_Description> createState() => _Todo_DescriptionState();
}

class _Todo_DescriptionState extends State<Todo_Description> {
  Future<void> GetbyId() async {
    Todo = await FirebaseFirestore.instance
        .collection("Todolist")
        .doc(widget.id)
        .get();
  }

  DocumentSnapshot? Todo;
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
                child: Text("Person Details",
                    style: GoogleFonts.poppins(
                        color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25)),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 400,height: 300,decoration: BoxDecoration(gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.white,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Wrap(
                      children: [
                        Text(
                          Todo!["name"],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Address  :",
                                style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                Todo!["Address"],
                                style:
                                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Age  :",
                                style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                Todo!["Age"],
                                style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          children: [
                            Row(
                              children: [
                                Text(
                                  " Gender :",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                                ),
                                Text(
                                  Todo!["Gender"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Email   :",
                                style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              Text(
                                Todo!["Email"],
                                style:
                                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Qualification  :",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                                ),
                                Text(
                                  Todo!["Qualification"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ]),
                ),
              ),
            ));
      },
    );
  }
}
