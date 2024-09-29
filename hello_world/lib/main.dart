// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application to convert',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  bool isFahrenheitToCelsius = true;
  final TextEditingController _temperatureController = TextEditingController();
  String _result = '';
  final List<String> _history = [];

  void _convert() {
    if (_temperatureController.text.isEmpty) return;

    double inputTemp = double.parse(_temperatureController.text);
    double convertedTemp;
    String operation;

    if (isFahrenheitToCelsius) {
      convertedTemp = (inputTemp - 32) * 5 / 9;
      operation = 'Far to Celicus';
    } else {
      convertedTemp = inputTemp * 9 / 5 + 32;
      operation = 'Celisus to Far';
    }

    setState(() {
      _result = convertedTemp.toStringAsFixed(2);
      _history.insert(0, '$operation: ${inputTemp.toStringAsFixed(1)} => $_result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application for converting temperature'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('°Far to °Celisus'),
                    value: true,
                    groupValue: isFahrenheitToCelsius,
                    onChanged: (value) {
                      setState(() {
                        isFahrenheitToCelsius = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('°Celisus to °Far'),
                    value: false,
                    groupValue: isFahrenheitToCelsius,
                    onChanged: (value) {
                      setState(() {
                        isFahrenheitToCelsius = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            TextField(
              controller: _temperatureController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
                suffixText: isFahrenheitToCelsius ? '°F' : '°C',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16),
            Text(
              'Result: $_result${isFahrenheitToCelsius ? '°C' : '°F'}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('History:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}