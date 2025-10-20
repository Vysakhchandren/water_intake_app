import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Water '),centerTitle: true,elevation: 4.0,actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),

      ],),
      backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
