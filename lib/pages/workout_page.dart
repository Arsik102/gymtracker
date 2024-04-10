import 'package:flutter/material.dart';
import 'package:gym_tracker1_0/components/exercise_tile.dart';
import 'package:gym_tracker1_0/data/workout_data.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;
  const WorkoutPage({super.key, required this.workoutName});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  // checkbox was tapped
  void onCheckboxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(workoutName, exerciseName);
  }

  // text controller
  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  final setsController = TextEditingController();

  // save workout
  void save() {
    // get exercise name from text controller
    String newExerciseName = exerciseNameController.text;
    String newWeight = weightController.text;
    String newReps = repsController.text;
    String newSets = setsController.text;
    // add exercise to workout
    Provider.of<WorkoutData>(context, listen: false).addExercise(
      widget.workoutName,
      newExerciseName,
      newWeight,
      newReps,
      newSets,
    );
    // close pop dialog box
    Navigator.pop(context);
    clear();
  }

  // cancel
  void cancel() {
    // close pop dialog box
    Navigator.pop(context);
    clear();
  }

  // clear controllers
  void clear() {
    exerciseNameController.clear();
    weightController.clear();
    repsController.clear();
    setsController.clear();
  }

  // create a new exercise
  void createNewExercise() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromRGBO(222, 222, 222, 1),
        title: const Text(
          'Новое упражнение',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // exercise name
            TextField(
              controller: exerciseNameController,
            ),
            // weight
            TextField(
              controller: weightController,
            ),
            // reps
            TextField(
              controller: repsController,
            ),
            // sets
            TextField(
              controller: setsController,
            ),
          ],
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: save,
            child: const Icon(
              Icons.check_sharp,
              size: 30,
            ),
          ),
          const SizedBox(width: 30),
          // cancel button
          MaterialButton(
            onPressed: cancel,
            child: const Icon(
              Icons.close_sharp,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: const Color.fromRGBO(222, 222, 222, 1),
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(222, 222, 222, 1),
            title: Text(
              widget.workoutName,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[800],
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: createNewExercise,
        ),
        body: ListView.builder(
          itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
          itemBuilder: (context, index) => ExerciseTile(
            exerciseName: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .name,
            weight: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .weight,
            reps: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .reps,
            sets: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .sets,
            isCompleted: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .isCompleted,
            onCheckboxChanged: (val) {
              onCheckboxChanged(
                widget.workoutName,
                value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .name,
              );
            },
          ),
        ),
      ),
    );
  }
}
