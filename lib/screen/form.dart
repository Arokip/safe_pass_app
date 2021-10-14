import 'package:flutter/material.dart';
import 'package:safe_pass_app/data/password_item.dart';
import 'package:safe_pass_app/database/db.dart';
import 'package:safe_pass_app/widget/input_field.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String errorMessage = '';

  final _serviceTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text(
            'Přidat nové heslo',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              InputField(
                controller: _serviceTextController,
                textInputAction: TextInputAction.next,
                hintText: 'Služba',
              ),
              const SizedBox(height: 16),
              InputField(
                controller: _nameTextController,
                textInputAction: TextInputAction.next,
                hintText: 'Jméno',
              ),
              const SizedBox(height: 16),
              InputField(
                controller: _passwordTextController,
                textInputAction: TextInputAction.done,
                hintText: 'Heslo',
              ),
              const SizedBox(height: 16),
              if (errorMessage != '')
                Text(errorMessage, style: const TextStyle(color: Colors.red)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.grey),
                onPressed: () {
                  if (_serviceTextController.text == '' ||
                      _nameTextController.text == '' ||
                      _passwordTextController.text == '') {
                    setState(() {
                      errorMessage = 'Vyplňte všechny položky';
                    });
                    return;
                  }
                  PasswordDatabase.instance.insert(
                    PasswordItem(
                      serviceName: _serviceTextController.text,
                      userName: _nameTextController.text,
                      password: _passwordTextController.text,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Přidat',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
