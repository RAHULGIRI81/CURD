import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
              child: Text("Name",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
          body: Column(
            children: [
              Card(
                child:Text(
                  Todo!["Todo"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,),
                ),)
            ],
          ),
        );
      },
    );
  }
}