import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:training_app/provider/exercises_provider.dart';

class ExcerciseItem extends ConsumerWidget {
  const ExcerciseItem({
    super.key,
    required this.exercise,
    // required this.reps,
  });
  //     List<int>? reps,
  // }) : reps = [];

  final WorkoutSessionExerciseReps exercise;

  // final List<int> reps;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int sum = exercise.repData.fold(0, (int acc, int number) => acc + number);
    final exerciseData = ref.read(exercisesProvider);

    final selectedExercise = (exerciseData.firstWhere(
        (element) => element.name == exercise.exerciseName)) as dynamic;

    final List<Widget> repsWidgets = List.generate(
      exercise.repData.length,
      (index) => Container(
        alignment: Alignment.center,
        height: 30,
        width: 23,
        // margin: const EdgeInsets.symmetric(horizontal: 1),
        // alignment: Alignment.center,
        // padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.white,
              width: 0.5,
              strokeAlign: BorderSide.strokeAlignCenter),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          exercise.repData[index].toString(),
          //reps.contains(0) ? '' : reps[index].toString(),
          textAlign: TextAlign.left,
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                textAlign: TextAlign.right,
                softWrap: true,
                exercise.exerciseName,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(height: 1.1, color: selectedExercise.color),
              ),
              Text(
                '${selectedExercise.sets.toString()}x${selectedExercise.lowerReps}-${selectedExercise.upperReps}, rest: ${selectedExercise.rest}s',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        ...repsWidgets,
        Flexible(
          child: Container(),
        ),
        Container(
          margin: const EdgeInsets.only(right: 15),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 157, 229, 227),
                width: 0.5,
                strokeAlign: BorderSide.strokeAlignCenter),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6),
          ),
          width: 33,
          child: Text(
            sum.toString(),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
