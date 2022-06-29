
class Cat {
  final String _name;
  final String _breed;
  final String _color;
  final int _age;
  Cat(this._name, this._breed, this._color, this._age);
  String get name => _name;
  String get breed => _breed;
  String get color => _color;
  int get age => _age;

  void show() {
    print("Name: $_name | Breed: $_breed | Color: $_color $_age years");
  }

  void toFeed() {
    print("$_name the cat happy. He been fed");
  }
}
