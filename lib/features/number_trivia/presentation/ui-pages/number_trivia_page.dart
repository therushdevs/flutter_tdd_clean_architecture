import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia_clean_architecture/injection_container.dart';

import '../../../../core/utils/global_utils.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                // Top half
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    if (state is EmptyState) {
                      return const DisplayMessage(
                        message:
                            'Search for a number & know an interesting fact about it!',
                      );
                    } else if (state is ErrorState) {
                      return DisplayMessage(
                        message: state.errorMessage,
                      );
                    } else if (state is LoadedState) {
                      return NumberTriviaView(
                        numberTrivia: state.numberTrivia,
                      );
                    } else {
                      return loadingIndicator();
                    }
              }),
                  
                const SizedBox(
                  height: 20,
                ),
                  
                // bottom half
                Column(
                  children: [
                    const Placeholder(fallbackHeight: 40,),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(child: Placeholder(fallbackHeight: 40,)),
                        SizedBox(width: 8,),
                        Expanded(child: Placeholder(fallbackHeight: 40,)),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
  }


}

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
          child:  Center(
            child: Expanded(
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

class DisplayMessage extends StatelessWidget {
  final String message;
  const DisplayMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/3,
      child:  Center(
        child: SingleChildScrollView(
          child: Text(
              message,
              style: const TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
        ),
      ),
    );
  }
}

