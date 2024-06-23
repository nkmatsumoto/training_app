import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/models/exercise_model.dart';
import 'package:training_app/provider/exercise_reps_data_provider.dart';

class ExercisesNotifier extends StateNotifier<List<Exercise>> {
  ExercisesNotifier()
      : super(const [
          Exercise(
              name: 'First Knuckle Push Up',
              sets: 1,
              lowerReps: '10',
              upperReps: '12',
              rest: 30,
              tempo: '2-1-X-1',
              category: 'Pre',
              color: Color.fromARGB(255, 191, 226, 255),
              inWorkoutSession: ['d1']),
          Exercise(
              name: 'Serratus Rock',
              sets: 1,
              lowerReps: '10',
              upperReps: '12',
              rest: 30,
              tempo: '2-1-X-1',
              category: 'Pre',
              color: Color.fromARGB(255, 191, 226, 255),
              inWorkoutSession: ['d1']),
          Exercise(
              name: 'Scapula Pull Up',
              sets: 1,
              lowerReps: '10',
              upperReps: '12',
              rest: 30,
              tempo: '2-1-X-1',
              category: 'Pre',
              color: Color.fromARGB(255, 191, 226, 255),
              inWorkoutSession: ['d1']),
          Exercise(
              name: 'Pike Pull Through',
              sets: 5,
              lowerReps: '3',
              upperReps: '5',
              rest: 90,
              tempo: '2-0-1-3',
              category: 'A',
              color: Color.fromARGB(255, 242, 175, 170),
              inWorkoutSession: ['d1']),
          Exercise(
              name: 'Lever Pull Negatives',
              sets: 5,
              lowerReps: '2',
              upperReps: '4',
              rest: 90,
              tempo: '7-10s',
              category: 'A',
              color: Color.fromARGB(255, 242, 175, 170),
              inWorkoutSession: ['d1']),
          Exercise(
              name: 'Pseudo Plance Push up',
              sets: 4,
              lowerReps: '6',
              upperReps: '8',
              rest: 90,
              tempo: '1-1-X-1',
              category: 'B',
              color: Color.fromARGB(255, 241, 235, 177),
              inWorkoutSession: ['d1']),
          Exercise(
              name: 'Arc Row',
              sets: 4,
              lowerReps: '6',
              upperReps: '8',
              rest: 90,
              tempo: '2-1-X-2',
              category: 'B',
              color: Color.fromARGB(255, 241, 235, 177),
              inWorkoutSession: ['d1']),
          Exercise(
              name: 'Ring Dips',
              sets: 4,
              lowerReps: '6',
              upperReps: '8',
              rest: 90,
              tempo: '2-1-X-1',
              category: 'B',
              color: Color.fromARGB(255, 241, 235, 177),
              inWorkoutSession: ['d1']),
          Exercise(
              name: 'Straight Arm Band Pull Down',
              sets: 2,
              lowerReps: '40',
              upperReps: '50',
              rest: 90,
              tempo: '1-1-2-1',
              category: 'C',
              color: Color.fromARGB(255, 179, 220, 180),
              inWorkoutSession: ['d1']),
          Exercise(
              name: 'Back to Wall HSPU',
              sets: 5,
              lowerReps: '5',
              upperReps: '8',
              rest: 90,
              tempo: '2-1-1-1',
              category: 'A',
              color: Color.fromARGB(255, 242, 175, 170),
              inWorkoutSession: ['d5']),
          Exercise(
              name: 'Chest to Wall HSPU Negative',
              sets: 5,
              lowerReps: '2',
              upperReps: '3',
              rest: 90,
              tempo: '8-10s',
              category: 'A',
              color: Color.fromARGB(255, 242, 175, 170),
              inWorkoutSession: ['d5']),
          Exercise(
              name: 'Mixed Grip Chin Up',
              sets: 5,
              lowerReps: '2',
              upperReps: '3',
              rest: 90,
              tempo: '4-0-1-1',
              category: 'A',
              color: Color.fromARGB(255, 242, 175, 170),
              inWorkoutSession: ['d5']),
          Exercise(
              name: 'Ring Pull Up',
              sets: 5,
              lowerReps: '6',
              upperReps: '8',
              rest: 90,
              tempo: '3-1-X-1',
              category: 'A',
              color: Color.fromARGB(255, 242, 175, 170),
              inWorkoutSession: ['d5']),
          Exercise(
              name: 'Deep Pike Push Up',
              sets: 4,
              lowerReps: '4',
              upperReps: '6',
              rest: 90,
              tempo: '3-1-1-0',
              category: 'B',
              color: Color.fromARGB(255, 241, 235, 177),
              inWorkoutSession: ['d5']),
          Exercise(
              name: 'Archer Row',
              sets: 4,
              lowerReps: '4',
              upperReps: '6',
              rest: 90,
              tempo: '3-0-1-1',
              category: 'B',
              color: Color.fromARGB(255, 241, 235, 177),
              inWorkoutSession: ['d5']),
          Exercise(
              name: 'Arm in Front Ext. Rotation',
              sets: 3,
              lowerReps: '8',
              upperReps: '10',
              rest: 90,
              tempo: '3-1-1-0',
              category: 'C',
              color: Color.fromARGB(255, 179, 220, 180),
              inWorkoutSession: ['d5']),
          Exercise(
              name: 'Single Arm Scapula Pull Up',
              sets: 3,
              lowerReps: '6',
              upperReps: '8',
              rest: 90,
              tempo: '1-1-1-3',
              category: 'C',
              color: Color.fromARGB(255, 179, 220, 180),
              inWorkoutSession: ['d5']),
          Exercise(
              name: 'Dumbbell Hammer Curl',
              sets: 3,
              lowerReps: '6',
              upperReps: '8',
              rest: 90,
              tempo: '3-1-2-1',
              category: 'C',
              color: Color.fromARGB(255, 179, 220, 180),
              inWorkoutSession: ['d5']),
        ]);

  void addExercise(Exercise exercise) {
    final exerciseIsPresent = state.contains(exercise);

    if (exerciseIsPresent) {
      return;
    } else {
      state = [...state, exercise];
    }
  }
}

final exercisesProvider =
    StateNotifierProvider<ExercisesNotifier, List<Exercise>>((ref) {
  ref.watch(exercisesRepsProvider);
  return ExercisesNotifier();
});

final workoutProvider = Provider((ref) {
  final exerciseRepository = ref.watch(exercisesProvider);
  List<Exercise> plancheFrontLever = exerciseRepository
      .where((exercise) => exercise.inWorkoutSession.contains('d1'))
      .toList();

  List<Exercise> hspuMuscleUp = exerciseRepository
      .where((exercise) => exercise.inWorkoutSession.contains('d5'))
      .toList();

  return {
    'd1': WorkoutSession(
      id: 'd1',
      name: 'Planche / Front Lever',
      exercisesList: plancheFrontLever,
    ),
    'd5': WorkoutSession(
      id: 'd5',
      name: 'HSPU / Muscle Up',
      exercisesList: hspuMuscleUp,
    ),
  };
});
