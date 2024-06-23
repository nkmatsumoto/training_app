import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:training_app/provider/exercise_reps_data_provider.dart';
import 'package:training_app/provider/workout_session_data_provider.dart';
import 'package:training_app/screens/new_workout_selection_screen.dart';
import 'package:training_app/screens/workout_screen.dart';

class WorkoutsListScreen extends ConsumerStatefulWidget {
  const WorkoutsListScreen({super.key});

  @override
  ConsumerState<WorkoutsListScreen> createState() => _WorkoutsListScreenState();
}

class _WorkoutsListScreenState extends ConsumerState<WorkoutsListScreen> {
  late Future<void> _workoutsFuture;

  @override
  void initState() {
    super.initState();
    _workoutsFuture =
        ref.read(workoutSessionsDataProvider.notifier).loadWorkoutSessionData();
  }

  @override
  Widget build(BuildContext context) {
    final workouts = ref.watch(workoutSessionsDataProvider);
    // final workoutList = workouts.values.toList();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Workouts'),
          actions: [
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const NewWorkoutSelectionScreen(),
                ));
              },
              icon: const Icon(Icons.add),
              label: const Text('New'),
            )
          ],
        ),
        body: workouts.isEmpty
            ? const Center(
                child: Text('Complete a workout...'),
              )
            : FutureBuilder(
                future: _workoutsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemCount: workouts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => WorkoutScreen(
                                selectedWorkout: workouts[index],
                              ),
                            ));
                          },
                          title: Text(workouts[index].workoutName),
                          subtitle: Text(workouts[index].formattedDate),
                        );
                      },
                    );
                  }
                },
              ));
  }
}
