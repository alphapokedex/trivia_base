import 'package:trivia_base/src/src.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    FocusNode passwordNode = FocusNode();
    OutlineInputBorder textInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.white,
        style: BorderStyle.solid,
      ),
    );
    return GetBuilder(
      init: AuthController(),
      builder: (AuthController controller) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          key: controller.formKey,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Literals.loginImage),
                fit: BoxFit.cover,
              ),
              color: Colors.blue,
              backgroundBlendMode: BlendMode.screen,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Spacer(flex: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: controller.emailCtrlr,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: Literals.emailLabel,
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      border: textInputBorder,
                      focusedBorder: textInputBorder,
                      focusedErrorBorder: textInputBorder,
                      errorBorder: textInputBorder,
                      enabledBorder: textInputBorder,
                      errorStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                    ),
                    validator: (String? email) {
                      return !emailRegex.hasMatch(email!)
                          ? Literals.provideEmail
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: controller.passCtrlr,
                    focusNode: passwordNode,
                    textInputAction: TextInputAction.send,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    onFieldSubmitted: (String value) {
                      if (controller.formKey.currentState?.validate() ??
                          false) {
                        AuthenticationService authObj =
                            AuthenticationService(FirebaseAuth.instance);
                        if (controller.updatedBool) {
                          authObj.signIn(
                            email: controller.emailCtrlr.text,
                            password: controller.passCtrlr.text,
                          );
                        } else {
                          authObj.signUp(
                            email: controller.emailCtrlr.text,
                            password: controller.passCtrlr.text,
                          );
                        }
                      } else {
                        Get.snackbar(
                          Literals.verificationFailed,
                          Literals.checkEmailEntry,
                          colorText: Colors.white,
                          backgroundColor: Colors.black,
                        );
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: Literals.passwordLabel,
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      border: textInputBorder,
                      focusedBorder: textInputBorder,
                      focusedErrorBorder: textInputBorder,
                      errorBorder: textInputBorder,
                      enabledBorder: textInputBorder,
                      errorStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                    ),
                    validator: (String? password) {
                      return password!.isEmpty
                          ? Literals.providePassword
                          : null;
                    },
                  ),
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 40),
                  dense: true,
                  inactiveTrackColor: Colors.grey,
                  title: Text(
                    controller.updatedBool ? Literals.signin : Literals.signup,
                    style: const TextStyle(
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                    softWrap: true,
                    maxLines: 3,
                  ),
                  value: controller.updatedBool,
                  onChanged: controller.onChange,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
