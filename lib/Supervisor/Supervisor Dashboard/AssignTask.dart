import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../../Services/ShiftProvider.dart';
import 'PostShifts.dart';

class AssignTasks extends StatefulWidget {
  const AssignTasks({super.key});

  @override
  State<AssignTasks> createState() => _AssignTasksState();
}

class _AssignTasksState extends State<AssignTasks> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? selectedCleaner;
  List<String> cleaners = ["John Doe", "Jane Smith", "Mike Brown"];

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  // Function to initialize notifications
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Function to show a local notification
  Future<void> _showNotification(String cleaner) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'shift_channel_id',
      'Shift Notifications',
      channelDescription: 'Notifies cleaners about assigned shifts',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'New Shift Assigned',
      'A shift has been assigned to $cleaner',
      platformChannelSpecifics,
    );
  }

  void _postShift() {
    if (_dateController.text.isNotEmpty &&
        _timeController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        selectedCleaner != null &&
        _descriptionController.text.isNotEmpty) {

      // Add shift to provider
      Provider.of<ShiftProvider>(context, listen: false).addShift(
        Shift(
          date: _dateController.text,
          time: _timeController.text,
          location: _locationController.text,
          cleaner: selectedCleaner!,
          description: _descriptionController.text,
        ),
      );

      // Show local notification
      _showNotification(selectedCleaner!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Shift assigned successfully!")),
      );

      // Clear inputs
      _dateController.clear();
      _timeController.clear();
      _locationController.clear();
      _descriptionController.clear();
      setState(() {
        selectedCleaner = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields!")),
      );
    }
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Shifts")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Select Date",
                suffixIcon: IconButton(icon: Icon(Icons.calendar_today), onPressed: _selectDate),
              ),
            ),
            TextField(
              controller: _timeController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Select Time",
                suffixIcon: IconButton(icon: Icon(Icons.access_time), onPressed: _selectTime),
              ),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: "Location"),
            ),
            DropdownButtonFormField<String>(
              value: selectedCleaner,
              items: cleaners.map((String cleaner) {
                return DropdownMenuItem(value: cleaner, child: Text(cleaner));
              }).toList(),
              onChanged: (newValue) => setState(() => selectedCleaner = newValue),
              decoration: InputDecoration(labelText: "Assign to Cleaner"),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Shift Description"),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _postShift, child: Text("Post Shift")),
          ],
        ),
      ),
    );
  }
}