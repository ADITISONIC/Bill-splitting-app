import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BillSplit extends StatefulWidget {
  const BillSplit({super.key}); // Corrected constructor

  @override
  _BillSplitState createState() => _BillSplitState();
}

class _BillSplitState extends State<BillSplit> {
  double friendsvalue = 0.0;
  buildbutton(String text){
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(padding: EdgeInsets.all(20)),
        onPressed:(){}, child:Text(text,style:GoogleFonts.montserrat(
        fontSize: 25 ,color: Colors.black,fontWeight: FontWeight.w700
      ),),),
    );
  }
  TextStyle infostyle = GoogleFonts.montserrat(
    fontSize:18,color: Colors.black,fontWeight: FontWeight.w700
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 40),
                child: Text("Split Bill",style:GoogleFonts.montserrat(
                  fontSize: 25,fontWeight: FontWeight.w700
                ),),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.lightGreen
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total",style:GoogleFonts.montserrat(
                            fontSize: 20,fontWeight: FontWeight.w700
                          ),),
                                    Text("34",style:GoogleFonts.montserrat(
                      fontSize: 25,fontWeight: FontWeight.w700
                                    ),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Friends",style: infostyle),
                              Text("Tax",style: infostyle),
                              Text("Tip",style: infostyle),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("10",style: infostyle),
                              Text("14 %",style: infostyle),
                              Text("15",style: infostyle),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Text("How many friends ?",style: GoogleFonts.montserrat(
                fontSize: 20,color: Colors.black,fontWeight: FontWeight.w700
              ),),
              Slider(
                min: 0,
                max: 15,
                divisions: 15,
                activeColor: Colors.green,
                inactiveColor: Colors.grey,
                value: 12,
                onChanged:(value){},
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        Text("TIP",style:GoogleFonts.montserrat(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                        ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              child: FloatingActionButton(onPressed:(){},
                                backgroundColor: Colors.grey[400],
                              child: Icon(Icons.remove,color: Colors.black,),),
                            ),
                            Text("20",style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700
                            ),),
                            Container(
                              width: 40,
                              height: 40,
                              child: FloatingActionButton(onPressed: (){},
                              backgroundColor:Colors.grey[400],
                              child:Icon(Icons.add,color: Colors.black,),
                            )
                            )
                          ],
                        )
                      ]
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width/3,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20)
                          ),
                              labelText:"Tax in %",
                          labelStyle: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                          )
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  buildbutton("1"),
                  buildbutton("2"),
                  buildbutton("3"),
                ],
              ),
              Row(
                children: [
                  buildbutton("4"),
                  buildbutton("5"),
                  buildbutton("6"),
                ],
              ),
              Row(
                children: [
                  buildbutton("7"),
                  buildbutton("8"),
                  buildbutton("9"),
                ],
              ),
              Row(
                children: [
                  buildbutton("."),
                  buildbutton("0"),
                  buildbutton("-"),
                ],
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor:Colors.greenAccent
                ),
                  onPressed: (){}, child:Center(
                    child: Text("Split Bill",
                                  style:GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black
                                  )),
                  ), )
            ],
          ),
        ),
      )
    );
  }
}