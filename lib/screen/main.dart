import 'package:flutter/material.dart';
import 'package:safe_pass_app/screen/detail.dart';
import 'package:safe_pass_app/screen/form.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Center(
            child: const Text(
              'Appka na ukládání hesel',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [1, 2, 3]
              .map(
                (item) => ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(item: '$item'),
                      ),
                    );
                  },
                  title: Center(child: Text('item $item')),
                  subtitle: Center(child: Text('subtitle')),
                ),
              )
              .toList(),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Přidat nové heslo',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormScreen()),
            );
          },
          child: const Icon(Icons.add, color: Colors.black),
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}
