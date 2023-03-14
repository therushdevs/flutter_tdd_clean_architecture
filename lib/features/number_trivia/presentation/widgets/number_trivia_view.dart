import 'package:flutter/material.dart';
import '../../domain/entities/number_trivia.dart';

class NumberTriviaView extends StatelessWidget {
  final NumberTrivia numberTrivia;
  const NumberTriviaView({
    super.key,
    required this.numberTrivia
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${numberTrivia.number}',
          style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),

        Container(
          height: MediaQuery.of(context).size.height/3,
          child:  SizedBox(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                    numberTrivia.text,
                    style: const TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}