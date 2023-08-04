import 'package:flutter/material.dart';
import 'package:recipeeapp/pages/my_plant.dart';
import 'package:recipeeapp/pages/add_plant.dart';
import 'package:recipeeapp/pages/reminders.dart';
import 'package:recipeeapp/preference_service.dart';

/// Flutter code sample for [BottomNavigationBar].

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BottomNavigationBarExample(),
      theme: ThemeData(
        primarySwatch: Colors.brown,
        primaryColor: Colors.brown[800],
        brightness: Brightness.light,
        dividerColor: Colors.brown[700],
        fontFamily: 'Montserrat',
      ),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    PreferencesService.init();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant, color: Colors.white),
            SizedBox(width: 10),
            Text('RecipeLister'),
          ],
        ), //Text('Plant Care'),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.brown[200],
        indicatorColor: Colors.white,
        surfaceTintColor: Colors.white,
        indicatorShape:
            const BeveledRectangleBorder(borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(10), topEnd: Radius.circular(10))),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.fastfood),
            label: 'Food Lists',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: 'Add Food',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book),
            label: 'Reminders',
          ),
          NavigationDestination(
            icon: Icon(Icons.people),
            label: 'About',
          )
        ],
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: <Widget>[
        const MyPlant(),
        const AddPlantForm(),
        const Reminders(),
        const About(),
      ][currentPageIndex],
    );
  }
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Made by: Group 7", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown)),
          SizedBox(height: 10),
          Text("Paolo Arceño"),
          Text("Charlene Dalipe"),
          Text("Jenny-Ann Lomotan"),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
