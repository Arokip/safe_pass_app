import 'package:flutter/material.dart';
import 'package:safe_pass_app/widget/input_field.dart';

class FormScreen extends StatelessWidget {
  FormScreen({Key? key}) : super(key: key);

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
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 16),
              InputField(controller: _serviceTextController, hintText: 'název'),
              SizedBox(height: 16),
              InputField(controller: _nameTextController, hintText: 'jméno'),
              SizedBox(height: 16),
              InputField(
                  controller: _passwordTextController, hintText: 'heslo'),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.grey),
                onPressed: () {
                  // TODO: add a password
                },
                child: Text('Přidat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
