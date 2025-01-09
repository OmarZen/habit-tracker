import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class HabitTitle extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingTapped;
  final Function(BuildContext)? deleteTapped;

  const HabitTitle({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.settingTapped,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            // settings action
            SlidableAction(
              onPressed: settingTapped,
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(12),
              spacing: 16,
              foregroundColor: Provider.of<ThemeProvider>(context).isDark
                  ? Theme.of(context).colorScheme.inversePrimary
                  : Theme.of(context).colorScheme.inversePrimary,
              autoClose: true,
            ),
            // delete action
            SlidableAction(
              onPressed: deleteTapped,
              backgroundColor: Colors.red.shade400,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
              spacing: 16,
              foregroundColor: Provider.of<ThemeProvider>(context).isDark
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
              autoClose: true,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDark
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Checkbox(
                value: habitCompleted,
                onChanged: onChanged,
              ),
              Text(
                habitName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_back_outlined,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
