import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:recipeeapp/preference_service.dart';

class Reminders extends StatefulWidget {
  const Reminders({super.key});

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  DateTime currentDate = DateTime.now();
  final List<String>? remindDatas = PreferencesService.sharedPreferencesInstance.getStringList('remindDatas');
  @override
  Widget build(BuildContext context) {
    if (remindDatas == null || remindDatas!.isEmpty) {
      return const Center(
        child: Text("No reminders added yet"),
      );
    }
    return Column(children: [
      Expanded(
        child: ListView.builder(
          itemCount: remindDatas!.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> reminder = jsonDecode(remindDatas![index]);
            if (currentDate.isBefore(DateTime.parse(reminder['timeToRemind']))) {
              return Card(
                child: ListTile(
                  leading: Icon(Icons.hot_tub, color: Colors.brown[800]),
                  title: Text(reminder['foodName'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(reminder['timeToRemind']),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ReminderForm(
                    //       index: index,
                    //       plantName: plantNames![index],
                    //     ),
                    //   ),
                    // );
                  },
                  onLongPress: () {
                    setState(() {
                      remindDatas!.removeAt(index);
                      PreferencesService.sharedPreferencesInstance.setStringList('remindDatas', remindDatas!);
                    });
                  },
                ),
              );
            }
            return Card(
                child: ListTile(
              leading: Icon(Icons.hot_tub, color: Colors.grey[500]),
              trailing: const Text("Expired"),
              title: Text(reminder['foodName'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(reminder['timeToRemind']),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ReminderForm(
                //       index: index,
                //       plantName: plantNames![index],
                //     ),
                //   ),
                // );
              },
              onLongPress: () {
                setState(() {
                  remindDatas!.removeAt(index);
                  PreferencesService.sharedPreferencesInstance.setStringList('remindDatas', remindDatas!);
                });
              },
            ));
          },
        ),
      ),
    ]);
  }
}
