
import 'package:crud/Shop/Fruits.dart';
import 'package:crud/Shop/Grocery.dart';
import 'package:crud/Shop/Shop_Add_cart.dart';
import 'package:crud/Shop/Vegitables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class View_product extends StatefulWidget {
  const View_product({super.key});

  @override
  State<View_product> createState() => _View_productState();
}

class _View_productState extends State<View_product> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ShopAddCart();
                },
              ));
            },
            backgroundColor: Colors.green,
            child: Icon(Icons.add),
          ),
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Center(
              child: Text("Catogary",
                  style:
               GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
          body: Column(
            children: [
              Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 27,right: 25),
                      child: Container(
                        width: 500,
                        height: 49,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black,width: 3),
                        ),

                      ),
                    ),

                    TabBar(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      tabs: [
                        Tab(
                          child: Text(
                            'Fruits',
                            style: TextStyle(
                              // color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Vegtables',
                            style: TextStyle(
                              // color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Grocery',
                            style: TextStyle(
                              // color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),]
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Fruits(),
                    Vegitables(),
                    Grocery(),
                    // Call the first class

                    // Call the second class
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}

