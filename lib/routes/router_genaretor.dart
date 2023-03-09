import 'package:flutter/material.dart';
import 'package:hakathon2023/routes/screen_name.dart';
import '../screens/auth_screen/signin_screen.dart';
import '../screens/auth_screen/signup_screen.dart';
import '../screens/home_screen.dart';


class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Widget result;

    switch (settings.name) {
      case ScreenName.homeScreen:
        result = const HomeScreen();
        break;
        case ScreenName.signInScreen:
        result = const SignInScreen();
        break;
        case ScreenName.signUpScreen:
        result =  SignUpScreen();
        break;
      default:
        result = const Scaffold(
          body: Center(
            child: Text(
              'Wrong path',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
    }
    return MaterialPageRoute(builder: (context) => result);
  }
}
