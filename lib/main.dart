import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'DataModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Http post request!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future submitData(String name, String job) async {
  var response = await http.post(
    Uri.https('reqres.in', '/api/users'),
    body: {'name': name, 'job': job},
  );
  var data = response.body;
  print(data);

  if (response.statusCode == 201) {
    String responseString = response.body;
    return dataModelFromJson(responseString);
  } else {
    print(response.statusCode);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  late DataModel _dataModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your name',
                ),
                controller: nameController,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your job title',
                ),
                controller: jobController,
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  String name = nameController.text;
                  String job = jobController.text;

                  DataModel data = await submitData(name, job);
                  _dataModel = data;
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
