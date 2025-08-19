import 'package:flutter/material.dart';

class InventoryProvider extends ChangeNotifier {
  // Store inventory with item quantities and image paths
  Map<String, Map<String, dynamic>> _storeInventory = {
    "Blue Paper Towel": {"quantity": 0, "image": "assets/images/blue_paper_towel.png"},
    "Red Mop": {"quantity": 0, "image": "assets/images/red_mop.PNG"},
    "Yellow Mop": {"quantity": 0, "image": "assets/images/yellow_mop.PNG"},
    "Blue Mop": {"quantity": 0, "image": "assets/images/blue_mop.PNG"},
    "Spray Bottle": {"quantity": 0, "image": "assets/images/spray_can.jpg"},
    "White Tissue Paper": {"quantity": 0, "image": "assets/images/white_tissue_pepper.jpg"},
  };

  // Track items taken by cleaners
  List<Map<String, dynamic>> _inventoryRecords = [];

  // Getters
  Map<String, Map<String, dynamic>> get storeInventory => _storeInventory;
  List<Map<String, dynamic>> get inventoryRecords => _inventoryRecords;

  // Function to allow the supervisor to update stock levels
  void updateStock(String product, int quantity) {
    if (_storeInventory.containsKey(product)) {
      _storeInventory[product]!['quantity'] = quantity;
      notifyListeners();
    }
  }

  // Function for cleaners to collect items
  void collectItem(String cleanerName, String product, int quantity) {
    if (_storeInventory.containsKey(product) && _storeInventory[product]!['quantity'] >= quantity) {
      _storeInventory[product]!['quantity'] -= quantity;
      _inventoryRecords.add({
        "cleaner": cleanerName,
        "product": product,
        "quantity": quantity,
        "date": DateTime.now().toString().substring(0, 10),
        "image": _storeInventory[product]!['image'],
      });
      notifyListeners();
    }
  }

  void addInventoryRecord(String s, product, product2, product3) {}
}