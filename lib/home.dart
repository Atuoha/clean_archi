import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              TextFormField(
                controller: searchText,
                autofocus: true,
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty || value.length < 3) {
                    return 'Search number is not valid';
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
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => search(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade300,
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => getRandomTrivia(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text(
                      'Get Random Trivia',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
