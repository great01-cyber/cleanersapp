import 'package:uosc/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Services/FullMessagePage.dart';
import '../../Services/Notification.dart';
import '../Cleaners.dart';
import '../UserTrainning.dart';
import 'LeaveRequestPage.dart';
import 'QRscanning.dart';
import 'ReportsIssues.dart';
import 'SafetyRules.dart';
import 'SeeShifts.dart';
import 'SocialBoardPage.dart';
import 'StoreInventory.dart';
import 'ToDoList.dart';

class CleanersDashboard extends StatefulWidget {
  @override
  _CleanersDashboardState createState() => _CleanersDashboardState();
}

class _CleanersDashboardState extends State<CleanersDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Cleaners Dashboard'),
        backgroundColor: Colors.green,
        actions: [
          /*Consumer<NotificationProvider>(
            builder: (context, notificationProvider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications, size: 30),
                    onPressed: () {
                      _scaffoldKey.currentState!.openEndDrawer(); // Open notification drawer
                    },
                  ),
                  if (notificationProvider.notifications.isNotEmpty)
                    Positioned(
                      right: 10,
                      top: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 8,
                        child: Text(
                          '${notificationProvider.notifications.length}', // Shows unread notifications count
                          style: const TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),*/
        ],
      ),

      drawer: _buildMainDrawer(context),
      endDrawer: _buildNotificationDrawer(),

      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        childAspectRatio: 1.5,
        children: [
          _buildDashboardButton('Store Inventory', Icons.inventory, Colors.blue, () => Navigator.push(context, MaterialPageRoute(builder: (context) => StoreInventory()))),
          _buildDashboardButton('Reports Issues', Icons.report_problem, Colors.orange, () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReportsIssues()))),
          _buildDashboardButton('Users Training', Icons.school, Colors.purple, () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserTraining()))),
          _buildDashboardButton('Social Board', Icons.group, Colors.teal, () => Navigator.push(context, MaterialPageRoute(builder: (context) => SocialBoardPage()))),
          _buildDashboardButton('See Shifts', Icons.room, Colors.green, () => Navigator.push(context, MaterialPageRoute(builder: (context) => SeeShifts()))),
          _buildDashboardButton('Annual Leave', Icons.comment, Colors.red, () => Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveRequestPage()))),
          _buildDashboardButton('QR Scanning', Icons.qr_code, Colors.amber, () => Navigator.push(context, MaterialPageRoute(builder: (context) => QrScanning()))),
          _buildDashboardButton('See Tickets', Icons.assignment, Colors.indigo, () => Navigator.push(context, MaterialPageRoute(builder: (context) => SeeTickets()))),
          _buildDashboardButton('To-Do List', Icons.list, Colors.cyan, () => Navigator.push(context, MaterialPageRoute(builder: (context) => ToDoList()))),
          _buildDashboardButton('Safety Rules', Icons.safety_check, Colors.pink, () => Navigator.push(context, MaterialPageRoute(builder: (context) => SafetyRules()))),
        ],
      ),
    );
  }

  // 🔷 Function to create the Main Left-Side Drawer
  Widget _buildMainDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.green),
            child: const Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          _buildDrawerItem(Icons.inventory, 'Store Inventory', () => Navigator.push(context, MaterialPageRoute(builder: (context) => StoreInventory()))),
          _buildDrawerItem(Icons.report_problem, 'Reports Issues', () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReportsIssues()))),
          _buildDrawerItem(Icons.school, 'Users Training', () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserTraining()))),
          _buildDrawerItem(Icons.group, 'Social Board', () => Navigator.push(context, MaterialPageRoute(builder: (context) => SocialBoardPage()))),
          _buildDrawerItem(Icons.room, 'See Shifts', () => Navigator.push(context, MaterialPageRoute(builder: (context) => SeeShifts()))),
          _buildDrawerItem(Icons.request_page, 'Annual Leave', () => Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveRequestPage()))),
          _buildDrawerItem(Icons.qr_code, 'QR Scanning', () => Navigator.push(context, MaterialPageRoute(builder: (context) => QrScanning()))),
          _buildDrawerItem(Icons.assignment, 'See Tickets', () => Navigator.push(context, MaterialPageRoute(builder: (context) => SeeTickets()))),
          _buildDrawerItem(Icons.list, 'To-Do List', () => Navigator.push(context, MaterialPageRoute(builder: (context) => ToDoList()))),
          _buildDrawerItem(Icons.safety_check, 'Safety Rules', () => Navigator.push(context, MaterialPageRoute(builder: (context) => SafetyRules()))),
          _buildDrawerItem(Icons.logout, 'Logout', () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()))),
        ],
      ),
    );
  }

  // 🔔 Right-side notification drawer
  Widget _buildNotificationDrawer() {
    return Drawer(
      child: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
          return Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.green),
                child: const Center(
                  child: Text("Notifications", style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
              Expanded(
                child: notificationProvider.notifications.isNotEmpty
                    ? ListView.builder(
                  itemCount: notificationProvider.notifications.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.notifications),
                      title: Text(
                        notificationProvider.notifications[index],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        // Navigate to FullMessagePage when a notification is clicked
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullMessagePage(
                              message: notificationProvider.notifications[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
                    : const Center(child: Text("No new notifications")),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showFullMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Full Message"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  // Helper function to create drawer list items
  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  // 🔷 Function to create dashboard buttons
  Widget _buildDashboardButton(String title, IconData icon, Color color, VoidCallback onPressed) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: color),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
          ]),
        ),
      ),
    );
  }
}
