
class Cat {
  final String _name;
  final String _breed;
  final String _color;
  final DateTime _dateOfBrith;
  Cat(this._name, this._breed, this._color, this._dateOfBrith);
  String get name => _name;
  String get breed => _breed;
  String get color => _color;
  DateTime get dateOfBrith => _dateOfBrith;
  void toComb() {
    print("The cat is happy to be petted");
  }
  void toFeed() {
    print("The cat happy. He been fed");
  }
}
