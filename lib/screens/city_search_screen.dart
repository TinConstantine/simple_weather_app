import 'package:flutter/material.dart';

class CitySearchScreen extends StatelessWidget {
  CitySearchScreen({super.key});
  final _citySearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter a city'),
        centerTitle: true,
      ),
      body: Form(
          child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TextFormField(
              controller: _citySearchController,
              decoration: const InputDecoration(
                  labelText: 'Enter a city', hintText: 'Example: Hanoi'),
            ),
          )),
          IconButton(
              onPressed: () {
                Navigator.pop(context, _citySearchController.text);
              },
              icon: const Icon(Icons.search))
        ],
      )),
    );
  }
}
