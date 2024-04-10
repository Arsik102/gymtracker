import 'package:flutter/material.dart';
import 'package:gym_tracker1_0/data/workout_data.dart';
import 'package:gym_tracker1_0/pages/workout_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<WorkoutData>(context, listen: false).initalizeWorkoutList();
  }

  // text controller
  final newWorkoutNameController = TextEditingController();

  // create new workout
  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromRGBO(222, 222, 222, 1),
        title: const Text(
          'Новое упражнение',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
        ),
        content: TextField(
          controller: newWorkoutNameController,
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
          const SizedBox(
            width: 30,
          ),
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

  // go to workout_page
  void goToWorkoutPage(String workoutName) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutPage(
            workoutName: workoutName,
          ),
        ));
  }

  // save workout
  void save() {
    // get workout name from text controller
    String newWorkoutName = newWorkoutNameController.text;
    // add name of workout to workoutdata list
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);

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
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: const Color.fromRGBO(222, 222, 222, 1),
        appBar: AppBar(
          title: const Text(
            'Gym Tracker',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          backgroundColor: const Color.fromRGBO(222, 222, 222, 1),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[800],
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: createNewWorkout,
        ),
        body: ListView.builder(
          itemCount: value.getWorkoutList().length,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.all(15),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: ListTile(
              title: Text(
                value.getWorkoutList()[index].name,
                style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
                onPressed: () =>
                    goToWorkoutPage(value.getWorkoutList()[index].name),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
