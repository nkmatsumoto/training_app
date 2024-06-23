import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      db.execute(
          'CREATE TABLE workout_session_data(id TEXT PRIMARY KEY, workoutName TEXT, repSessionData TEXT, date TEXT)');
      db.execute(
          'CREATE TABLE workout_exercise_data(id TEXT PRIMARY KEY, exerciseName TEXT, repData TEXT, workoutName TEXT, date TEXT)');
    },
    version: 1,
  );
  return db;
}

class WorkoutSessionDataNotifier
    extends StateNotifier<List<WorkoutSessionData>> {
  WorkoutSessionDataNotifier()
      : super([
          // WorkoutSessionData(
          //   date: DateTime.now(),
          //   workoutName: 'Planche / Front Lever (Demo Session Data)',
          //   repSessionData: [
          //     WorkoutSessionExerciseReps(
          //         exerciseName: 'First Knuckle Push Up',
          //         repData: [10],
          //         workoutName: 'Planche / Front Lever',
          //         date: DateTime.now()),
          //     WorkoutSessionExerciseReps(
          //         exerciseName: 'Serratus Rock',
          //         repData: [10],
          //         workoutName: 'Scapula Pull Up',
          //         date: DateTime.now()),
          //     WorkoutSessionExerciseReps(
          //         exerciseName: 'Pike Pull Through',
          //         repData: [3, 3, 3, 3, 2],
          //         workoutName: 'Planche / Front Lever',
          //         date: DateTime.now()),
          //     WorkoutSessionExerciseReps(
          //         exerciseName: 'Lever Pull Negatives',
          //         repData: [2, 2, 2, 2, 1],
          //         workoutName: 'Planche / Front Lever',
          //         date: DateTime.now()),
          //     WorkoutSessionExerciseReps(
          //         exerciseName: 'Pseudo Plance Push up',
          //         repData: [6, 6, 6, 6, 5],
          //         workoutName: 'Planche / Front Lever',
          //         date: DateTime.now()),
          //     WorkoutSessionExerciseReps(
          //         exerciseName: 'Arc Row',
          //         repData: [8, 8, 8, 8],
          //         workoutName: 'Planche / Front Lever',
          //         date: DateTime.now()),
          //     WorkoutSessionExerciseReps(
          //         exerciseName: 'Ring Dips',
          //         repData: [4, 4, 3, 2],
          //         workoutName: 'Planche / Front Lever',
          //         date: DateTime.now()),
          //     WorkoutSessionExerciseReps(
          //         exerciseName: 'Straight Arm Band Pull Down',
          //         repData: [50, 50],
          //         workoutName: 'Planche / Front Lever',
          //         date: DateTime.now()),
          //   ],
          // ),
        ]);

  Future<void> loadWorkoutSessionData() async {
    final db = await _getDatabase();
    final data = await db.query('workout_session_data');

    final workoutSessionData = data
        .map((dbRow) => WorkoutSessionData.fromJson(dbRow)

            // WorkoutSessionData(
            //     id: dbRow['id'] as String,
            //     workoutName: dbRow['workoutName'] as String,
            //     repSessionData: jsonDecode(dbRow['repSessionData'] as String),
            //     date: DateTime.parse(dbRow['date'] as String)),
            )
        .toList();

    state = workoutSessionData;
  }

  void addWorkoutSessionData(WorkoutSessionData workoutSessionData) async {
    final String repSessionDataJson =
        jsonEncode(workoutSessionData.repSessionData);

    final String dateIso8601 = workoutSessionData.date.toIso8601String();

    final db = await _getDatabase();
    db.insert('workout_session_data', {
      'id': workoutSessionData.id,
      'workoutName': workoutSessionData.workoutName,
      'repSessionData': repSessionDataJson,
      'date': dateIso8601,
    });

    state = [...state, workoutSessionData];
  }

  // void printWorkoutSessionData() {
  //   if (state.isNotEmpty) {
  //     for (var element in state) {
  //       print(element.workoutName);
  //       print(element.formattedDate);
  //       if (element.repSessionData.isNotEmpty) {
  //         print(element.repSessionData[0].exerciseName);
  //         print(element.repSessionData[1].exerciseName);
  //         print(element.repSessionData[2].exerciseName);
  //       }
  //     }
  //   }
  // }
}

final workoutSessionsDataProvider =
    StateNotifierProvider<WorkoutSessionDataNotifier, List<WorkoutSessionData>>(
        (ref) {
  return WorkoutSessionDataNotifier();
});
