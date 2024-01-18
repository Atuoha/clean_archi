import 'package:flutter/material.dart';
import '../widgets/action_buttons.dart';
import '../widgets/number_text.dart';
import '../widgets/number_trivia_desc.dart';
import '../widgets/text_input.dart';

class NumberTriviaPage extends StatefulWidget {
  const NumberTriviaPage({super.key});

  @override
  State<NumberTriviaPage> createState() => _NumberTriviaPageState();
}

class _NumberTriviaPageState extends State<NumberTriviaPage> {
  TextEditingController searchText = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isTextEmpty = true;

  @override
  void initState() {
    searchText.addListener(() {
      if (searchText.text.isNotEmpty) {
        setState(() {
          isTextEmpty = false;
        });
      } else {
        setState(() {
          isTextEmpty = true;
        });
      }
    });
    super.initState();
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const NumberText(number: '222'),
                const SizedBox(height: 10),
                const NumberTriviaDesc(
                  numberTrivia:
                      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,'
                      'molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum'
                      'numquam blanditiis harum quisquam eius sed odit fugiat iusto',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Start Searching',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                TextInput(searchText: searchText),
                const SizedBox(height: 20),
                ActionButtons(
                  search: search,
                  getRandomTrivia: getRandomTrivia,
                  isTextEmpty: isTextEmpty,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
