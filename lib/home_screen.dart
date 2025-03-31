import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('reminders'); // ✅ Get reminders from Hive

    return Scaffold(
      appBar: AppBar(title: Text("Medicine Reminders")),
      body: box.isEmpty
          ? Center(child: Text("No reminders scheduled!"))
          : ListView.builder(
        itemCount: box.length,
        itemBuilder: (context, index) {
          var reminder = box.getAt(index); // 🔥 Fetch each reminder
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(reminder['medicine'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text("Time: ${reminder['time']}"),
              trailing: Icon(Icons.access_time, color: Colors.blue),
            ),
          );
        },
      ),
    );
  }
}
