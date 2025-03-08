import 'package:bill_splitter/results.dart';
import 'package:bill_splitter/split_expenses.dart'; // Import Multiple Payments Screen
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BillSplit extends StatefulWidget {
  const BillSplit({super.key});

  @override
  _BillSplitState createState() => _BillSplitState();
}

class _BillSplitState extends State<BillSplit> {
  double friendsvalue = 1;
  double tip = 0.0;
  String tax = '0';
  String bill = '';

  // Calculate the total amount dynamically
  double get totalAmount {
    double billAmount = double.tryParse(bill) ?? 0.0;
    double taxAmount = double.tryParse(tax) ?? 0.0;
    return billAmount + (billAmount * (taxAmount / 100)) + tip;
  }

  TextStyle infostyle = GoogleFonts.montserrat(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen, // Updated Background Color
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 40),

              Container(
                alignment: Alignment.center,
                child: Text(
                  "💰 Split Your Bill 💰",
                  style: GoogleFonts.montserrat(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),

              SizedBox(height: 20),

              // **Total Amount Input**
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFE1AD01), // Updated Box Color
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      "Enter Total Bill Amount",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          bill = value.isEmpty ? '0' : value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "Total Amount",
                        labelStyle: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // **Bill Calculation Summary**
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xFFE1AD01), // Updated Box Color
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text("Final Amount to be Split", style: infostyle),
                    Text(
                      "₹ ${totalAmount.toStringAsFixed(2)}",
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // **Friends Selection**
              Text(
                "How many friends?",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),

              // **Display Friends Count**
              Text(
                "Number of Friends: ${friendsvalue.round()}",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w700,
                ),
              ),

              Slider(
                min: 1,
                max: 15,
                divisions: 14,
                activeColor: Color(0xFFE1AD01), // Updated Slider Color
                inactiveColor: Colors.grey,
                value: friendsvalue,
                onChanged: (value) {
                  setState(() {
                    friendsvalue = value;
                  });
                },
              ),

              SizedBox(height: 20),

              // **Tip and Tax Input**
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // **Tip Section**
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFE1AD01), // Updated Box Color
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Tip",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  if (tip > 0) tip--;
                                });
                              },
                              backgroundColor: Colors.grey[400],
                              mini: true,
                              child: Icon(Icons.remove, color: Colors.black),
                            ),
                            Text(
                              tip.round().toString(),
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  tip++;
                                });
                              },
                              backgroundColor: Colors.grey[400],
                              mini: true,
                              child: Icon(Icons.add, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // **Tax Input**
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFE1AD01), // Updated Box Color
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Tax %",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              tax = value.isEmpty ? '0' : value;
                            });
                          },
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // **Split Bill Button**
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF3E363F), // Updated Button Color
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ResultsPage(bill, tax, friendsvalue, tip),
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    "Split Bill 💵",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15),

              // **Multiple Payments Option**
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF3E363F), // Updated Button Color
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SplitExpensesPage()),
                  );
                },
                child: Center(
                  child: Text(
                    "Multiple Payments 💳",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}