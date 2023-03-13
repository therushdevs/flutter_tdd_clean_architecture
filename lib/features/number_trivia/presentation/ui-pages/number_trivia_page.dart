import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia_clean_architecture/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Number Trivia')),
        body: buildBody(context),
        ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<NumberTriviaBloc>(),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            // Top half
            Container(
              height: MediaQuery.of(context).size.height/3,
              child: const Placeholder(),
            ),

            const SizedBox(
              height: 20,
            ),

            // bottom half
            Container(
              child: const Placeholder(),
            )
          ],
        ),
      );
  }
}

