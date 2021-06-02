import 'package:trivia_base/src/src.dart';

/// Returns a GetMaterialApp with default [RouteTransition.fadeIn]
/// initial Route as [HpmeView] and [purplePop] theme.
class TriviaBaseApp extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      title: Literals.appTitle,
      theme: TriviaBaseAppThemeData.purplePop,
      home: HomeView(),
    );
  }
}
