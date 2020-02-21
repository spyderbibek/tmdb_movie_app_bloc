import 'package:eva_icons_flutter/eva_icons_flutter.dart';
/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:flutter/material.dart';
import 'package:movie_app/style/theme.dart' as Style;

class HomeAppBar extends StatelessWidget {
  final String title;
  final String subTitle;

  HomeAppBar({@required this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 60,
      // padding: EdgeInsets.only(left: 24, right: 24, top: 10),
      decoration: BoxDecoration(
        color: Style.CustomColors.mainColor,
        border: Border(
            bottom: BorderSide(
          width: 0.3,
          color: Style.CustomColors.secondColor,
        )),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$title',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  letterSpacing: 1.4,
                  color: Style.CustomColors.secondColor,
                ),
              ),
              subTitle != null
                  ? Text(
                      '$subTitle',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 1.2,
                        color: Colors.white,
                      ),
                    )
                  : Container(),
            ],
          ),
//          GestureDetector(
//            onTap: () {},
//            child: Container(
//              width: 44,
//              height: 44,
//              alignment: AlignmentDirectional.centerEnd,
//              child: Icon(
//                EvaIcons.search,
//                color: Style.Colors.secondColor,
//              ),
//            ),
//          ),
        ],
      ),
    );
  }
}
