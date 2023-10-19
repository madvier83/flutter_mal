import 'package:intl/intl.dart';

class Formatter {
  String date(DateTime date) {
    return DateFormat("dd MMM yyyy").format(date).toString();
  }
}