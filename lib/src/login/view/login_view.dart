import 'package:trivia_base/src/src.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusNode _passwordNode = FocusNode();
    OutlineInputBorder textInputBorder = OutlineInputBorder(
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
            decoration: BoxDecoration(
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
                Spacer(flex: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: controller.emailCtrlr,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: Literals.emailLabel,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: textInputBorder,
                      focusedBorder: textInputBorder,
                      focusedErrorBorder: textInputBorder,
                      errorBorder: textInputBorder,
                      enabledBorder: textInputBorder,
                      errorStyle: TextStyle(
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
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: controller.passCtrlr,
                    focusNode: _passwordNode,
                    textInputAction: TextInputAction.send,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    onFieldSubmitted: (String value) {
                      if (controller.formKey.currentState.validate()) {
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
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: textInputBorder,
                      focusedBorder: textInputBorder,
                      focusedErrorBorder: textInputBorder,
                      errorBorder: textInputBorder,
                      enabledBorder: textInputBorder,
                      errorStyle: TextStyle(
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
                Spacer(),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 40),
                  dense: true,
                  inactiveTrackColor: Colors.grey,
                  title: Text(
                    controller.updatedBool ? Literals.signin : Literals.signup,
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                    softWrap: true,
                    maxLines: 3,
                  ),
                  value: controller.updatedBool,
                  onChanged: controller.onChange,
                ),
                Spacer(),
                Stack(
                  children: [
                    const Divider(
                      color: Colors.white30,
                      thickness: 2,
                      indent: 90,
                      endIndent: 90,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        Literals.orText,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                OutlinedButton.icon(
                  onPressed: AuthenticationService.gSignIn,
                  label: const Text(Literals.loginWithGoogle),
                  icon: const FaIcon(FontAwesomeIcons.google),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white10),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
