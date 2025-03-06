import 'package:bill_splitter/results.dart';
import 'package:bill_splitter/split_expenses.dart'; // Import the SplitExpensesPage
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

  Widget buildButton(String text) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(padding: EdgeInsets.all(20)),
        onPressed: () {
          setState(() {
            if (text == '-') {
              bill = '';
            } else {
              bill += text;
            }
          });
        },
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  TextStyle infostyle = GoogleFonts.montserrat(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 40),
                child: Text(
                  "Split Bill",
                  style: GoogleFonts.montserrat(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(color: Colors.lightGreen),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total", style: infostyle),
                          Text(
                            totalAmount.toStringAsFixed(2), // Updated Total
                            style: GoogleFonts.montserrat(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
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
                              Text("Friends", style: infostyle),
                              Text("Tax", style: infostyle),
                              Text("Tip", style: infostyle),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(friendsvalue.round().toString(), style: infostyle),
                              Text("$tax %", style: infostyle),
                              Text(tip.round().toString(), style: infostyle),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "How many friends?",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Slider(
                min: 1,
                max: 15,
                divisions: 14,
                activeColor: Colors.green,
                inactiveColor: Colors.grey,
                value: friendsvalue,
                onChanged: (value) {
                  setState(() {
                    friendsvalue = value;
                  });
                },
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "TIP",
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
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
                                color: Colors.black,
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
                  SizedBox(width: 10),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            tax = value.isEmpty ? '0' : value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          labelText: "Tax in %",
                          labelStyle: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.greenAccent),
                onPressed: () {
                  if (bill.isEmpty || double.tryParse(bill) == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter a valid bill amount")));
                    return;
                  }
                  if (double.tryParse(tax) == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter a valid tax percentage")));
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsPage(bill, tax, friendsvalue, tip),
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    "Split Bill",
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10), // Added spacing
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.greenAccent),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SplitExpensesPage()),
                  );
                },
                child: Center(
                  child: Text(
                    "Split Expenses",
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}