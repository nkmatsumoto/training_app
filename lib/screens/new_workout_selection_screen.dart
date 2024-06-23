import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/provider/exercises_provider.dart';
import 'package:training_app/screens/new_workout_screen.dart';

class NewWorkoutSelectionScreen extends ConsumerWidget {
  const NewWorkoutSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final exercisesData = ref.read(exercisesProvider);
    final workouts = ref.read(workoutProvider);
    final workoutList = workouts.values.toList();
    final newWorkoutList = [...workoutList];
    // final workoutExerciseList = workoutList[index]

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: newWorkoutList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => NewWorkoutScreen(
                        selectedWorkout: newWorkoutList[index],
                      ),
                    ));
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  newWorkoutList[index].name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 4),
                                const Text('Dummy text here'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (final exercise
                                      in newWorkoutList[index].exercisesList)
                                    Text(exercise.name)
                                ],
                              ),
                            ),
                          ),

                          // Expanded(
                          //     child: ListView.builder(
                          //   itemCount: workoutList[index].exercisesList.length,
                          //   itemBuilder: (context, i) {
                          //     return const ListTile(
                          //       title: Text('data'),
                          //     );
                          //   },
                          // ))

                          // ListView.builder(
                          //   itemCount: workoutList[index].exercisesList.length,
                          //   itemBuilder: (ctx) => ListTile(title: workoutList[index].exercisesList.name,))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              //formKey.currentState!.reset();
              //exerciseRepsDataNotifier.printExerciseRepsData();

              Color printColor = Color.fromARGB(255, 191, 226, 255);
              int printColorInt = printColor.value;
              print('$printColorInt');

              // for (var element in newWorkoutList.elementAt(0).exercisesList) {
              //   print(element.name);
              // }
            },
            child: const Text('show data'),
          ),
        ],
      ),
    );
  }
}
