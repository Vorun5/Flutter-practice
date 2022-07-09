import 'package:decimal/decimal.dart';
import 'package:decimal/intl.dart';
import 'package:intl/intl.dart';

extension DecimalExtension on Decimal {
  String formatWith(NumberFormat formatter) =>
      formatter.format(DecimalIntl(this));
}
