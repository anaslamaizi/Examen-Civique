import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    super.key,
    required this.label,
    required this.text,
    required this.onTap,
    required this.selected,
    this.state,
    this.statusLabel,
  });

  final String label;
  final String text;
  final VoidCallback onTap;
  final bool selected;
  final bool? state;
  final String? statusLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    Color border = Colors.transparent;
    Color background = Colors.white;
    IconData? trailingIcon;
    Color? trailingColor;

    if (state != null) {
      border = state! ? Colors.green : Colors.red;
      background = state!
          ? const Color(0xFFF0FDF4)
          : selected
              ? const Color(0xFFFEF2F2)
              : Colors.white;
      trailingIcon = state! ? Icons.check_circle_rounded : Icons.cancel_rounded;
      trailingColor = border;
    } else if (selected) {
      border = scheme.primary;
      background = const Color(0xFFF8FAFF);
      trailingIcon = Icons.radio_button_checked_rounded;
      trailingColor = scheme.primary;
    }

    return Card(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: border, width: 2),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(child: Text(label)),
        title: Text(text),
        subtitle: statusLabel == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  statusLabel!,
                  style: TextStyle(
                    color: trailingColor ?? const Color(0xFF475569),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
        trailing: trailingIcon == null
            ? null
            : Icon(trailingIcon, color: trailingColor),
      ),
    );
  }
}
