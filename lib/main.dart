import 'package:flutter/material.dart';
import 'package:puntproj/states/introduction.dart';
import 'package:puntproj/states/show_today_cases.dart';
import 'package:puntproj/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/showTodayCases': (BuildContext context) => ShowTodayCases(),
  '/introduction':(BuildContext context)=>Introduction(),
};

String? firstState;

void main() {
  firstState = MyConstant.routeShowTodayCases;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: firstState,
      title: 'Covid Today',
    );
  }
}
