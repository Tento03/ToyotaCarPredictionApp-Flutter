import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:toyotacarpriceprediction/model/History.dart';

class Scanpage extends StatefulWidget {
  const Scanpage({super.key});

  @override
  State<Scanpage> createState() => _ScanpageState();
}

class _ScanpageState extends State<Scanpage> {
  final key = GlobalKey<FormState>();
  final Box historyBox = Hive.box<History>('historyBox');

  String model = 'Sedan';
  final yearController = TextEditingController();
  String transmission = 'Manual';
  final mileageController = TextEditingController();
  String fuelType = 'Petrol';
  final taxController = TextEditingController();
  final mpgController = TextEditingController();
  double engineSize = 1.0;
  String? prediction;

  int mapModel(String value) {
    switch (value.trim()) {
      case 'Sedan':
        return 0;
      case 'SUV':
        return 1;
      case 'Hatchback':
        return 2;
      case 'Sports Car':
        return 3;
      case 'MPV':
        return 4;
      case 'Pickup':
        return 5;
      case 'Hybrid':
        return 6;
      default:
        return 0;
    }
  }

  int mapTransmission(String value) => value == 'Automatic' ? 0 : 1;

  int mapFuelType(String value) {
    switch (value) {
      case 'Petrol':
        return 0;
      case 'Diesel':
        return 1;
      case 'Hybrid':
        return 2;
      default:
        return 0;
    }
  }

  int mapEngineSize(double value) {
    switch (value) {
      case 1.0:
        return 0;
      case 1.2:
        return 1;
      case 1.3:
        return 2;
      case 1.5:
        return 3;
      case 1.6:
        return 4;
      case 1.8:
        return 5;
      case 2.0:
        return 6;
      case 2.2:
        return 7;
      case 2.5:
        return 8;
      case 3.0:
        return 9;
      default:
        return 0;
    }
  }

  Future<void> postData() async {
    if (!key.currentState!.validate()) return;

    List<dynamic> input = [
      double.tryParse(yearController.text) ?? 2011,
      mapTransmission(transmission),
      double.tryParse(mileageController.text) ?? 0,
      mapFuelType(fuelType),
      double.tryParse(taxController.text) ?? 0,
      double.tryParse(mpgController.text) ?? 0,
      mapEngineSize(engineSize),
      mapModel(model),
    ];

    try {
      var uri = Uri.parse('http://192.168.1.15:5000/predict');
      var response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'input': input}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          prediction = data['Prediction'].toString();
          historyBox.add(
            History(
              model: model,
              year: yearController.text,
              transmission: transmission,
              mileage: double.tryParse(mileageController.text) ?? 0.0,
              fuelType: fuelType,
              tax: double.tryParse(taxController.text) ?? 0.0,
              mpg: double.tryParse(mpgController.text) ?? 0.0,
              engineSize: engineSize,
              prediction: prediction!,
            ),
          );
        });
      } else {
        final error = json.decode(response.body);
        setState(() {
          prediction = 'Error: ${error['msg']}';
        });
      }
    } catch (e) {
      setState(() {
        prediction = 'Error: $e';
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mpgController.dispose();
    taxController.dispose();
    yearController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Page'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: key,
          child: Column(
            children: [
              CustomTextField(controller: yearController, label: 'Year'),
              CustomTextField(controller: mileageController, label: 'Mileage'),
              CustomTextField(controller: taxController, label: 'Tax'),
              CustomTextField(controller: mpgController, label: 'MPG'),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: transmission,
                isExpanded: true,
                items:
                    ['Manual', 'Automatic']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    transmission = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Transmission'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: fuelType,
                isExpanded: true,
                items:
                    ['Petrol', 'Diesel', 'Hybrid']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    fuelType = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Fuel Type'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<double>(
                value: engineSize,
                isExpanded: true,
                items:
                    [1.0, 1.2, 1.3, 1.5, 1.6, 1.8, 2.0, 2.2, 2.5, 3.0]
                        .map(
                          (e) => DropdownMenuItem(value: e, child: Text('$e')),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    engineSize = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Engine Size'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: postData, child: const Text('Predict')),
              const SizedBox(height: 16),
              if (prediction != null)
                Text(
                  'Prediction Price: $prediction',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator:
            (value) => value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }
}
