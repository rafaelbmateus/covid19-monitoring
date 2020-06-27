import 'package:flutter/material.dart';
import 'package:covid19/src/theme/light_color.dart';
import 'package:covid19/src/theme/text_styles.dart';
import 'package:covid19/src/theme/extention.dart';

class Background extends StatelessWidget {

  Background({this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage("assets/doctor_face.jpg"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned.fill(
          child: Opacity(
            opacity: .6,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [LightColor.purpleExtraLight, LightColor.purple],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.mirror,
                    stops: [.5, 6]),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Image.asset("assets/heartbeat.png", color: Colors.white,height: 100,),
            Text(
              "COVID-19 Monitoring",
              style: TextStyles.h1Style.white,
            ),
            Expanded(
              flex: 7,
              child: SizedBox(),
            ),
          ],
        ).alignTopCenter,
      widget
      ],
    );
  }
}
