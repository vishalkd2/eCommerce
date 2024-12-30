import 'package:ecommerce/provider/UserProvider.dart';
import 'package:ecommerce/view/Homepage.dart';
import 'package:ecommerce/view/LandingPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref=await SharedPreferences.getInstance();
  String? token=await pref.getString('access_token');
  runApp(ChangeNotifierProvider(
    create: (context)=> UserProvider(),
  child:  MyApp(token: token,)));
}

class MyApp extends StatelessWidget {
  final String? token;
   MyApp({required this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: token!=null?Homepage(): LandingPage(),
    );
  }
}


