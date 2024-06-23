import 'package:flutter/material.dart';

class NextBackRepButtons extends StatefulWidget {
  const NextBackRepButtons({super.key});

  @override
  State<NextBackRepButtons> createState() => _NextBackRepButtonsState();
}

class _NextBackRepButtonsState extends State<NextBackRepButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
            iconAlignment: IconAlignment.start,
            onPressed: () {
              FocusScope.of(context).previousFocus();
            },
            style: TextButton.styleFrom(
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.only(right: 15)),
            icon: const Icon(Icons.arrow_back_ios_new),
            label: const Text('Back')),
        TextButton.icon(
            iconAlignment: IconAlignment.end,
            onPressed: () {
              FocusScope.of(context).nextFocus();
            },
            style: TextButton.styleFrom(
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.only(left: 15)),
            icon: const Icon(Icons.arrow_forward_ios),
            label: const Text('Next')),
      ],
    );
  }
}
