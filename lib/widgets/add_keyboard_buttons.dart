import 'package:flutter/material.dart';

class AddKeyboardButton extends StatefulWidget {
  const AddKeyboardButton({super.key});

  @override
  State<AddKeyboardButton> createState() => _AddKeyboardButtonState();
}

class _AddKeyboardButtonState extends State<AddKeyboardButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 20,
          ),
          OutlinedButton(
              onPressed: () {
                FocusScope.of(context).previousFocus();
              },
              child: const Text('Previous')),
          OutlinedButton(
              onPressed: () {
                FocusScope.of(context).nextFocus();
              },
              child: const Text('Next')),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
