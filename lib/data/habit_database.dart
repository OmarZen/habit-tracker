// reference our box
import 'package:habit_tracker_hive/datetime/date_time.dart';
import 'package:hive/hive.dart';

final _myBox = Hive.box('Habit_Database');

class HabitDatabase {
  List todayHabitsList = [];
  Map<DateTime, int> heatMapDataSet = {};

  // create initial default data
  void createDefaultData() {
    todayHabitsList = [
      ['Drink water', false],
      ['Exercise', false],
      ['Read', false],
    ];
    _myBox.put('START_DATE', todaysDateFormatted());
  }

  // load data if it is already existing
  void loadDate() {
    // if it is a new date, get habit list from the database
    if (_myBox.get(todaysDateFormatted()) == null) {
      todayHabitsList = _myBox.get('CURRENT_HABIT_LIST');
      // set all habits completed to false since it is a new day
      for (int i = 0; i < todayHabitsList.length; i++) {
        todayHabitsList[i][1] = false;
      }
    }
    // if it is not a new date, then load today's list
    else {
      todayHabitsList = _myBox.get(todaysDateFormatted());
    }
  }

  void updateDatebase() {
    // update today's entry
    _myBox.put(todaysDateFormatted(), todayHabitsList);

    //update universal habit list
    _myBox.put('CURRENT_HABIT_LIST', todayHabitsList);

    // calculate habit percentage for each day
    calculateHabitPercentage();

    // load Heat map
    loadHateMap();
  }

  void calculateHabitPercentage() {
    int countCompleted = 0;
    for (int i = 0; i < todayHabitsList.length; i++) {
      if (todayHabitsList[i][1] == true) {
        countCompleted++;
      }
    }

    // calculate percentage
    String percentage = todayHabitsList.isEmpty
        ? '0.0'
        : ((countCompleted / todayHabitsList.length)).toStringAsFixed(1);

    // save the percentage
    _myBox.put('PERCENTAGE_SUMMARY_${todaysDateFormatted()}', percentage);
  }

  void loadHateMap() {
    DateTime startDate = createDateTimeObject(_myBox.get('START_DATE'));

    // count the number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // load the data
    for (int i = 0; i <= daysInBetween; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(
          Duration(days: i),
        ),
      );

      double strengthAsPercentage =
          double.parse(_myBox.get('PERCENTAGE_SUMMARY_$yyyymmdd') ?? '0.0');

      // split the date
      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;

      final percentageForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercentage).toInt()
      };

      heatMapDataSet.addEntries(percentageForEachDay.entries);
      print(heatMapDataSet);
    }
  }
}
