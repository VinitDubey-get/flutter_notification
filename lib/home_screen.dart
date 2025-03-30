import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'add_reminder_screen.dart';
import 'notification_service.dart'; // Import your notification service

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box? _reminderBox;

  @override
  void initState() {
    super.initState();
    _openHiveBox();
  }

  Future<void> _openHiveBox() async {
    await Hive.openBox('reminders'); // Ensure box is opened before using
    setState(() {
      _reminderBox = Hive.box('reminders');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_reminderBox == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Medicine Reminders")),
        body: Center(child: CircularProgressIndicator()), // ✅ Show loader till box is initialized
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Medicine Reminders")),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _reminderBox!.listenable(),
              builder: (context, Box box, _) {
                if (box.isEmpty) {
                  return Center(child: Text("No reminders set."));
                }
                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    var reminder = box.getAt(index);
                    return ListTile(
                      title: Text(reminder['medicine'] ?? 'Unknown'),
                      subtitle: Text("Time: ${reminder['time'] ?? 'Unknown'}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          box.deleteAt(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddReminderScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
