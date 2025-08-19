import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../Services/InventoryProvider.dart';

class StoreInventory extends StatefulWidget {
  const StoreInventory({super.key});

  @override
  State<StoreInventory> createState() => _StoreInventoryState();
}

class _StoreInventoryState extends State<StoreInventory> {
  final List<Map<String, dynamic>> _products = [
    {
      "name": "Blue Paper Towel",
      "image": "assets/images/blue_paper_towel.png",
      "quantity": 0,
      "isSelected": false
    },
    {
      "name": "Red Mop",
      "image": "assets/images/red_mop.PNG",
      "quantity": 0,
      "isSelected": false
    },
    {
      "name": "Yellow Mop",
      "image": "assets/images/yellow_mop.PNG",
      "quantity": 0,
      "isSelected": false
    },
    {
      "name": "Blue Mop",
      "image": "assets/images/blue_mop.PNG",
      "quantity": 0,
      "isSelected": false
    },
    {
      "name": "Spray Bottle",
      "image": "assets/images/spray_can.jpg",
      "quantity": 0,
      "isSelected": false
    },
    {
      "name": "White Tissue Paper",
      "image": "assets/images/white_tissue_pepper.jpg",
      "quantity": 0,
      "isSelected": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Inventory Page'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(index);
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _handleEndTask,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              'End Task',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProductCard(int index) {
    final product = _products[index];

    return GestureDetector(
      onTap: () {
        setState(() {
          product["isSelected"] = !product["isSelected"];
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
          color: product["isSelected"] ? Colors.green.shade100 : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  product["image"],
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
                if (product["isSelected"])
                  const Positioned(
                    top: 5,
                    right: 5,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              product["name"],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (product["quantity"] > 0) {
                        product["quantity"]--;
                      }
                    });
                  },
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                ),
                Text(
                  "${product["quantity"]}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      product["quantity"]++;
                    });
                  },
                  icon: const Icon(Icons.add_circle, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleEndTask() {
    final inventoryProvider = Provider.of<InventoryProvider>(
        context, listen: false);
    final selectedProducts = _products.where((
        product) => product["isSelected"] && product["quantity"] > 0).toList();

    if (selectedProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No items selected!'), backgroundColor: Colors.red),
      );
      return;
    }

    String confirmationMessage = "You have selected the following items:\n\n";
    for (var product in selectedProducts) {
      confirmationMessage += "${product["name"]}: ${product["quantity"]} pcs\n";
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Selection'),
          content: Text(confirmationMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                for (var product in selectedProducts) {
                  inventoryProvider.addInventoryRecord(
                      "Cleaner Name", product["name"], product["quantity"],
                      product["image"]);
                  int remainingStock = inventoryProvider
                      .storeInventory[product["name"]]?["quantity"] -
                      product["quantity"];
                  inventoryProvider.updateStock(
                      product["name"], remainingStock);
                }
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Task Completed!'),
                      backgroundColor: Colors.green),
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }


  addInventoryRecord(String cleanerName, String productName, int quantity,
      String imagePath) {
    // Example: Saving record to a list or database
    Map<String, dynamic> record = {
      "cleanerName": cleanerName,
      "productName": productName,
      "quantity": quantity,
      "imagePath": imagePath,
      "timestamp": DateTime.now(),
    };

    // Assume we have a list to store inventory records
    List<Map<String, dynamic>> inventoryRecords = [];
    inventoryRecords.add(record);

    print("Inventory record added: $record");
  }
}