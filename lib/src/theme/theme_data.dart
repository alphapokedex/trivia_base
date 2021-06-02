import 'package:trivia_base/src/src.dart';

class TriviaBaseAppThemeData {
  static ThemeData purplePop = ThemeData(
    colorScheme: ColorScheme(
      surface: Color(0xff4a148c),
      secondary: Color(0xffff80ab),
      onSurface: Color(0xff4a148c),
      secondaryVariant: Color(0xffffb2dd),
      primaryVariant: Color(0xff4a148c),
      onBackground: Colors.grey.shade400,
      brightness: Brightness.light,
      primary: Color(0xff4a148c),
      onPrimary: Color(0xffffffff),
      background: Color(0xff4a148c),
      error: Colors.white,
      onSecondary: Color(0xff000000),
      onError: Colors.red,
    ),
    primaryColor: Color(0xff4a148c),
    primaryColorLight: Color(0xff7c43bd),
    primaryColorDark: Color(0xff12005e),
    accentColor: Color(0xffff80ab),
    accentColorBrightness: Brightness.light,
    fontFamily: Literals.fontFamily,
  );
}