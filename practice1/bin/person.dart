import 'dart:io';

class Person {
  Person(this._name, this._age)

  final String _name;
  int _age;
  int get age => _age;
  set age(int value) => _age = value;

void walk (String targetAddress) {
  print("$_name is going to $targetAddress")
}

}