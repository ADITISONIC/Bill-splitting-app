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
      appBar: AppBar(title: Text("Split Expenses")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount Paid"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addPerson,
              child: Text("Add Person"),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: people.length,
                itemBuilder: (context, index) {
                  String name = people[index]['name'];
                  double paid = people[index]['paid'];
                  double fairShare = people.fold(0.0, (sum, person) => sum + person['paid']) / people.length;
                  double balance = paid - fairShare;

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$name",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text("Paid: ₹$paid"),
                          Text("Fair Share: ₹${fairShare.toStringAsFixed(2)}"),
                          Text(
                            "Balance: ₹${balance.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: balance >= 0 ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (settlements[name]!.isNotEmpty) ...[
                            Divider(),
                            Text("Settlements:", style: TextStyle(fontWeight: FontWeight.bold)),
                            ...settlements[name]!.map((settlement) => Text(settlement)),
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