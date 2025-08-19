import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Services/InventoryProvider.dart';

class StoreInventoryPage extends StatefulWidget {
  const StoreInventoryPage({super.key});

  @override
  State<StoreInventoryPage> createState() => _StoreInventoryPageState();
}

class _StoreInventoryPageState extends State<StoreInventoryPage> {
  final TextEditingController _stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final inventoryProvider = Provider.of<InventoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Supervisor Inventory Page'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text("Update Store Inventory",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Input Fields for Updating Inventory
            Column(
              children: inventoryProvider.storeInventory.entries.map((entry) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Show Image Next to Product Name
                    Row(
                      children: [
                        Image.asset(entry.value["image"], width: 40,
                            height: 40),
                        const SizedBox(width: 10),
                        Text(entry.key, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(
                      width: 80,
                      child: TextField(
                        controller: _stockController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: entry.value["quantity"].toString(),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        int newStock =
                            int.tryParse(_stockController.text) ??
                                entry.value["quantity"];
                        inventoryProvider.updateStock(entry.key, newStock);
                        _stockController.clear();
                      },
                      child: const Text("Update"),
                    ),
                  ],
                );
              }).toList(),
            ),

            const Divider(),

            // Display Current Store Inventory
            const Text("Current Store Inventory",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView(
                children: inventoryProvider.storeInventory.entries.map((entry) {
                  return ListTile(
                    leading: Image.asset(
                        entry.value["image"], width: 40, height: 40),
                    title: Text("${entry.key}: ${entry
                        .value["quantity"]} remaining"),
                  );
                }).toList(),
              ),
            ),

            const Divider(),

            // Display Items Collected by Cleaners
            const Text("Items Collected by Cleaners",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: inventoryProvider.inventoryRecords.length,
                itemBuilder: (context, index) {
                  var record = inventoryProvider.inventoryRecords[index];
                  return ListTile(
                    leading: Image.asset(
                        record["image"], width: 40, height: 40),
                    title:
                    Text(
                        "${record["cleaner"]} took ${record["quantity"]} ${record["product"]}"),
                    subtitle: Text("Date: ${record["date"]}"),
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