import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _number = TextEditingController();
  final TextEditingController _string = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: _number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "number"),
                      validator: (value) {
                        if (value!.isEmpty) return "Please, fill data";
                        if (!RegExp(r"^\d+$").hasMatch(value)) {
                          return 'We accept only numbers from 0-9';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: _string,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "string"),
                      validator: (value) {
                        if (value!.isEmpty) return "Please, fill data";
                        if (value.length < 3) {
                          return "Please enter at least 3 characters for your string";
                        }
                        if (!RegExp(r"^[A-Za-z]+$").hasMatch(value)) {
                          return "Please provide only characters from A-Z ";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "email"),
                      validator: (value) {
                        if (value!.isEmpty) return "Please, fill data";
                        if (!RegExp(r"^\S+@\S+\.\S+$").hasMatch(value)) {
                          return "Please provide valid email";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
