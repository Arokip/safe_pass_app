import 'package:flutter/material.dart';
import 'package:safe_pass_app/data/password_item.dart';
import 'package:safe_pass_app/widget/detail_line.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  final PasswordItem item;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isPasswordShown = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text(
            'Detail položky',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailLine(
                text: 'název',
                value: widget.item.serviceName,
              ),
              DetailLine(
                text: 'jméno',
                value: widget.item.userName,
              ),
              DetailLine(
                text: 'heslo',
                value: isPasswordShown
                    ? widget.item.password
                    : '*' * widget.item.password.length,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () =>
                        setState(() => isPasswordShown = !isPasswordShown),
                    icon: Icon(
                      isPasswordShown
                          ? Icons.auto_fix_high
                          : Icons.remove_red_eye,
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('kliknutím zkopíruj'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
