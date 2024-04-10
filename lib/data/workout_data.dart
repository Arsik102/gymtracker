import 'package:flutter/material.dart';
import 'package:gym_tracker1_0/data/database.dart';
import 'package:gym_tracker1_0/models/exercise.dart';
import 'package:gym_tracker1_0/models/workout.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDatabase();
  /*

  Workout Data Structure

  - This overall list contains the different workouts
  - Each workout has a name, and list of exercises  

  */

  List<Workout> workoutList = [
    // default workout
    Workout(
      name: 'Грудные',
      exercises: [
        Exercise(
            name: 'Жим лёжа',
            weight: '70',
            reps: '10',
            sets: '3',
            isCompleted: true),
      ],
    ),
    Workout(
      name: 'Спина',
      exercises: [
        Exercise(
            name: 'Становая тяга',
            weight: '100',
            reps: '12',
            sets: '3',
            isCompleted: true),
      ],
    ),
  ];
  // if there are workouts already in database, then get that workout list
  void initalizeWorkoutList() {
    if (db.previousDataExists()) {
      workoutList = db.readFromDatabase();
    }
    // use default workouts
    else {
      db.saveToDatabase(workoutList);
    }
  }

  // get the list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  // get length of a given workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    return relevantWorkout.exercises.length;
  }

  //здесь поменял
  // add a workout
  void addWorkout(String name) {
    // add a new workout with a blank list of exercises
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();
    // save to database
    db.saveToDatabase(workoutList);
  }

  // add an exercise to a workout
  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    // find the relevant workout
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(
      Exercise(
        name: exerciseName,
        weight: weight,
        reps: reps,
        sets: sets,
      ),
    );
    notifyListeners();
    // save to database
    db.saveToDatabase(workoutList);
  }

  // check off exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    // find relevant exercise in that workout
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    // check off boolean to show user completed the exercise
    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();
    // save to database
    db.saveToDatabase(workoutList);
  }

  // return relevant workout object, given a workout name
  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);
    return relevantWorkout;
  }

  // return relevant exercise object, given a workout name + exercise name
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    // find relevant workout first
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    // then find the relevant exercise in that workout
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);

    return relevantExercise;
  }
}
