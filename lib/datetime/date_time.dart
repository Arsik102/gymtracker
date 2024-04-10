// return todays date
String todaysDateDDMMYYYY() {
  // today
  var dateTimeObject = DateTime.now();

  // year in the format yyyy
  String year = dateTimeObject.year.toString();

  // month in the format mm
  String month = dateTimeObject.year.toString();
  if (month.length == 1) {
    month = '0$month';
  }
  // day in the format dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }
  // final format
  String ddmmyyyy = day + month + year;

  return ddmmyyyy;
}

// convert string to DateTime object
DateTime createDataTimeObject(String ddmmyyyy) {
  int dd = int.parse(ddmmyyyy.substring(0, 2));
  int mm = int.parse(ddmmyyyy.substring(2, 4));
  int yyyy = int.parse(ddmmyyyy.substring(4, 8));

  DateTime dateTimeObject = DateTime(dd, mm, yyyy);
  return dateTimeObject;
}

// convert DateTime object to string
String convertDateTimeToDDMMYYYY(DateTime dateTime) {
  // year in the format yyyy
  String year = dateTime.year.toString();

  // month in the format mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // day in the format dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // final format
  String ddmmyyyy = day + month + year;

  return ddmmyyyy;
}
