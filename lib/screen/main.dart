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
    refreshPasswords();
  }

  @override
  void dispose() {
    PasswordDatabase.instance.close();
    super.dispose();
  }

  Future<List<PasswordItem>> refreshPasswords() async {
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
            future: refreshPasswords(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PasswordItem>> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return snapshot.data!.isNotEmpty
                    ? ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(height: 1),
                        itemBuilder: (BuildContext context, int index) {
                          final item = snapshot.data![index];
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(item: '$item'),
                                ),
                              );
                            },
                            title: Center(
                              child: Text('Služba: ${item.serviceName}'),
                            ),
                            subtitle: Center(
                              child: Text('Jméno: ${item.userName}'),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                PasswordDatabase.instance.delete(item.id);
                                setState(() {});
                              },
                              icon: const Icon(Icons.clear),
                            ),
                          );
                        },
                      )
                    : const Center(child: Text('není žádné heslo uložené'));
              } else {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.grey),
                );
              }
            }),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Přidat nové heslo',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormScreen()),
            ).then((value) => setState(() {}));
            refreshPasswords();
          },
          child: const Icon(Icons.add, color: Colors.black),
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}
