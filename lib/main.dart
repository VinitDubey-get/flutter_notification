import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'notification_service.dart';
import 'home_screen.dart';
import 'scheduler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('reminders'); // ✅ Hive Init
  await NotificationService.init(); // ✅ Notifications Init

  // 🛰️ 🔥 Server se JSON format ka data le ke pass kar rahe hain
  List<Map<String, String>> serverData = [
    {"medicine name": "Paracetamol", "when to take": "morning"},
    {"medicine name": "Brufen", "when to take": "morning"},
    {"medicine name": "Vitamin C", "when to take": "afternoon"},
    {"medicine name": "Antibiotic", "when to take": "evening"},
  ];

  await ReminderScheduler.scheduleReminders(serverData); // 🔥 Data pass ho gaya

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medicine Reminder',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
