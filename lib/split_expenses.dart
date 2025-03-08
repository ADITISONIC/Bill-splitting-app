import 'package:flutter/material.dart';

class SplitExpensesPage extends StatefulWidget {
  @override
  _SplitExpensesPageState createState() => _SplitExpensesPageState();
}

class _SplitExpensesPageState extends State<SplitExpensesPage> {
  final List<Map<String, dynamic>> people = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void addPerson() {
    String name = nameController.text.trim();
    double amount = double.tryParse(amountController.text) ?? 0.0;

    if (name.isNotEmpty) {
      setState(() {
        people.add({"name": name, "paid": amount});
      });
      nameController.clear();
      amountController.clear();
    }
  }

  Map<String, List<String>> calculateSettlements() {
    double total = people.fold(0, (sum, person) => sum + person['paid']);
    double fairShare = total / people.length;

    List<Map<String, dynamic>> balances = people.map((person) {
      return {
        "name": person["name"],
        "balance": person["paid"] - fairShare,
      };
    }).toList();

    balances.sort((a, b) => a["balance"].compareTo(b["balance"]));

    Map<String, List<String>> settlements = {};
    for (var person in people) {
      settlements[person['name']] = [];
    }

    int i = 0, j = balances.length - 1;

    while (i < j) {
      double oweAmount = -balances[i]["balance"];
      double getAmount = balances[j]["balance"];
      double settledAmount = oweAmount < getAmount ? oweAmount : getAmount;

      String transaction = "${balances[i]["name"]} owes ₹${settledAmount.toStringAsFixed(2)} to ${balances[j]["name"]}";
      settlements[balances[i]["name"]]?.add(transaction);
      settlements[balances[j]["name"]]?.add(transaction);

      balances[i]["balance"] += settledAmount;
      balances[j]["balance"] -= settledAmount;

      if (balances[i]["balance"] == 0) i++;
      if (balances[j]["balance"] == 0) j--;
    }

    return settlements;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> settlements = calculateSettlements();

    return Scaffold(
      backgroundColor: Colors.lightGreen, // Page Background
      appBar: AppBar(
        title: Text("Split Expenses"),
        backgroundColor: Color(0xFF3E363F), // AppBar Color
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Name Input
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFE1AD01),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Name",
                  contentPadding: EdgeInsets.all(15),
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Amount Input
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFE1AD01),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Amount Paid",
                  contentPadding: EdgeInsets.all(15),
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 15),

            // Add Person Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF3E363F),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              onPressed: addPerson,
              child: Text(
                "Add Person",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 15),

            // List of People and Settlements
            Expanded(
              child: ListView.builder(
                itemCount: people.length,
                itemBuilder: (context, index) {
                  String name = people[index]['name'];
                  double paid = people[index]['paid'];
                  double fairShare = people.fold(0.0, (sum, person) => sum + person['paid']) / people.length;
                  double balance = paid - fairShare;

                  return Card(
                    color: Color(0xFFE1AD01),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$name",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          SizedBox(height: 5),
                          Text("Paid: ₹$paid", style: TextStyle(color: Colors.black)),
                          Text("Fair Share: ₹${fairShare.toStringAsFixed(2)}", style: TextStyle(color: Colors.black)),
                          Text(
                            "Balance: ₹${balance.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: balance >= 0 ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (settlements[name]!.isNotEmpty) ...[
                            Divider(color: Colors.black),
                            Text("Settlements:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                            ...settlements[name]!.map((settlement) => Text(settlement, style: TextStyle(color: Colors.black))),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}