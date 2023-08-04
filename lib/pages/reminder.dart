import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:convert';
import 'package:recipeeapp/preference_service.dart';
import 'package:intl/intl.dart';

class ReminderForm extends StatefulWidget {
  final int index;
  final String plantName;
  final String instructions;

  const ReminderForm({super.key, required this.index, required this.plantName, required this.instructions});
  @override
  State<ReminderForm> createState() => _ReminderFormState();
}

class _ReminderFormState extends State<ReminderForm> {
  final List<String>? plantReminders = PreferencesService.sharedPreferencesInstance.getStringList('remindDatas');

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cooking Reminder"),
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FormBuilder(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  FormBuilderTextField(
                      name: 'foodName',
                      initialValue: widget.plantName,
                      readOnly: true,
                      decoration: const InputDecoration(labelText: 'Food Name', border: OutlineInputBorder())),
                  const SizedBox(height: 20),
                  FormBuilderTextField(
                    name: 'instructions',
                    initialValue: widget.instructions,
                    readOnly: true,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(labelText: 'Instructions', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  FormBuilderDateTimePicker(
                    name: "timeToRemind",
                    initialValue: DateTime.now(),
                    inputType: InputType.both,
                    decoration: const InputDecoration(
                      labelText: "Set date for reminder",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState?.save();
                      if (_formKey.currentState?.validate() ?? false) {
                        final List<String>? foodReminders = PreferencesService.sharedPreferencesInstance.getStringList('remindDatas');
                        var remindData = {
                          'foodName': _formKey.currentState?.value['foodName'],
                          'timeToRemind': DateFormat('yyyy-MM-dd HH:mm:ss').format(_formKey.currentState?.value['timeToRemind']),
                        };
                        String remindDataString = jsonEncode(remindData);
                        if (foodReminders == null) {
                          await PreferencesService.sharedPreferencesInstance.setStringList('remindDatas', [remindDataString]);
                        } else {
                          foodReminders.add(remindDataString);
                          await PreferencesService.sharedPreferencesInstance.setStringList('remindDatas', foodReminders);
                        }
                      } else {
                        print("validation failed");
                      }
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
