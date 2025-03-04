import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BillSplit extends StatefulWidget {
  const BillSplit({super.key}); // Corrected constructor

  @override
  _BillSplitState createState() => _BillSplitState();
}

class _BillSplitState extends State<BillSplit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Text("Split Bill",style:GoogleFonts.montserrat(
              fontSize: 20,fontWeight: FontWeight.w700
            ),),
          )
        ],
      )
    );
  }
}