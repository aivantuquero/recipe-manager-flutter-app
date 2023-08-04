import 'package:flutter/material.dart';
import 'package:recipeeapp/preference_service.dart';
import 'package:recipeeapp/pages/reminder.dart';

class OutdoorPlants extends StatefulWidget {
  const OutdoorPlants({super.key});

  @override
  State<OutdoorPlants> createState() => _OutdoorPlantsState();
}

class _OutdoorPlantsState extends State<OutdoorPlants> {
  final List<String>? foodNames2 = PreferencesService.sharedPreferencesInstance.getStringList('foodNames2');
  final List<String>? foodCategory2 = PreferencesService.sharedPreferencesInstance.getStringList('foodCategory2');
  final List<String>? foodInstructionss2 = PreferencesService.sharedPreferencesInstance.getStringList('foodInstructionss2');
  @override
  Widget build(BuildContext context) {
    if (foodNames2 == null || foodNames2!.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Desserts and Pastries"),
            centerTitle: true,
          ),
          body: const Center(child: Text('No foods added yet')));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desserts and Pastries'),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: foodNames2!.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.icecream, color: Colors.brown),
                  title: Text(foodNames2![index], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(foodCategory2![index]),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReminderForm(
                          index: index,
                          plantName: foodNames2![index],
                          instructions: foodInstructionss2![index],
                        ),
                      ),
                    )
                  },
                  onLongPress: () {
                    setState(() {
                      foodNames2!.removeAt(index);
                      foodCategory2!.removeAt(index);
                      foodInstructionss2!.removeAt(index);
                      PreferencesService.sharedPreferencesInstance.setStringList('foodNames2', foodNames2!);
                      PreferencesService.sharedPreferencesInstance.setStringList('foodCategory2', foodCategory2!);
                      PreferencesService.sharedPreferencesInstance.setStringList('foodInstructionss2', foodInstructionss2!);
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
