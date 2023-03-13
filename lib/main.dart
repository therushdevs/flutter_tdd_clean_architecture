import 'package:flutter/material.dart';
import 'features/number_trivia/presentation/ui-pages/number_trivia_page.dart';
import 'injection_container.dart' as d_injection;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await d_injection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NumberTriviaPage(),
    );
  }
}
