import 'package:clean_archi/core/utils/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/num_trivia/presentation/pages/number_trivia_page.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return MaterialApp(
      title: 'Flutter GoRouter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const NumberTriviaPage(),
    );
  }
}
