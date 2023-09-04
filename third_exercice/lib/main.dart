import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      home: ItemList(),
    );
  }
}

class ItemList extends StatelessWidget {

  final List<Map<String, String>> items = [
    {
      'title': 'Oca',
      'description': 'Oca é uma habitação típica dos povos indígenas. A palavra tem sua origem na família linguística tupi-guarani.As ocas são construídas coletivamente, ou seja, com a participação de vários integrantes da tribo. São grandes, podendo chegar até 40 metros de comprimento. Seu tamanho é justificado, pois várias famílias de índios habitam uma mesma oca.',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Tarrafa',
      'description': 'Uma tarrafa é uma rede de pesca circular com pequenos pesos distribuídos em torno de toda a circunferência da malha.A tarrafa é arremessada geralmente com as mãos, de tal maneira que esta se abra o máximo possível antes de cair na água. Ao entrar em contato com a água, a rede afunda imediatamente. Jogar uma tarrafa exige prática e técnica',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    // Adicione mais itens aqui...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Itens'),
      ),
      body:ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Padding(
      padding:const EdgeInsets.only(bottom: 8.0), // Adicione o espaço desejado abaixo de cada item
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0), // Adicione o espaço desejado ao redor do conteúdo do ListTile
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetails(item: items[index]),
            ),
          );
        },
        leading: Image.network(items[index]['imageUrl']!),
        title: Text(items[index]['title']!),
      ),
    );
  },
) 
    );
  }
}

class ItemDetails extends StatelessWidget {
  final Map<String, String> item;

  const ItemDetails({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Item'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(item['imageUrl']!),
            const SizedBox(height: 20),
            Text(
              item['title']!,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              item['description']!,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}