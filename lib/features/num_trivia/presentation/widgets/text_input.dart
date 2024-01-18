import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.searchText,
    required this.searchTriviaFnc,
  });

  final TextEditingController searchText;
  final Function searchTriviaFnc;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchText,
      autofocus: true,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.number,
      onFieldSubmitted: (value) {
        searchTriviaFnc();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Search number is can not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Enter a number',
        label: const Text('Number'),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
