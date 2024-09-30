import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/Curd/Product_Details.dart';
import 'package:crud/Curd/Product_add.dart';
import 'package:crud/TODO_App/Todo_Add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todo_view extends StatefulWidget {
  const Todo_view({super.key});

  @override
  State<Todo_view> createState() => _Todo_viewState();
}

class _Todo_viewState extends State<Todo_view> {
  var Name_ctrl = TextEditingController();
  var Age_ctrl = TextEditingController();
  var Address_ctrl = TextEditingController();
  var Email_ctrl = TextEditingController();
  var Qualification_ctrl = TextEditingController();

  Future<void> delete(String id) async {
    await FirebaseFirestore.instance.collection("Todolist").doc(id).delete();
  }

  Future<void> _updatebiodata(String id,String name, String Age, String Address,
       String Email, String Qualification) async {
    Name_ctrl.text = name;
    Age_ctrl.text = Age;
    Address_ctrl.text = Address;
    Email_ctrl.text = Email;
    Qualification_ctrl.text = Qualification;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Bio data Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: Name_ctrl,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: Address_ctrl,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: Age_ctrl,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              TextField(
                controller: Qualification_ctrl,
                decoration: InputDecoration(labelText: 'Qualification'),
              ),
              TextField(
                controller: Email_ctrl,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Todolist')
                    .doc(id)
                    .update({

                  'name': Name_ctrl.text,
                  'Address': Address_ctrl.text,
                  'Age':Age_ctrl.text,
                  'Qualification':Qualification_ctrl.text,
                  'Email':Email_ctrl.text,
                });
                Name_ctrl.clear();
                Age_ctrl.clear();
                Age_ctrl.clear();
                Qualification_ctrl.clear();
                Email_ctrl.clear();
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
                return Todo_Add();
              },
            ));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.black,
        title: Text("    Bio data Details",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28)),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Todolist').snapshots(),
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
              final Tododetails = doc.data() as Map<String, dynamic>;

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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                children: [
                                  Text(
                                    "Name :${Tododetails["name"] ?? ''} ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
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
                                  Text(
                                    "Address :${Tododetails["Address"] ?? ''} ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
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
                                  Text(
                                    "Age :${Tododetails["Age"] ?? ''} ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
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
                                  Text(
                                    "Email :${Tododetails["Email"] ?? ''} ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
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
                                  Text(
                                    "Qualification :${Tododetails["Qualification"] ?? ''} ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        _updatebiodata(
                                          (doc.id),
                                          Tododetails["name"],
                                          Tododetails["Address"],
                                          Tododetails["Age"],
                                          Tododetails["Email"],
                                          Tododetails["Qualification"],
                                        );
                                      },

                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 30,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border:
                                                Border.all(color: Colors.black),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black,
                                                Colors.blue
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                          child: Center(
                                              child: Text(
                                            'Update',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                        ),
                                      )),
                                  SizedBox(
                                    width: 70,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        delete(doc.id);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 30,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border:
                                                Border.all(color: Colors.black),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black,
                                                Colors.blue
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                          child: Center(
                                              child: Text(
                                            'Delete',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
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
                builder: (context) => Todo_Add(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
