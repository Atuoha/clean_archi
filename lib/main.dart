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
      debugShowCheckedModeBanner: false,
      title: 'Flutter GoRouter',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.orange)
      ),
      home: const NumberTriviaPage(),
    );
  }
}
