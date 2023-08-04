import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:recipeeapp/preference_service.dart';

class AddPlantForm extends StatefulWidget {
  const AddPlantForm({super.key});

  @override
  State<AddPlantForm> createState() => _AddPlantFormState();
}

class _AddPlantFormState extends State<AddPlantForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your Food has been added!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You can now view your food in the Food List!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FormBuilder(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              FormBuilderTextField(
                decoration: const InputDecoration(
                  labelText: 'Food Name',
                  border: OutlineInputBorder(),
                ),
                name: 'foodName',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter food name';
                  }
                  return null;
                },
                onSaved: (newValue) => print(newValue),
              ),
              const SizedBox(height: 20),
              FormBuilderDropdown(
                  validator: (value) => value == null ? 'Please select a category' : null,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  name: 'foodCategory',
                  items: [
                    'Main Dish',
                    'Dessert/Pastry',
                  ].map((category) => DropdownMenuItem(value: category, child: Text("$category"))).toList()),
              const SizedBox(height: 20),
              FormBuilderTextField(
                decoration: const InputDecoration(
                  labelText: 'Ingredients/Instructions/Steps',
                  border: OutlineInputBorder(),
                ),
                name: 'foodInstructions',
                keyboardType: TextInputType.multiline,
                maxLines: null,
                validator: (value) => value == null || value.isEmpty ? 'Please add its ingredients and instructions' : null,
                onSaved: (newValue) => print(newValue),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate() && _formKey.currentState!.value['foodCategory'] == 'Main Dish') {
                        print(_formKey.currentState!.value);
                        print(_formKey.currentState!.value['foodName']);

                        final List<String>? foodNames = PreferencesService.sharedPreferencesInstance.getStringList('foodNames');
                        final List<String>? foodCategory = PreferencesService.sharedPreferencesInstance.getStringList('foodCategory');
                        final List<String>? foodInstructionss = PreferencesService.sharedPreferencesInstance.getStringList('foodInstructionss');

                        if (foodNames == null || foodNames.isEmpty) {
                          await PreferencesService.sharedPreferencesInstance.setStringList('foodNames', [_formKey.currentState!.value['foodName']]);
                          await PreferencesService.sharedPreferencesInstance
                              .setStringList('foodCategory', [_formKey.currentState!.value['foodCategory']]);
                          await PreferencesService.sharedPreferencesInstance
                              .setStringList('foodInstructionss', [_formKey.currentState!.value['foodInstructions']]);
                        } else {
                          foodNames.add(_formKey.currentState!.value['foodName']);
                          await PreferencesService.sharedPreferencesInstance.setStringList('foodNames', foodNames);

                          foodCategory!.add(_formKey.currentState!.value['foodCategory']);
                          await PreferencesService.sharedPreferencesInstance.setStringList('foodCategory', foodCategory);

                          foodInstructionss!.add(_formKey.currentState!.value['foodInstructions']);
                          await PreferencesService.sharedPreferencesInstance.setStringList('foodInstructionss', foodInstructionss);
                        }
                        print("from add plant form");
                        print(PreferencesService.sharedPreferencesInstance.getStringList('foodCategory'));
                        await _showMyDialog();
                        _formKey.currentState!.reset();
                      } else if (_formKey.currentState!.validate() && _formKey.currentState!.value['foodCategory'] == 'Dessert/Pastry') {
                        final List<String>? foodNames2 = PreferencesService.sharedPreferencesInstance.getStringList('foodNames2');
                        final List<String>? foodCategory2 = PreferencesService.sharedPreferencesInstance.getStringList('foodCategory2');
                        final List<String>? foodInstructionss2 = PreferencesService.sharedPreferencesInstance.getStringList('foodInstructionss2');

                        if (foodNames2 == null || foodNames2.isEmpty) {
                          await PreferencesService.sharedPreferencesInstance.setStringList('foodNames2', [_formKey.currentState!.value['foodName']]);
                          await PreferencesService.sharedPreferencesInstance
                              .setStringList('foodCategory2', [_formKey.currentState!.value['foodCategory']]);
                          await PreferencesService.sharedPreferencesInstance
                              .setStringList('foodInstructionss2', [_formKey.currentState!.value['foodInstructions']]);
                        } else {
                          foodNames2.add(_formKey.currentState!.value['foodName']);
                          await PreferencesService.sharedPreferencesInstance.setStringList('foodNames2', foodNames2);

                          foodCategory2!.add(_formKey.currentState!.value['foodCategory']);
                          await PreferencesService.sharedPreferencesInstance.setStringList('foodCategory2', foodCategory2);

                          foodInstructionss2!.add(_formKey.currentState!.value['foodInstructions']);
                          await PreferencesService.sharedPreferencesInstance.setStringList('foodInstructionss2', foodInstructionss2);
                        }
                        print("from add plant form");
                        print(_formKey.currentState!.value['plantLocation']);
                        print(PreferencesService.sharedPreferencesInstance.getStringList('foodCategory2'));
                        await _showMyDialog();
                        _formKey.currentState!.reset();
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState!.reset();
                      PreferencesService.sharedPreferencesInstance.clear();
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
