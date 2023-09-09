import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:isolate_flutter/Utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isolate Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Isolate Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(onPressed: () {}, child: Text("Blank")),
            ElevatedButton(
                onPressed: () {
                  startCompute().then((value) {
                    print("startCompute ${value.name}");
                  });

                  print("MyHomePage  ");
                },
                child: Text("Start Compute")),
            ElevatedButton(
                onPressed: () {
                  final receivePort = ReceivePort();

                  final myIsolate = Isolate.spawn((message) {
                    print("spawn $message");
                    return computeFactorial(message);
                  }, [receivePort.sendPort, 10]);

                  receivePort.listen((message) {
                    print('Received: $message');
                  });
                },
                child: Text("Isolate")),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
