import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_v1/Types/BannerType.dart';
import 'package:todo_app_v1/Widgets/DefaultNotificationBanner.dart';

const url = "https://reqres.in/";

const kPhysic = BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

const kPrimaryColor = Color(0xFF3468B1);
const kBackgroundColor = Color.fromARGB(255, 234, 230, 230);

//Fonts
TextStyle k10w400AxiBlack({
  Color? color,
  bool isUnderlineText = false,
}) {
  return TextStyle(
    color: color ?? Colors.black,
    fontWeight: FontWeight.w400,
    fontFamily: "Axiforma",
    fontStyle: FontStyle.normal,
    fontSize: 10.0,
    decoration: isUnderlineText ? TextDecoration.underline : TextDecoration.none,
  );
}

TextStyle k12w400AxiBlack({
  Color? color,
  bool isUnderlineText = false,
}) {
  return TextStyle(
    color: color ?? Colors.black,
    fontWeight: FontWeight.w400,
    fontFamily: "Axiforma",
    fontStyle: FontStyle.normal,
    fontSize: 12.0,
    decoration: isUnderlineText ? TextDecoration.underline : TextDecoration.none,
  );
}

TextStyle k14w400AxiBlack({
  Color? color,
  bool isUnderlineText = false,
}) {
  return TextStyle(
    color: color ?? Colors.black,
    fontWeight: FontWeight.w400,
    fontFamily: "Axiforma",
    fontStyle: FontStyle.normal,
    fontSize: 14.0,
    decoration: isUnderlineText ? TextDecoration.underline : TextDecoration.none,
  );
}

TextStyle k16w400MontBlack({Color? color}) {
  return TextStyle(
    color: color ?? Colors.black,
    fontWeight: FontWeight.w400,
    fontFamily: "Montserrat",
    fontStyle: FontStyle.normal,
    fontSize: 16.0,
  );
}

TextStyle k17w600MontWhite({Color? color}) {
  return TextStyle(
    color: color ?? Colors.white,
    fontWeight: FontWeight.w600,
    fontFamily: "Montserrat",
    fontStyle: FontStyle.normal,
    fontSize: 17.0,
  );
}

// Banner
Flushbar kShowBanner(BannerType bannerType, String text, BuildContext context, {int? durationSeconds, Function()? onDismissed, Color? color}) {
  switch (bannerType) {
    case BannerType.ERROR:
      return DefaultNotificationBanner(
        iconPath: 'assets/images/wrong.png',
        text: text,
        context: context,
        color: color ?? Colors.red,
        durationSeconds: durationSeconds,
      ).show();

    case BannerType.SUCCESS:
      return DefaultNotificationBanner(
        iconPath: 'assets/images/success.png',
        text: text,
        context: context,
        color: Color.fromARGB(255, 9, 184, 14),
        durationSeconds: durationSeconds,
      ).show();
  }
}
