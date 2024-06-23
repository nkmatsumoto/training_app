import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sqflite/sql.dart';
import 'package:training_app/models/exercise_model.dart';
// import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'workouts.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE workout_exercise_data(id TEXT PRIMARY KEY, exerciseName TEXT, repData TEXT, workoutName TEXT, date TEXT)');
    },
    version: 1,
  );
  return db;
}

class ExerciseRepsDataNotifier
    extends StateNotifier<List<WorkoutSessionExerciseReps>> {
  ExerciseRepsDataNotifier()
      : super([
          // WorkoutSessionExerciseReps(
          //     date: DateTime.now(),
          //     exerciseName: 'First Knuckle Push Up',
          //     workoutName: 'Planche / Push up (Demo Exercise Data)',
          //     repData: [10]),
        ]);

  void loadExerciseRepsData() async {
    final db = await _getDatabase();
    final data = await db.query('workout_exercise_data');

    final workoutExercises = data
        .map(
          (dbRow) => WorkoutSessionExerciseReps(
              id: dbRow['id'] as String,
              exerciseName: dbRow['id'] as String,
              repData: jsonDecode(dbRow['repData'] as String),
              workoutName: dbRow['workoutName'] as String,
              date: DateTime.parse(dbRow['date'] as String)),
        )
        .toList();

    state = workoutExercises;
  }

  void addExerciseRepsData(
      WorkoutSessionExerciseReps workoutSessionExerciseReps) async {
    final db = await _getDatabase();

    db.insert(
        'workout_exercise_data',
        {
          'id': workoutSessionExerciseReps.id,
          'exerciseName': workoutSessionExerciseReps.exerciseName,
          'repData': jsonEncode(workoutSessionExerciseReps.repData),
          'workoutName': workoutSessionExerciseReps.workoutName,
          'date': workoutSessionExerciseReps.date.toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace);

    final exerciseExists = state.any((exercise) =>
        exercise.exerciseName == workoutSessionExerciseReps.exerciseName);
    // state.contains(workoutSessionExerciseReps);

    if (exerciseExists) {
      state = state
          .where((exercise) =>
              exercise.exerciseName != workoutSessionExerciseReps.exerciseName)
          .toList();
    }
    state = [...state, workoutSessionExerciseReps];
  }

  void clearExerciseRepsData() {
    state = [];
  }

  // void printExerciseRepsData() {
  //   for (var exercise in state) {
  //     print(exercise.exerciseName);
  //     print(exercise.repData);
  //     print(exercise.workoutName);
  //     print(exercise.date);
  //   }
  // }
}

final exercisesRepsProvider = StateNotifierProvider<ExerciseRepsDataNotifier,
    List<WorkoutSessionExerciseReps>>((ref) {
  return ExerciseRepsDataNotifier();
});





// final workoutSessionDataProvider = Provider((ref) {
//   final workoutSessionData = ref.watch(exercisesRepsProvider);

//   return [
//     WorkoutSessionData(
//       date: DateTime.now(),
//       workoutName: 'Planche / Front Lever (Demo Session Data)',
//       repSessionData: [
//         WorkoutSessionExerciseReps(
//             exerciseName: 'First Knuckle Push Up',
//             repData: [10],
//             workoutName: 'Planche / Front Lever',
//             date: DateTime.now()),
//         WorkoutSessionExerciseReps(
//             exerciseName: 'Serratus Rock',
//             repData: [10],
//             workoutName: 'Scapula Pull Up',
//             date: DateTime.now()),
//         WorkoutSessionExerciseReps(
//             exerciseName: 'Pike Pull Through',
//             repData: [3, 3, 3, 3, 2],
//             workoutName: 'Planche / Front Lever',
//             date: DateTime.now()),
//         WorkoutSessionExerciseReps(
//             exerciseName: 'Lever Pull Negatives',
//             repData: [2, 2, 2, 2, 1],
//             workoutName: 'Planche / Front Lever',
//             date: DateTime.now()),
//         WorkoutSessionExerciseReps(
//             exerciseName: 'Pseudo Plance Push up',
//             repData: [6, 6, 6, 6, 5],
//             workoutName: 'Planche / Front Lever',
//             date: DateTime.now()),
//         WorkoutSessionExerciseReps(
//             exerciseName: 'Arc Row',
//             repData: [8, 8, 8, 8],
//             workoutName: 'Planche / Front Lever',
//             date: DateTime.now()),
//         WorkoutSessionExerciseReps(
//             exerciseName: 'Ring Dips',
//             repData: [4, 4, 3, 2],
//             workoutName: 'Planche / Front Lever',
//             date: DateTime.now()),
//         WorkoutSessionExerciseReps(
//             exerciseName: 'Straight Arm Band Pull Down',
//             repData: [50, 50],
//             workoutName: 'Planche / Front Lever',
//             date: DateTime.now()),
//       ],
//     ),
//     WorkoutSessionData(
//       date: workoutSessionData.elementAt(0).date,
//       workoutName: workoutSessionData.elementAt(0).workoutName,
//       repSessionData: workoutSessionData,
//     ),
//   ];
// });

// // WorkoutSessionData currentWorkoutSessionData =