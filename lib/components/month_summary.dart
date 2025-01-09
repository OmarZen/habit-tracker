import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker_hive/datetime/date_time.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class MonthSummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthSummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 25,
        bottom: 25,
      ),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(const Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[200]!,
        textColor: Provider.of<ThemeProvider>(context).isDark
            ? Colors.black
            : Theme.of(context).colorScheme.inversePrimary,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: Provider.of<ThemeProvider>(context).isDark
            ? const {
                1: Color.fromARGB(20, 0, 0, 0),
                2: Color.fromARGB(40, 0, 0, 0),
                3: Color.fromARGB(60, 0, 0, 0),
                4: Color.fromARGB(80, 0, 0, 0),
                5: Color.fromARGB(100, 0, 0, 0),
                6: Color.fromARGB(120, 0, 0, 0),
                7: Color.fromARGB(140, 0, 0, 0),
                8: Color.fromARGB(160, 0, 0, 0),
              }
            : const {
                1: Color.fromARGB(20, 2, 111, 179),
                2: Color.fromARGB(40, 2, 111, 179),
                3: Color.fromARGB(60, 2, 111, 179),
                4: Color.fromARGB(80, 2, 111, 179),
                5: Color.fromARGB(100, 2, 111, 179),
                6: Color.fromARGB(120, 2, 111, 179),
                7: Color.fromARGB(140, 2, 111, 179),
                8: Color.fromARGB(160, 2, 111, 179),
              },
      ),
    );
  }
}
