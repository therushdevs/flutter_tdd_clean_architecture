import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/number_trivia_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    super.key,
  });

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final TextEditingController _controller = TextEditingController();
  late String input;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          onChanged: (value){
            input = value;
          },
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            hintText: 'Enter Number',
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            Expanded(child: ElevatedButton(
              onPressed: (){
                _controller.clear();
               BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForConcreteNumber(numberString: input));
              },
              child: const Text('Search'),
            )),
            const SizedBox(width: 8,),
            Expanded(child: ElevatedButton(
              onPressed: (){
               BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
              },
              child: const Text('Random Search'),
            )),
          ],
        )
      ],
    );
  }
}