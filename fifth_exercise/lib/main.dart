import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Clima App'),
        ),
        body: ClimaScreen(),
      ),
    );
  }
}

class ClimaScreen extends StatefulWidget {
  @override
  _ClimaScreenState createState() => _ClimaScreenState();
}

class _ClimaScreenState extends State<ClimaScreen> {
  TextEditingController cidadeController = TextEditingController();
  String temperatura = '';

  Future<void> obterClima(String cidade) async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cidade&units=metric'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> dados = json.decode(response.body);
      setState(() {
        temperatura = dados['main']['temp'].toString();
      });
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: TextField(
            controller: cidadeController,
            decoration: InputDecoration(
              labelText: 'Digite o nome da cidade',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            obterClima(cidadeController.text);
          },
          child: Text('Obter Clima'),
        ),
        SizedBox(height: 20.0),
        Text('Temperatura: $temperatura °C', style: TextStyle(fontSize: 20.0)),
      ],
    );
  }
}
