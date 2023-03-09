import 'package:flutter/material.dart';
import 'package:hakathon2023/provider/post_service.dart';
import 'package:hakathon2023/provider/userLoggedIn.dart';
import 'package:hakathon2023/routes/app_router.dart';
import 'package:hakathon2023/routes/router_genaretor.dart';
import 'package:hakathon2023/routes/screen_name.dart';
import 'package:provider/provider.dart';


void main ()=>runApp(const HackathonApp());



class HackathonApp extends StatelessWidget {
  const HackathonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PostService(),
        ),
        ChangeNotifierProvider(create: (_) => AuthProvider()..initPrefs()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
          ),
        ),
        title: 'Hackathon App Tutorial',
        onGenerateRoute: RouteGenerator.onGenerateRoute,
        initialRoute: ScreenName.signInScreen,
        navigatorKey: AppRouter.navigatorKey,
      ),
    );
  }
}
