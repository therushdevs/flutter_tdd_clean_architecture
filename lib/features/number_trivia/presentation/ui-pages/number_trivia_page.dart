import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia_clean_architecture/injection_container.dart';
import '../../../../core/utils/global_utils.dart';
import '../widgets/export_widgets.dart';
import '../widgets/trivia_controls.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Number Trivia')),
        body: SingleChildScrollView(
          child: buildBody(context),
          ),
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
                      return loadingIndicator(context);
                    }
              }),
                
                const SizedBox(
                  height: 20,
                ),
                  
                // bottom half
                const TriviaControls()
              ],
            ),
          ),
        ),
      );
  }
}



