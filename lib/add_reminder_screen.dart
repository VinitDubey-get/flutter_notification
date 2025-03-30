import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'notification_service.dart';

class AddReminderScreen extends StatefulWidget {
  @override
  _AddReminderScreenState createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  TextEditingController _medicineNameController = TextEditingController();
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Medicine Reminder")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _medicineNameController,
              decoration: InputDecoration(labelText: "Medicine Name"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), // ✅ 12-hour format force
                      child: child!,
                    );
                  },
                );
                if (pickedTime != null) {
                  setState(() {
                    _selectedTime = pickedTime;
                  });
                }
              },
              child: Text(_selectedTime == null
                  ? "Select Time"
                  : "Selected: ${_selectedTime!.format(context)}"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_medicineNameController.text.isNotEmpty &&
                    _selectedTime != null) {

                  // 🔹 Get Current Date
                  DateTime now = DateTime.now();

                  // 🔹 Convert TimeOfDay to DateTime
                  DateTime scheduleTime = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    _selectedTime!.hour,
                    _selectedTime!.minute,
                  );

                  // 🔥 Schedule Notification with Correct Timezone
                  NotificationService.scheduleNotification(
                      1,
                      "Time to take your medicine",
                      "Take ${_medicineNameController.text}",
                      scheduleTime);

                  // 🔹 Convert to 12-hour format before saving
                  String formattedTime = DateFormat.jm().format(scheduleTime); // ✅ 12-hour format

                  Hive.box('reminders').add({
                    'medicine': _medicineNameController.text,
                    'time': formattedTime, // ✅ Save in 12-hour format
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Reminder Set!")));

                  Navigator.pop(context);
                }
              },
              child: Text("Set Reminder"),
            ),
          ],
        ),
      ),
    );
  }
}
