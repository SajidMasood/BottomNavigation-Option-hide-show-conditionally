import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback? onRegisterPressed;
  RegisterPage({super.key, this.onRegisterPressed});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Material(
          elevation: 10.0,
          borderRadius: BorderRadius.circular(30.0), //12
          color: Colors.transparent, //Colors.cyan.withOpacity(0.5),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            color: Colors.cyan.withOpacity(0.7),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            splashColor: Colors.cyan,
            onPressed: () {
              debugPrint("Register button pressed....");

              // ------------------------------------

              // ------------------------------------
              _onRegisterButtonPressed(context);
              // widget.onRegisterPressed?.call();
            },
            child: const Text('Register',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  //fontFamily: lang.font
                )),
          ),
        ),
      ),
    );
  }

  _onRegisterButtonPressed(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('showRegisterOption', false);

    // Call the callback function to notify the parent BottomNav class
    widget.onRegisterPressed?.call();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Register button pressed'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
