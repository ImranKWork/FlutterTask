import 'package:flutter/material.dart';
import 'package:flutter_task/providers/home_api_provider.dart';
import 'package:flutter_task/providers/logout_api_provider.dart';
import 'package:flutter_task/providers/signin_api_provider.dart';
import 'package:flutter_task/providers/signup_api_provider.dart';
import 'package:flutter_task/screens/home.dart';
import 'package:flutter_task/screens/landingpage.dart';
import 'package:flutter_task/utils/app_preference.dart';
import 'package:flutter_task/utils/prefrence_constant.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppPreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SignUpApiProvider()),
          ChangeNotifierProvider(create: (_) => SignInApiProvider()),
          ChangeNotifierProvider(create: (_) => LogoutApiProvider()),
          ChangeNotifierProvider(create: (_) => HomeApiProvider()),
        ],
        child: MaterialApp(
          title: 'Flutter Task',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: AppPreference.prefs.getString(pref_accesstoken) != null
              ? const HomeScreen()
              : const LandingPage(),
        ));
  }
}
