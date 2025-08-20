
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart' hide ChangeNotifierProvider;
import 'Services/InventoryProvider.dart';
import 'Services/Notification.dart';
import 'Services/ShiftProvider.dart';
import 'homepage.dart';
import 'meal_ticket_provider.dart'; // Your existing homepage

// Initialize Flutter Local Notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Android Initialization Settings
  const AndroidInitializationSettings androidInitializationSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
  InitializationSettings(android: androidInitializationSettings);

  // Initialize Notifications
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  final inventoryProvider =
      ChangeNotifierProvider((ref) => InventoryProvider());
  final mealTicketProvider =
      ChangeNotifierProvider((ref) => MealTicketProvider());
  final shiftProvider = ChangeNotifierProvider((ref) => ShiftProvider());
  final notificationProvider =
      ChangeNotifierProvider((ref) => NotificationProvider());

  void main() {
    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cleaners App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(), // Your existing homepage
    );
  }
}
