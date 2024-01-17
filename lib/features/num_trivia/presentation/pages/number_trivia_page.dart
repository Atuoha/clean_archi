import 'package:flutter/material.dart';
import '../widgets/action_buttons.dart';
import '../widgets/text_input.dart';

class NumberTriviaPage extends StatefulWidget {
  const NumberTriviaPage({super.key});

  @override
  State<NumberTriviaPage> createState() => _NumberTriviaPageState();
}

class _NumberTriviaPageState extends State<NumberTriviaPage> {
  TextEditingController searchText = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void search() {
    FocusScope.of(context).unfocus();
    var valid = _formKey.currentState!.validate();
    if (valid) {
      return;
    }
    // Todo: search fnc
  }

  void getRandomTrivia() {
    FocusScope.of(context).unfocus();
    var valid = _formKey.currentState!.validate();
    if (valid) {
      return;
    }
    // Todo: random trivia fnc
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Clean Architecture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Start Searching',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              TextInput(searchText: searchText),
              const SizedBox(height: 10),
              ActionButtons(
                search: search,
                getRandomTrivia: getRandomTrivia,
              )
            ],
          ),
        ),
      ),
    );
  }
}
