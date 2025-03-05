import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  final String bill;
  final String tax;
  final double friends;
  final double tip;
  const ResultsPage(this.bill,this.tax,this.friends,this.tip);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  void initState() {
    super.initState();
    divideamount();
  }
  divideamount(){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
