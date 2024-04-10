// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  void Function(bool?)? onCheckboxChanged;

  ExerciseTile({
    super.key,
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListTile(
        title: Text(
          exerciseName,
          style: TextStyle(
              fontSize: 23, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // weight
            Chip(
              label: Text(
                "${weight} кг",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            // reps
            Chip(
              label: Text(
                "$reps раз",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            // sets
            Chip(
              label: Text(
                "$sets сета",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          activeColor: Colors.green,
          value: isCompleted,
          onChanged: (value) => onCheckboxChanged!(value),
        ),
      ),
    );
  }
}
