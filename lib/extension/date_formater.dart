import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String toSunda() {
    var formatter = DateFormat("dd/MM/yyyy");
    return formatter.format(this);
  }
}
