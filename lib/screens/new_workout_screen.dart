import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/models/exercise_model.dart';
import 'package:training_app/provider/exercise_reps_data_provider.dart';
// import 'package:training_app/provider/exercises_provider.dart';
import 'package:training_app/provider/workout_session_data_provider.dart';

// import 'package:training_app/screens/workouts_list_screen.dart';

import 'package:training_app/widgets/new_excercise_item.dart';

class NewWorkoutScreen extends ConsumerStatefulWidget {
  const NewWorkoutScreen({
    super.key,
    required this.selectedWorkout,
  });

  final WorkoutSession selectedWorkout;

  @override
  ConsumerState<NewWorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends ConsumerState<NewWorkoutScreen> {
  // @override
  // void initState() {
  //   final workouts = ref.read(workoutProvider);
  //   final workoutList = workouts.values.toList();
  //   WorkoutSession selectedWorkoutSession = workoutList.singleWhere(
  //     (element) => element.id == widget.selectedWorkout.id,
  //   );

  //   List<Exercise> selectedWorkoutExerciseList =
  //       selectedWorkoutSession.exercisesList;
  //   // selectedWorkoutExerciseList.clear();

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final workoutSessionData = ref.read(workoutSessionsDataProvider);
    final exerciseRepsDataNotifier = ref.read(exercisesRepsProvider.notifier);
    final workoutSessionsDataNotifier =
        ref.read(workoutSessionsDataProvider.notifier);
    // final workouts = ref.read(workoutProvider);
    // final workoutList = workouts.values.toList();

    final formKey = GlobalKey<FormState>();

    // WorkoutSession selectedWorkoutSession = workoutList.singleWhere(
    //   (element) => element.id == widget.selectedWorkout.id,
    // );

    List<Exercise> selectedWorkoutExerciseList =
        widget.selectedWorkout.exercisesList;
    // selectedWorkoutSession.exercisesList;

    void saveWorkoutSession() {
      // if (formKey.currentState!.validate()) {
      // formKey.currentState!.save();
      // }
      WorkoutSessionData currentWorkoutSessionData = WorkoutSessionData(
        date: DateTime.now(),
        workoutName: widget.selectedWorkout.name,
        repSessionData: ref.read(exercisesRepsProvider),
      );

      if (ref.watch(exercisesRepsProvider).isNotEmpty) {
        workoutSessionsDataNotifier
            .addWorkoutSessionData(currentWorkoutSessionData);
        exerciseRepsDataNotifier.clearExerciseRepsData();

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 1),
            content: Text('Workout logged!',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black))));
      }

      Navigator.of(context)
        ..pop()
        ..pop();
    }

    void removeExercise(Exercise exercise) {
      setState(() {
        selectedWorkoutExerciseList.remove(exercise);
      });
    }

    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.selectedWorkout.name),
        ),
        body: DefaultTextStyle(
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
          child: Container(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            width: double.infinity,
            child: Form(
              key: formKey,
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
                    child: ReorderableListView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 1,
                      ),
                      buildDefaultDragHandles: false,
                      itemCount: selectedWorkoutExerciseList.length,
                      itemBuilder: (ctx, index) {
                        return Dismissible(
                          key: ValueKey(selectedWorkoutExerciseList[index]),
                          onDismissed: (direction) {
                            removeExercise(selectedWorkoutExerciseList[index]);
                          },
                          child: Row(
                            children: [
                              NewExcerciseItem(
                                exercise: selectedWorkoutExerciseList[index],
                                sets: selectedWorkoutExerciseList[index].sets,
                                selectedWorkout: widget.selectedWorkout,

                                // reps: d1WorkoutSessionData[
                                //     selectedWorkout.exercisesList[index].name]!,
                              ),
                              ReorderableDragStartListener(
                                index: index,
                                child: const Icon(
                                  Icons.drag_handle,
                                  color: Color.fromARGB(255, 155, 155, 155),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          final item =
                              selectedWorkoutExerciseList.removeAt(oldIndex);
                          selectedWorkoutExerciseList.insert(newIndex, item);
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      // const Spacer(),
                      TextButton.icon(
                          iconAlignment: IconAlignment.start,
                          onPressed: () {
                            FocusScope.of(context).previousFocus();
                          },
                          style: TextButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                              padding: const EdgeInsets.only(right: 15)),
                          icon: const Icon(Icons.arrow_back_ios_new),
                          label: const Text('Back')),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      TextButton.icon(
                          onPressed: () {
                            saveWorkoutSession();
                          },
                          icon: const Icon(
                            Icons.save_as,
                            color: Colors.white,
                          ),
                          label: const Text('Log Workout')),

                      TextButton.icon(
                          iconAlignment: IconAlignment.end,
                          onPressed: () {
                            FocusScope.of(context).nextFocus();
                          },
                          style: TextButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                              padding: const EdgeInsets.only(left: 15)),
                          icon: const Icon(Icons.arrow_forward_ios),
                          label: const Text('Next')),
                      const SizedBox(
                        width: 5,
                      ),

                      TextButton(
                        onPressed: () {
                          //formKey.currentState!.reset();
                          //exerciseRepsDataNotifier.printExerciseRepsData();
                          print(selectedWorkoutExerciseList);
                        },
                        child: const Text('show data'),
                      ),

                      // TextButton(
                      //   onPressed: () {
                      //     //formKey.currentState!.reset();
                      //     workoutSessionsDataNotifier.printWorkoutSessionData();
                      //   },
                      //   child: const Text('show workout session data'),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
