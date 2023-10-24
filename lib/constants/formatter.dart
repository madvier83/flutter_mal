import 'package:intl/intl.dart';

class Formatter {
  String date(DateTime date) {
    return DateFormat("dd MMM yyyy").format(date).toString();
  }

  String formatTime(double timeInSeconds) {
    int minutes = timeInSeconds ~/ 60;
    int seconds = (timeInSeconds % 60).toInt();
    return '$minutes:$seconds';
  }
}
