import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.EEEE().add_yMMMMd();
// DateFormat.yMd();
const uuid = Uuid();

class Exercise {
  const Exercise({
    required this.name,
    required this.sets,
    required this.lowerReps,
    required this.upperReps,
    required this.rest,
    required this.tempo,
    required this.category,
    required this.color,
    required this.inWorkoutSession,
  });

  final String name;
  final int sets;
  final String lowerReps;
  final String upperReps;
  final int rest;
  final String tempo;
  final String category;
  final Color color;
  final List<String> inWorkoutSession;

  factory Exercise.fromJson(dynamic json) {
    return Exercise(
      name: json['name'] as String,
      sets: json['sets'] as int,
      lowerReps: json['lowerReps'] as String,
      upperReps: json['upperReps'] as String,
      rest: json['rest'] as int,
      tempo: json['tempo'] as String,
      category: json['category'] as String,
      color: Color(json['color']),
      inWorkoutSession: List.from(json['inWorkoutSession']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'sets': sets,
        'lowerReps': lowerReps,
        'upperReps': upperReps,
        'rest': rest,
        'tempo': tempo,
        'category': category,
        'color': color.value,
        'inWorkoutSession': inWorkoutSession,
      };
}

class WorkoutSession {
  const WorkoutSession({
    required this.id,
    required this.name,
    required this.exercisesList,
  });

  final String id;
  final String name;
  final List<Exercise> exercisesList;

  factory WorkoutSession.fromJson(dynamic json) {
    var exercisesListObjsJson = json['exercisesList'] as List;

    List<Exercise> exrcsList =
        exercisesListObjsJson.map((json) => Exercise.fromJson(json)).toList();

    return WorkoutSession(
      id: json['id'] as String,
      name: json['name'] as String,
      exercisesList: exrcsList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> exercisesList =
        this.exercisesList.map((exercise) => exercise.toJson()).toList();

    return {
      'id': id,
      'name': name,
      'exercisesList': exercisesList,
    };
  }
}

class WorkoutSessionExerciseReps {
  WorkoutSessionExerciseReps({
    required this.exerciseName,
    required this.repData,
    required this.workoutName,
    required this.date,
    String? id,
  }) : id = id ?? uuid.v4();

  final String exerciseName;
  final List<int> repData;
  final String workoutName;
  final DateTime date;
  final String id;

  // WorkoutSessionExerciseReps.fromJson(Map<String, dynamic> json)
  //     : exerciseName = json['exerciseName'] as String,
  //       repData = json['repData'] as List<int>,
  //       workoutName = json['workoutName'] as String,
  //       date = json['date'] as DateTime,
  //       ç

  factory WorkoutSessionExerciseReps.fromJson(dynamic json) {
    return WorkoutSessionExerciseReps(
        exerciseName: json['exerciseName'] as String,
        repData: List.from(json['repData']),
        workoutName: json['workoutName'] as String,
        date: DateTime.parse(json['date']),
        id: json['id'] as String);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'exerciseName': exerciseName,
        'repData': repData,
        'workoutName': workoutName,
        'date': date.toIso8601String(),
      };
}

class WorkoutSessionData {
  WorkoutSessionData({
    required this.workoutName,
    required this.repSessionData,
    required this.date,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String workoutName;
  final List<WorkoutSessionExerciseReps> repSessionData;
  final DateTime date;

  // WorkoutSessionData.fromJson(Map<String, dynamic> json)
  //     : id = json['id'] as String,
  //       workoutName = json['workoutName'] as String,
  //       repSessionData = json['repSessionData'] as dynamic,
  //       date = json['date'] as DateTime;

  factory WorkoutSessionData.fromJson(dynamic json) {
    var repSessionDataObjsJson = jsonDecode(json['repSessionData']) as List;

    List<WorkoutSessionExerciseReps> repSessionData = repSessionDataObjsJson
        .map((json) => WorkoutSessionExerciseReps.fromJson(json))
        .toList();

    return WorkoutSessionData(
      id: json['id'] as String,
      workoutName: json['workoutName'] as String,
      repSessionData: repSessionData,
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> repSessionData =
        this.repSessionData.map((i) => i.toJson()).toList();

    return {
      'id': id,
      'workoutName': workoutName,
      'repSessionData': jsonEncode(repSessionData),
      'date': date.toIso8601String(),
    };
  }

  // final Map<String, List<int>> repSessionData;

  String get formattedDate {
    return formatter.format(date);
  }
}
