import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'Person.dart';

Future<Person> startCompute() async {
  Person person = Person("ABCD");

  return await compute(fetchPerson, person);
}

Future<Person> fetchPerson(Person person) async {
  Person userData = await Future.delayed(
    Duration(seconds: 3),
    () {
      return Person("Shivam ${person.name}");
    },
  );
  return userData;
}

void computeFactorial(List<dynamic> arguments) async {
  int factorial(int n) => (n == 0) ? 1 : n * factorial(n - 1);
  final result = factorial(10);
//  SendPort? sendPort = IsolateNameServer.lookupPortByName('main');
  SendPort sendPort = arguments[0];
  await Future.delayed(Duration(seconds: 8));
  sendPort.send(result);
}
