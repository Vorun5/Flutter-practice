import 'dart:io';

// Список person
// Усложнить
void help() {
  print('''Comands:
  -help 
  -exit 
  -add
  -delete 
  -clear 
  -replace 
  -show''');
}

void listHandler(List<String> list) {
  help();
  String comand = "";
  while (comand != "exit") {
    print("Enter comand");
    comand = stdin.readLineSync() ?? "";
    comand = comand.trim().toLowerCase();
    switch (comand) {
      case "exit":
        return;

      case "help":
        help();
        break;

      case "add":
        print("Enter values to add: ");
        var value = stdin.readLineSync() ?? "";
        if (value != "") {
          list.add(value);
        }
        break;

      case "delete":
        print("Enter value to be deleted: ");
        var value = stdin.readLineSync() ?? "";
        if (value != "") {
          list.remove(value);
        }
        break;

      case "clear":
        list.clear();
        break;

      case "show":
        print(list);
        break;

      case "replace":
        print("Enter the value you want to replace: ");
        var replaceValue = stdin.readLineSync() ?? "";

      while (replaceValue == "") {
        print("Enter the value you want to replace: ");
        replaceValue = stdin.readLineSync() ?? "";
      }

      

        if (replaceValue == "") {
          print("Empty ")
        }

        if (list.contains(replaceValue)) {}
        break;
      default:
        print("Unknown comand");
    }
  }
}

void main(List<String> arguments) {
  List<String> list = [];
  listHandler(list);
}

String getHelloMessage(String name) {
  return 'Hello, $name!';
}
