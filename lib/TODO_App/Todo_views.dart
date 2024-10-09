import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/Curd/Product_Details.dart';
import 'package:crud/Curd/Product_add.dart';
import 'package:crud/TODO_App/Todo_Add.dart';
import 'package:crud/TODO_App/Todo_Details.dart';
import 'package:crud/TODO_App/Todo_updatesss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todo_view extends StatefulWidget {
  const Todo_view({super.key});

  @override
  State<Todo_view> createState() => _Todo_viewState();
}

final List<String> _options = [
  '10th',
  '+2',
  'UG',
  'Select',
];
String Selected_item = 'Qualification';
String _selectedItem = 'Select';
String _selectedValue = 'Gender';

class _Todo_viewState extends State<Todo_view> {
  var Name_ctrl = TextEditingController();
  var Age_ctrl = TextEditingController();
  var Address_ctrl = TextEditingController();
  var Email_ctrl = TextEditingController();
  var Qualification_ctrl = TextEditingController();
  var Search_ctrl = TextEditingController();

  String Search_Quary = " ";

  Future<void> delete(String id) async {
    await FirebaseFirestore.instance.collection("Todolist").doc(id).delete();
  }

  Future<void> _updatebiodata(String id, String name, String Age,
      String Address, String Email, String Qualification) async {
    Name_ctrl.text = name;
    Age_ctrl.text = Age;
    Address_ctrl.text = Address;
    Email_ctrl.text = Email;
    Qualification_ctrl.text = Qualification;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Bio data Update'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: Name_ctrl,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Gender',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Radio<String>(
                                    value: 'Male',
                                    groupValue: _selectedValue,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Male',
                                    style: GoogleFonts.poppins(),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<String>(
                                    activeColor: Colors.black,
                                    value: 'Female',
                                    groupValue: _selectedValue,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Female',
                                    style: GoogleFonts.poppins(),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: 'Others',
                                    groupValue: _selectedValue,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Others',
                                    style: GoogleFonts.poppins(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextField(
                    controller: Address_ctrl,
                    decoration: InputDecoration(labelText: 'Address'),
                  ),
                  TextField(
                    controller: Age_ctrl,
                    decoration: InputDecoration(labelText: 'Age'),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Qualification',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: DropdownButton<String>(
                                value: _selectedItem,
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 180),
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
                      'Age': Age_ctrl.text,
                      'Qualification': Qualification_ctrl.text,
                      'Email': Email_ctrl.text,
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
      },
    );
  }

  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

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
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text(
                "BIODATA ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              Text(
                "Details",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
            child: _isSearching
                ? TextField(
                    onChanged: (value) {
                      setState(() {
                        Search_Quary = value.toLowerCase();
                      });
                    },
                    controller: Search_ctrl,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        fillColor: Colors.white,
                        filled: true),
                  )
                : const SizedBox.shrink(),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: IconButton(
              icon: Icon(
                _isSearching ? Icons.clear : Icons.search,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) {
                    Search_ctrl.clear();
                  }
                });
              },
            ),
          ),
        ],
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
          final Todo = snapshot.data!.docs.where((doc) {
            String Todo_search = doc["name"].toString().toLowerCase();
            return Todo_search.contains(Search_Quary);
          }).toList();
          if (Todo.isEmpty) {
            return Text('not found');
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              final doc = Todo[index];
              final Tododetails = doc.data() as Map<String, dynamic>;

              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Todo_Description(id: doc.id);
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
                                    "Gender: ${Tododetails["Gender"] ?? ''} ",
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
                                                Colors.purple,
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
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return Task_update(
                                            id: doc.id,
                                          );
                                        },
                                      ));
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.black),
                                        gradient: LinearGradient(
                                          colors: [Colors.green, Colors.blue],
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
                                  ),
                                  SizedBox(
                                    width: 5,
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
                                                Colors.blue,
                                                Colors.purple
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
            itemCount: Todo.length,
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
