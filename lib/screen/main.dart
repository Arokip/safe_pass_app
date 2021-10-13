import 'package:flutter/material.dart';
import 'package:safe_pass_app/data/password_item.dart';
import 'package:safe_pass_app/database/db.dart';
import 'package:safe_pass_app/screen/detail.dart';
import 'package:safe_pass_app/screen/form.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<PasswordItem> passwords;

  @override
  void initState() {
    super.initState();
    loadPasswords();
  }

  @override
  void dispose() {
    PasswordDatabase.instance.close();
    super.dispose();
  }

  Future<List<PasswordItem>> loadPasswords() async {
    return PasswordDatabase.instance.readAllPasswords();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Center(
            child: Text(
              'Appka na ukládání hesel',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: FutureBuilder<List<PasswordItem>>(
            future: loadPasswords(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PasswordItem>> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return snapshot.data!.isNotEmpty
                    ? ListView(
                        padding: const EdgeInsets.all(8),
                        children: snapshot.data!
                            .map(
                              (item) => ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailScreen(item: '$item'),
                                    ),
                                  );
                                },
                                title: Center(child: Text('item $item')),
                                subtitle: Center(child: Text('subtitle')),
                              ),
                            )
                            .toList(),
                      )
                    : const Center(child: Text('není žádné heslo uložené'));
              } else {
                return const CircularProgressIndicator(color: Colors.grey);
              }
            }),
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
