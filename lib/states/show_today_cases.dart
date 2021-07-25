import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:puntproj/models/covid_model.dart';
import 'package:puntproj/utility/my_constant.dart';
import 'package:puntproj/widgets/show_progress.dart';
import 'package:puntproj/widgets/show_title.dart';

class ShowTodayCases extends StatefulWidget {
  const ShowTodayCases({Key? key}) : super(key: key);

  @override
  _ShowTodayCasesState createState() => _ShowTodayCasesState();
}

class _ShowTodayCasesState extends State<ShowTodayCases> {
  bool load = true;
  CovidModel? model;
  String? day, mouth, year;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readTodayCasesAPI();
  }

  Future<Null> readTodayCasesAPI() async {
    await Dio().get(MyConstant.apiTodayCases).then((value) {
      print('value = $value');

      setState(() {
        load = false;
        model = CovidModel.fromMap(value.data);
        createDayMouthYear();
      });
    });
  }

  void createDayMouthYear() {
    List<String> strings = model!.UpdateDate.split(' ');
    print('strings[0] ==> ${strings[0]}');
    List<String> results = strings[0].split('/');
    day = results[0];

    switch (results[1]) {
      case '01':
        mouth = 'ม.ค.';
        break;
      case '02':
        mouth = 'ก.พ.';
        break;
         case '03':
        mouth = 'มี.ค.';
        break;
      case '04':
        mouth = 'ม.ย.';
        break;
         case '05':
        mouth = 'พ.ค.';
        break;
      case '06':
        mouth = 'มิ.ย.';
        break;
      case '07':
        mouth = 'ก.ค.';
        break;
        case '08':
        mouth = 'ส.ค.';
        break;
      case '09':
        mouth = 'ก.ย.';
        break;
         case '10':
        mouth = 'ต.ค.';
        break;
      case '11':
        mouth = 'พ.ย.';
        break;
         case '12':
        mouth = 'ธ.ค.';
        break;
      default:
    }

    print('mouth = $mouth');

    int yearInt = int.parse(results[2]) + 543;
    year = yearInt.toString();
    year = year!.substring(2, year!.length);
    print('year = $year');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Show Today Cases'),
      // ),
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: BoxDecoration(color: MyConstant.bg),
          child: load ? ShowProgress() : buildContent(constraints),
        ),
      ),
    );
  }

  Column buildContent(BoxConstraints constraints) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        rowHead(),
        buildMidle(constraints),
        buildRow2(constraints),
        buildRow3(constraints),
      ],
    );
  }

  Container buildRow2(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          rowMidLeft(constraints),
          rowMidRight(constraints),
        ],
      ),
    );
  }

  Container buildRow3(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          rowMidLeft2(constraints),
          rowRight2(constraints),
        ],
      ),
    );
  }

  Container rowMidLeft2(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.black, MyConstant.bg])),
      child: Column(
        children: [
          ShowTitle(
            title: 'เสียชีวิต',
            textStyle: MyConstant().h3Style(),
          ),
          ShowTitle(
            title: model!.todayDeaths.toString(),
            textStyle: MyConstant().h2Style(),
          ),
        ],
      ),
    );
  }

  Container rowRight2(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.4,
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [MyConstant.greenDart, MyConstant.bg])),
      child: Column(
        children: [
          ShowTitle(
            title: 'หายป่วยกลับบ้าน',
            textStyle: MyConstant().h3Style(),
          ),
          ShowTitle(
            title: '+${model!.todayRecovered}',
            textStyle: MyConstant().h2Style(),
          ),
        ],
      ),
    );
  }

  Container rowMidLeft(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [MyConstant.red, MyConstant.bg])),
      child: Column(
        children: [
          ShowTitle(
            title: 'ผู้ป่วยสะสม',
            textStyle: MyConstant().h3Style(),
          ),
          ShowTitle(
            title: 'ตั่งแต่ 1 เมษายน 64',
            textStyle: MyConstant().h4Style(),
          ),
          ShowTitle(
            title: model!.cases.toString(),
            textStyle: MyConstant().h2Style(),
          ),
        ],
      ),
    );
  }

  Container rowMidRight(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.4,
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [MyConstant.greenLight, MyConstant.bg])),
      child: Column(
        children: [
          ShowTitle(
            title: 'หายป่วยสะสม',
            textStyle: MyConstant().h3Style(),
          ),
          ShowTitle(
            title: 'ตั่งแต่ 1 เมษายน 64',
            textStyle: MyConstant().h4Style(),
          ),
          ShowTitle(
            title: model!.recovered.toString(),
            textStyle: MyConstant().h2Style(),
          ),
        ],
      ),
    );
  }

  Container buildMidle(BoxConstraints constraints) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      width: constraints.maxWidth * 0.8,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            MyConstant.bg,
            MyConstant.red,
            MyConstant.red,
            MyConstant.red,
            MyConstant.red,
            MyConstant.bg,
          ],
        ),
      ),
      child: Column(
        children: [
          ShowTitle(
            title: 'ผู้ติดเชื่อวันนี้',
            textStyle: MyConstant().h3Style(),
          ),
          ShowTitle(
            title: '+${model!.todayCases}',
            textStyle: MyConstant().h1Style(),
          ),
          // buildRowMidle(),
        ],
      ),
    );
  }

  Row buildRowMidle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            ShowTitle(
              title: 'ผู้ติดเชือใหม่',
              textStyle: MyConstant().h4Style(),
            ),
            ShowTitle(
              title: '14,000',
              textStyle: MyConstant().h2Style(),
            ),
          ],
        ),
        Column(
          children: [
            ShowTitle(
              title: 'จากเรือนจำ/ผู้ต้องขัง',
              textStyle: MyConstant().h4Style(),
            ),
            ShowTitle(
              title: '500',
              textStyle: MyConstant().h2Style(),
            ),
          ],
        ),
      ],
    );
  }

  Row rowHead() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildHeadLeft(),
        SizedBox(
          width: 6,
        ),
        buildHeadRight(),
      ],
    );
  }

  Column buildHeadLeft() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShowTitle(
          title: day!,
          textStyle: MyConstant().h1Style(),
        ),
        ShowTitle(
          title: '$mouth$year',
          textStyle: MyConstant().h2Style(),
        ),
      ],
    );
  }

  Column buildHeadRight() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShowTitle(
          title: 'สถาณการ COVID-19',
          textStyle: MyConstant().h3Style(),
        ),
        ShowTitle(
          title: 'ในประเทศไทย',
          textStyle: MyConstant().h2Style(),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 4),
          decoration: BoxDecoration(color: MyConstant.red),
          child: ShowTitle(
            title: 'ตั้งแต่ 1 เมษายน 2564',
            textStyle: MyConstant().h4Style(),
          ),
        ),
      ],
    );
  }
}
