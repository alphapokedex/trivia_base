import 'package:trivia_base/src/src.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    Key? key,
    this.message = Literals.unknownError,
  }) : super(key: key);
  
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
          color: Colors.red,
        ),
      ),
    );
  }
}
