class Month {
  final List<String> _days;
  final String _name;

  get name => _name;

  get days => _days;

  Month(this._days, this._name);
}

class Year {
  static final _monthsName = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final _months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  static final _daysOfTheWeek = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  final int _year;
  static const _minYear = 2022;
  get minYear => _minYear;
  Year(this._year) {
    if (_year % 4 == 0) {
      _months[1] = 29;
    }
  }

  List<Month> getMonths() {
    List<Month> months = [];
    if (_year < _minYear) {
      throw ArgumentError("As of $_minYear");
    }
    if (_year % 4 == 0) {}
    var weekday = (_year - _minYear) % 7;
    for (var i = 0; i < _months.length; i++) {
      List<String> days = [];
      for (int i = 0; i < _months[i]; i++) {
        days.add(_daysOfTheWeek[weekday]);
        weekday = (weekday + 1) % 7;
      }
      months.add(Month(days, _monthsName[i]));
    }
    return months;
  }
}
