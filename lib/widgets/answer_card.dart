import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    super.key,
    required this.label,
    required this.text,
    required this.onTap,
    required this.selected,
    this.state,
  });

  final String label;
  final String text;
  final VoidCallback onTap;
  final bool selected;
  final bool? state;

  @override
  Widget build(BuildContext context) {
    Color border = Colors.transparent;
    if (state != null) {
      border = state! ? Colors.green : Colors.red;
    } else if (selected) {
      border = Theme.of(context).colorScheme.primary;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: border, width: 2),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(child: Text(label)),
        title: Text(text),
      ),
    );
  }
}
