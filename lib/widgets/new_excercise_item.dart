import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/models/exercise_model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'dart:core';

import 'package:training_app/provider/exercise_reps_data_provider.dart';

class NewExcerciseItem extends ConsumerStatefulWidget {
  const NewExcerciseItem({
    super.key,
    required this.exercise,
    required this.sets,
    required this.selectedWorkout,
  });

  final Exercise exercise;
  final int sets;
  final WorkoutSession selectedWorkout;

  @override
  ConsumerState<NewExcerciseItem> createState() => _ExcerciseItemState();
}

class _ExcerciseItemState extends ConsumerState<NewExcerciseItem> {
  List<TextEditingController> textControllerList = [];
  List<GlobalKey> keyList = [];
  List<FocusNode> focusNodeList = [];
  int sum = 0;

  @override
  void dispose() {
    for (TextEditingController controller in textControllerList) {
      controller.dispose();
    }
    for (FocusNode focusNode in focusNodeList) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exerciseRepsDataNotifier = ref.read(exercisesRepsProvider.notifier);

    List<int> enteredReps = [];

    final exerciseSessionReps = WorkoutSessionExerciseReps(
      exerciseName: widget.exercise.name,
      repData: enteredReps,
      workoutName: widget.selectedWorkout.name,
      date: DateTime.now(),
    );

    // void saveExerciseReps() {
    //   for (var textController in textControllerList) {
    //     if (textController.text.isEmpty) {
    //       return;
    //     }
    //     int rep = int.parse(textController.text);
    //     enteredReps.add(rep);
    //   }
    //   exerciseRepsDataNotifier.addExerciseRepsData(exerciseSessionReps);
    // }

    // void validateEmptyReps() {
    //   bool isEmpty = textControllerList.every((e) => e.text == "");
    //   // print(isEmpty);

    //   if (isEmpty) {
    //     ScaffoldMessenger.of(context).clearSnackBars();
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content: Text('Enter at least one rep',
    //             textAlign: TextAlign.center,
    //             style: Theme.of(context)
    //                 .textTheme
    //                 .titleMedium!
    //                 .copyWith(color: Colors.black))));
    //   }
    // }

    void onChange(value) {
      for (var i = 0; i < widget.sets; i++) {
        if (textControllerList[i].text.isEmpty) {
          setState(() {
            int total =
                enteredReps.fold(0, (int acc, int number) => acc + number);
            sum = total;
          });
        } else {
          if (textControllerList[i].text != "") {
            int rep = int.parse(textControllerList[i].text);
            enteredReps.add(rep);
            setState(() {
              int total =
                  enteredReps.fold(0, (int acc, int number) => acc + number);
              sum = total;
            });
            exerciseRepsDataNotifier.addExerciseRepsData(exerciseSessionReps);
          }
        }
      }
    }

    // void nextKeyboardButton(key1) {
    //   showBottomSheet(
    //     context: context,
    //     builder: (ctx) => AddKeyboardButton(
    //       selectedKey: key1,
    //     ),
    //   );
    // }

    void onrequestFocus(FocusNode focusNode) {
      focusNode.requestFocus();
      Scrollable.ensureVisible(
        focusNode.context ?? context,
        alignment: 0.5,
        duration: const Duration(milliseconds: 700),
      );
    }

    final List<Widget> repsWidgets =
        List.generate(widget.exercise.sets, (index) {
      textControllerList.add(TextEditingController());
      keyList.add(GlobalKey<ConsumerState<ConsumerStatefulWidget>>());
      focusNodeList.add(FocusNode());
      String lowerReps = widget.exercise.lowerReps;

      // KeyboardActionsConfig _buildConfig(BuildContext context) {
      //   return KeyboardActionsConfig(
      //     keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      //     keyboardBarColor: Colors.grey[200],
      //     nextFocus: true,
      //     actions: [
      //       KeyboardActionsItem(
      //         focusNode: focusNodeList[index],
      //       ),
      //     ],
      //   );
      // }

      return Container(
        margin: const EdgeInsets.all(0.5),
        child: TextFormField(
          key: keyList[index],
          focusNode: focusNodeList[index],
          showCursor: false,
          onChanged: (value) {
            onChange(value);
            onrequestFocus(focusNodeList[index]);
          },
          onTap: () {
            // onrequestFocus(focusNodeList[index]);
            //ensureVisibleOnTextArea(textfieldKey: keyList[index]);
            // nextKeyboardButton(keyList[index]);
          },
          onEditingComplete: () {
            onrequestFocus(focusNodeList[index + 1]);
          },
          validator: (value) {
            if (value == null || value.isEmpty || int.tryParse(value) == null) {
              return 'Enter your reps';
            }
            return null;
          },
          controller: textControllerList[index],
          style: const TextStyle(color: Colors.white),
          cursorHeight: 13,
          textAlign: TextAlign.center,
          // textAlignVertical: TextAlignVertical.center,
          maxLength: 2,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: lowerReps,
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 155, 155, 155),
            ),
            contentPadding:
                const EdgeInsets.only(left: 2, right: 1, bottom: 1, top: 0),
            focusColor: Colors.green,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 141, 250, 145), width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            constraints: const BoxConstraints(
              maxHeight: 25,
              minHeight: 25,
              maxWidth: 25,
              minWidth: 25,
            ),
            isCollapsed: true,
            isDense: true,
            counterText: "",
          ),
        ),
      );
    });

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  textAlign: TextAlign.right,
                  softWrap: true,
                  widget.exercise.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(height: 1.1, color: widget.exercise.color),
                ),
                Text(
                  '${widget.exercise.sets.toString()}x${widget.exercise.lowerReps}-${widget.exercise.upperReps}, rest: ${widget.exercise.rest}s',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          ...repsWidgets,
          // IconButton(
          //   onPressed: () {
          //     for (var i = 0; i < widget.sets; i++) {
          //       if (textControllerList[i].text.isEmpty) {
          //         return;
          //       }
          //       if (i == widget.sets - 1) {
          //         int rep = int.parse(textControllerList[i].text);
          //         enteredReps.add(rep);
          //         // print(enteredReps);
          //         exerciseRepsDataNotifier
          //             .addExerciseRepsData(exerciseSessionReps);
          //         enteredReps = [];
          //       } else {
          //         int rep = int.parse(textControllerList[i].text);
          //         enteredReps.add(rep);
          //       }
          //     }
          //   },
          //   icon: const Icon(
          //     Icons.check_box_outlined,
          //     color: Colors.white,
          //   ),
          // ),
          Flexible(
            child: Container(),
          ),
          Container(
            margin: const EdgeInsets.only(right: 15),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(
                  color: const Color.fromARGB(255, 157, 229, 227),
                  width: 0.5,
                  strokeAlign: BorderSide.strokeAlignCenter),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(6),
            ),
            width: 33,
            height: 25,
            child: Text(
              sum.toString(),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
