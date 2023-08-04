import 'package:flutter/material.dart';
import 'package:recipeeapp/preference_service.dart';
import 'package:recipeeapp/pages/reminder.dart';

class IndoorPlants extends StatefulWidget {
  const IndoorPlants({super.key});

  @override
  State<IndoorPlants> createState() => _IndoorPlantsState();
}

class _IndoorPlantsState extends State<IndoorPlants> {
  final List<String>? foodNames = PreferencesService.sharedPreferencesInstance.getStringList('foodNames');
  final List<String>? foodCategory = PreferencesService.sharedPreferencesInstance.getStringList('foodCategory');
  final List<String>? foodInstructionss = PreferencesService.sharedPreferencesInstance.getStringList('foodInstructionss');
  @override
  Widget build(BuildContext context) {
    if (foodNames == null || foodNames!.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Main Dishes"),
            centerTitle: true,
          ),
          body: const Center(child: Text('No foods added yet')));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Dishes'),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: foodNames!.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.dinner_dining, color: Colors.brown),
                  title: Text(foodNames![index], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(foodCategory![index]),
                  // trailing: Text(buyingDates![index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReminderForm(
                          index: index,
                          plantName: foodNames![index],
                          instructions: foodInstructionss![index],
                        ),
                      ),
                    );
                  },
                  onLongPress: () {
                    setState(() {
                      foodNames!.removeAt(index);
                      foodCategory!.removeAt(index);
                      foodInstructionss!.removeAt(index);
                      PreferencesService.sharedPreferencesInstance.setStringList('foodNames', foodNames!);
                      PreferencesService.sharedPreferencesInstance.setStringList('foodCategory', foodCategory!);
                      PreferencesService.sharedPreferencesInstance.setStringList('foodInstructionss', foodInstructionss!);
                    });
                  },
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
