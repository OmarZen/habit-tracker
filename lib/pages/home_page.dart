import 'package:flutter/material.dart';
import 'package:habit_tracker_hive/components/month_summary.dart';
import 'package:habit_tracker_hive/components/my_fab.dart';
import 'package:habit_tracker_hive/data/habit_database.dart';
import 'package:habit_tracker_hive/theme/theme_provider.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../components/habit_title.dart';
import '../components/my_alert_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box('Habit_Database');

  @override
  void initState() {
    // if there is no current habit list, then it is 1st time opening the app
    // then create default data
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    }

    // there already exists a habit list
    // so load the data
    else {
      db.loadDate();
    }

    db.updateDatebase();
    super.initState();
  }

  // bool to control the checkbox
  bool habitCompleted = false;

  // checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todayHabitsList[index][1] = value!;
    });
    db.updateDatebase();
  }

  // create a new habit
  final _newHabitNameController = TextEditingController();

  void saveNewHabit() {
    if (_newHabitNameController.text.isNotEmpty) {
      setState(() {
        db.todayHabitsList.add([_newHabitNameController.text, false]);
        db.updateDatebase();
      });
      _newHabitNameController.clear();
      Navigator.of(context).pop();
      db.updateDatebase();
    } else {
      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a habit name'),
        ),
      );
    }
  }

  void cancelDialogBox() {
    _newHabitNameController.clear();
    Navigator.of(context).pop();
    db.updateDatebase();
  }

  void createNewHabit() {
    // show alert dialog to create a new habit
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: 'Enter habit name',
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
    db.updateDatebase();
  }

  // open habit settings
  void openHabitSettings(int index) {
    // show alert dialog to edit habit
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: db.todayHabitsList[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
    db.updateDatebase();
  }

  // save existing habit
  void saveExistingHabit(int index) {
    setState(() {
      db.todayHabitsList[index][0] = _newHabitNameController.text;
      db.updateDatebase();
    });
    _newHabitNameController.clear();
    Navigator.of(context).pop();
    db.updateDatebase();
  }

  // delete habit
  void deleteHabit(int index) {
    setState(() {
      db.todayHabitsList.removeAt(index);
    });
    db.updateDatebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Habit Tracker Theme',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Switch(
                value: Provider.of<ThemeProvider>(context).isDark,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleThemeMode();
                },
              ),
            ),
            Text(
              Provider.of<ThemeProvider>(context).isDark
                  ? 'Dark Mode'
                  : 'Light Mode',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: MyFloatingActionButton(
        onPressed: createNewHabit,
      ),
      backgroundColor: Colors.grey[300],
      body: ListView(
        children: [
          // monthly summary heat map
          MonthSummary(
            datasets: db.heatMapDataSet,
            startDate: _myBox.get("START_DATE"),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.todayHabitsList.length,
            itemBuilder: (context, index) {
              return HabitTitle(
                habitName: db.todayHabitsList[index][0],
                habitCompleted: db.todayHabitsList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
                settingTapped: (context) => openHabitSettings(index),
                deleteTapped: (context) => deleteHabit(index),
              );
            },
          ),
        ],
      ),
    );
  }
}
