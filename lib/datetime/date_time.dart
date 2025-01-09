// return todays date in the format of yyyy-mm-dd
String todaysDateFormatted() {
  // today's date
  var dateTimeObject = DateTime.now();

  // year in format of yyyy
  String year = dateTimeObject.year.toString();

  // month in format of mm
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // day in format of dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // final format
  String yyyymmdd = year + month + day;
  return yyyymmdd;
}

// convert yyyymmdd to datetime object
DateTime createDateTimeObject(String yyyymmdd) {
  // year
  int year = int.parse(yyyymmdd.substring(0, 4));

  // month
  int month = int.parse(yyyymmdd.substring(4, 6));

  // day
  int day = int.parse(yyyymmdd.substring(6, 8));

  DateTime dateTimeObject = DateTime(year, month, day);
  return dateTimeObject;
}

// convert datetime object to yyyymmdd
String convertDateTimeToString(DateTime dateTimeObject) {
  // year in format of yyyy
  String year = dateTimeObject.year.toString();

  // month in format of mm
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // day in format of dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // final format
  String yyyymmdd = year + month + day;
  return yyyymmdd;
}
