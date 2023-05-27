import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Translator App",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TranslatorApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TranslatorApp extends StatefulWidget {
  @override
  _TranslatorAppState createState() => _TranslatorAppState();
}

class _TranslatorAppState extends State<TranslatorApp> {
  final _formKey = GlobalKey<FormState>();
  String sourceLanguage = "en";
  String targetLanguage = "fa"; //
  String sourceText = "";
  String translatedText = "";

  void _translateText() async {
    String apiUrl =
        "https://translate.googleapis.com/translate_a/single?client=gtx&sl=$sourceLanguage&tl=$targetLanguage&dt=t&q=${Uri.encodeQueryComponent(sourceText)}";
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      setState(() {
        translatedText = decodedData[0][0][0];
      });
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Translator")),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "Enter text to translate"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter some text";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      sourceText = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: sourceLanguage,
                  items: <String>['en', 'fa'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      sourceLanguage = newValue!;
                    });
                  },
                  decoration: InputDecoration(labelText: "Source Language"),
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: targetLanguage,
                  items: <String>[
                    'fa',
                    'en',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      targetLanguage = newValue!;
                    });
                  },
                  decoration: InputDecoration(labelText: "Target Language"),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _translateText();
                    }
                  },
                  child: Text("Translate"),
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(translatedText),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
