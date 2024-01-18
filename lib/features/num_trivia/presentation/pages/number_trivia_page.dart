import 'package:clean_archi/core/constants/enums/processing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/number_trivia_model.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/action_buttons.dart';
import '../widgets/number_trivia_display.dart';
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
    if (!valid) {
      return;
    }
    print(searchText.text);

    context.read<NumberTriviaBloc>().add(
          GetConcreteNumberTriviaEvent(
            numberString: searchText.text,
          ),
        );
  }

  void getRandomTrivia() {
    FocusScope.of(context).unfocus();
    context.read<NumberTriviaBloc>().add(
          GetRandomNumberTriviaEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Clean Architecture'),
      ),
      body: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (state.processingState == ProcessingState.success) ...[
                    NumberTriviaDisplay(
                      numberTrivia: state.numberTrivia,
                    ),
                  ] else if (state.processingState ==
                      ProcessingState.error) ...[
                    Text(
                      'An error occurred: ${state.errorMsg}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                  ] else if (state.processingState ==
                      ProcessingState.loading) ...[
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                    )
                  ] else ...[
                    const Text(
                      'Start Searching',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ],
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
          );
        },
      ),
    );
  }
}
