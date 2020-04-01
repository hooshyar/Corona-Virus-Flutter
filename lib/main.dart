import 'package:corona_virus_map/src/data_provider/corona_data.dart';
import 'package:corona_virus_map/src/screens/special_page.dart';
import 'package:corona_virus_map/src/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CoronaProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter corona virus map',
      theme: ThemeData(
        primarySwatch: mainColor,
      ),
      home: SpecialPage(),
    );
  }
}
