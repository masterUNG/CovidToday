import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  List<String> titles = [
    'แสดงคนติดเชื่อ',
    'คนที่หายแล้ว',
    'ผู้เสียชีวิต',
    'อันเดททุกวัน',
  ];
  List<String> paths = [
    'images/image1.png',
    'images/image2.png',
    'images/image3.png',
    'images/image4.png',
  ];

  List<PageViewModel> pageViewModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    int i = 0;
    for (var item in titles) {
      pageViewModels.add(createPageViewModel(item, paths[i]));
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: pageViewModels,
        onDone: () {},
        done: Text('Next'),
      ),
    );
  }

  PageViewModel createPageViewModel(String title, String path) => PageViewModel(
        title: title,
        image: Image.asset(path),
        // bodyWidget: Image.asset(path),
      );
}
