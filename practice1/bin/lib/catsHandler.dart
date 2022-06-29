import 'dart:io';
import 'cat.dart';

class CatsHandler {
  final List<Cat> _cats = [];

  List<Cat> get cats => _cats;

  void help() {
    print('''Commands:
  -help 
  -exit 
  -add
  -delete 
  -clear  
  -show
  -sort
  -feed''');
  }

  void commandHandler() {
    print("Let's play with cats :)");
    help();
    String command = "";
    print("Enter command: ");

    while (command != "exit") {
      command = stdin.readLineSync() ?? "";
      command = command.trim().toLowerCase();

      switch (command) {

        case "exit":
          return;

        case "help":
          help();
          break;

        case "feed":
          if (_cats.isEmpty) {
            print("No cats :(");
            break;
          }
          var name = readString("Enter the name of the cat you want to feed: ");
          if (!feedCatsByName(name)) {
            print("There is no cats by that name");
          }
          break;

        case "add":
          var name = readString("Enter the name of cat: ");
          var breed = readString("Enter the breed of cat: ");
          var color = readString("Enter the color of cat: ");
          var age = readInt("Enter the date of brith of cat: ");
          while (age < 0) {
            print("Enter the position number!");
            age = readInt("Enter the age of cat (how many years): ");
          }
          _cats.add(Cat(name, breed, color, age));
          print("Cat $name added");
          break;

        case "show":
          if (_cats.isEmpty) {
            print("No cats :(");
            break;
          }
          show();
          break;

        case "delete":
          if (_cats.isEmpty) {
            print("No cats :(");
            break;
          }
          var name =
              readString("Enter the name of the cat you want to delete: ");
          if (deleteCatByName(name)) {
            print("Cat $name deleted");
          } else {
            print("There is no cat named $name");
          }
          break;

        case "clear":
          clear();
          print("All cats deleted");
          break;

        case "sort":
          if (_cats.isEmpty) {
            print("No cats :(");
            break;
          }
          sortCatsByAge();
          print("Cats are sorted by age");
          break;

        default:
          print("Unknown command");

      }
    }
  }

  String readString(String command) {
    String str = "";
    while (str == "") {
      print(command);
      str = stdin.readLineSync() ?? "";
    }
    return str;
  }

  int readInt(String command) {
    String? str;
    dynamic i;
    while (str == null) {
      print(command);

      str = stdin.readLineSync();
      if (str != null) {
        i = int.tryParse(str);
        if (i != null) {
          return i;
        }
      }
    }
    return i;
  }

  // Adds a new cat
  void addCat(Cat cat) {
    _cats.add(cat);
  }

  // Delete first cat with that name
  // Returns true if deleted and false if not
  bool deleteCatByName(String name) {
    for (int i = 0; i < _cats.length; i++) {
      if (_cats[i].name == name) {
        _cats.removeAt(i);
        return true;
      }
    }
    return false;
  }

  // Delete all cats
  void clear() {
    _cats.clear();
  }

  // Feed all the cats with that name
  bool feedCatsByName(String name) {
    bool find = false;
    for (int i = 0; i < _cats.length; i++) {
      if (_cats[i].name == name) {
        _cats[i].toFeed();
        find = true;
      }
    }
    return find;
  }

  void sortCatsByAge() {
    _cats.sort((a, b) => a.age.compareTo(b.age));
  }

  // Show all cats
  void show() {
    for (var cat in _cats) {
      cat.show();
    }
  }

}
