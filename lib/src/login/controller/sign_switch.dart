import 'package:trivia_base/src/src.dart';

class AuthController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrlr = TextEditingController();
  final _passwordCtrlr = TextEditingController();
  var switchOn = false.obs;

  TextEditingController get passCtrlr => _passwordCtrlr;
  TextEditingController get emailCtrlr => _emailCtrlr;
  GlobalKey<FormState> get formKey => _formKey;

  bool get updatedBool => switchOn.value;

  /// changes the switch UI whenever the value of the boolean changes
  void onChange(bool value) {
    switchOn.value = value;
    update();
  }
}
