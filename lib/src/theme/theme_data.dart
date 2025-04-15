import 'package:trivia_base/src/src.dart';

class TriviaBaseAppThemeData {
  static ThemeData purplePop = ThemeData(
    colorScheme: ColorScheme(
      surface: const Color(0xff4a148c),
      secondary: const Color(0xffff80ab),
      onSurface: const Color(0xff4a148c),
      onSurfaceVariant: Colors.grey.shade400,
      brightness: Brightness.light,
      primary: const Color(0xff4a148c),
      onPrimary: const Color(0xffffffff),
      surfaceContainerHighest: const Color(0xff4a148c),
      error: Colors.white,
      onSecondary: const Color(0xff000000),
      onError: Colors.red,
    ),
    primaryColor: const Color(0xff4a148c),
    primaryColorLight: const Color(0xff7c43bd),
    primaryColorDark: const Color(0xff12005e),
    fontFamily: Literals.fontFamily,
  );
}