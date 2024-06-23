import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/models/exercise_model.dart';
// import 'package:training_app/provider/exercise_reps_data_provider.dart';
import 'package:training_app/widgets/excercise_item.dart';
// import 'package:training_app/provider/workout_session_data_provider.dart';
// import 'package:training_app/widgets/new_excercise_item.dart';

// import 'package:training_app/data/dummy_data.dart';
// import 'package:training_app/provider/exercises_provider.dart';

class WorkoutScreen extends ConsumerStatefulWidget {
  const WorkoutScreen({
    super.key,
    required this.selectedWorkout,
  });

  final WorkoutSessionData selectedWorkout;

  @override
  ConsumerState<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends ConsumerState<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    // final workoutSessionData = ref.read(workoutSessionsDataProvider);

    // final exerciseRepsDataNotifier = ref.read(exercisesRepsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedWorkout.workoutName),
      ),
      body: DefaultTextStyle(
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.centerRight,
                    width: 120,
                    child: Text(
                      'Excercises',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Flexible(
                    child: Container(),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    width: 75,
                    child: Text(
                      'Reps',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Flexible(
                    child: Container(),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    width: 58,
                    child: Text(
                      'Volume',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 1,
                  ),
                  itemCount: widget.selectedWorkout.repSessionData.length,
                  itemBuilder: (ctx, index) {
                    return ExcerciseItem(
                      exercise: widget.selectedWorkout.repSessionData[index],
                    );
                  },
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     // TextButton(
              //     //   onPressed: () {
              //     //     //formKey.currentState!.reset();
              //     //     exerciseRepsDataNotifier.printExerciseRepsData();
              //     //   },
              //     //   child: const Text('show data'),
              //     // ),
              //     // TextButton.icon(
              //     //   onPressed: () {
              //     //     saveWorkoutSession();
              //     //   },
              //     //   icon: const Icon(
              //     //     Icons.save_as,
              //     //     color: Colors.white,
              //     //   ),
              //     //   label: const Text('Save'),
              //     // ),
              //   ],
              // ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
