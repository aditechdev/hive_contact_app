import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_contact_app/contact_page.dart';
import 'package:hive_contact_app/model/contact.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocument = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocument.path);
  Hive.registerAdapter(ContactAdapter());
  runApp(const MyApp());

  // await Hive.openBox("contact");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: Hive.openBox("contact"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const ContactPage();
              }
            } else {
              return const Scaffold();
            }
          }),
    );
  }
}
