import 'package:flutter/material.dart';
import 'package:recipeeapp/pages/indoor_plants.dart';
import 'package:recipeeapp/pages/outdoor_plants.dart';

class MyPlant extends StatelessWidget {
  const MyPlant({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: SizedBox(
              height: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/dishes.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Main Dishes",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                            "A main dish is usually the heartiest, most substantial part of a meal. It's the part of the meal that is often the star."),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                      // gawin mo tong async tapos
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const IndoorPlants()));
                      },
                      child: const Text('View All'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: SizedBox(
              height: 340,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/desserts.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Desserts and Pastries",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Dessert is sweet delicacy consists of pastries and confections. It is usually enjoyed throughout the day."),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                      // gawin mo tong async tapos
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const OutdoorPlants()));
                      },
                      child: const Text('View All'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
