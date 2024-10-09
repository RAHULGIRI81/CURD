import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/TODO_App/Todo_views.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Task_update extends StatefulWidget {
  const Task_update({super.key, required this.id});
  final id;
  @override
  State<Task_update> createState() => _Task_updateState();
}

class _Task_updateState extends State<Task_update> {

  @override
  initState() {
    super.initState();
    Getbyid();
  }
  String _selectedItem = 'Select';
  String _selectedValue = '';


  Future<void> Getbyid() async {
    DocumentSnapshot Task = await FirebaseFirestore.instance
        .collection("Todolist")
        .doc(widget.id)
        .get();
    if(Task.exists){
      Map<String, dynamic> Taskid = Task.data() as Map<String, dynamic>;
      setState(() {
        Name_ctrl.text = Taskid["name"];
        Age_ctrl.text =Taskid["Age"];
        Address_ctrl.text = Taskid["Address"];
        Email_ctrl.text = Taskid["Email"];
        Qualification_ctrl.text =Taskid["Qualification"];

      });
    }
  }

  Future<void> Update_task()async {
    FirebaseFirestore.instance.collection("Todolist").doc(widget.id).update({
      "name": Name_ctrl.text,
      "Age": Age_ctrl.text,
      "Address": Address_ctrl.text,
      "Email": Email_ctrl.text,
      "Qualification": _selectedItem,
      "Gender": _selectedValue,
    });

  }

  var Name_ctrl = TextEditingController();
  var Age_ctrl = TextEditingController();
  var Address_ctrl = TextEditingController();
  var Email_ctrl = TextEditingController();
  var Qualification_ctrl = TextEditingController();


  final List<String> _options = [
    '10th',
    '+2',
    'UG',
    'Select',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(stream: FirebaseFirestore.instance.collection("Todolist").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              final Tododetails = snapshot.data?.docs ?? [];
              return Padding(
                padding: const EdgeInsets.only(top: 40,left: 20,right: 20),
                child: Column(
                  children: [
                    Text('BIODATA UPDATE DETAILS',style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.bold),),
                   SizedBox(height: 20,),
                    TextField(
                      controller: Name_ctrl,
                      decoration: InputDecoration(labelText: 'Name',enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Gender',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
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
                              ),]),
                        SizedBox(height: 10,),
                        TextField(
                          controller: Address_ctrl,
                          decoration: InputDecoration(labelText: 'Address',enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          controller: Age_ctrl,
                          decoration: InputDecoration(labelText: 'Age',enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                        ),
                        SizedBox(height: 10,),
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
                                        padding: const EdgeInsets.only(left: 270),
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
                          decoration: InputDecoration(labelText: 'Email',enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(
                          onPressed: () async {
                            // await FirebaseFirestore.instance
                            //     .collection('Todolist')
                            //     .doc()
                            //     .update({
                            //   'name': Name_ctrl.text,
                            //   'Address': Address_ctrl.text,
                            //   'Age': Age_ctrl.text,
                            //   'Qualification': Qualification_ctrl.text,
                            //   'Email': Email_ctrl.text,
                            // });
                            // Name_ctrl.clear();
                            // Age_ctrl.clear();
                            // Age_ctrl.clear();
                            // Qualification_ctrl.clear();
                            // Email_ctrl.clear();
                            Update_task();
                            Navigator.push(context, MaterialPageRoute(builder:  (context) {
                              return Todo_view();
                            },));
                          },
                          child: Text('Update'),
                        ),
                      ],

                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
