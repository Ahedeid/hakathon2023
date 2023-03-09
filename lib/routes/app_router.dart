
import 'package:flutter/material.dart';


class AppRouter{
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static goToAndRemove({required String screenName}){
    navigatorKey.currentState!.pushReplacementNamed(screenName);
  }

  static goTo({required String screenName}){
    navigatorKey.currentState!.pushNamed(screenName);
  }

  static back() {
    navigatorKey.currentState!.pop();
  }

  static mayBack() {
    navigatorKey.currentState!.maybePop();
  }

}