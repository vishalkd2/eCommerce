import 'package:ecommerce/model/LoginResponseModel.dart';
import 'package:ecommerce/services/UserService.dart';
import 'package:ecommerce/view/RegistrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Homepage.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordConttroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  final UserService _userService =UserService();

  Future<void> _login(BuildContext context)async{
    if(_formkey.currentState!.validate()){
      try{
        final email=_emailController.text.trim();
        final password=_passwordConttroller.text.trim();
        // Call the UserService to login
        LoginResponseModel loginResponseModel=await _userService.login(email, password);
        // Store the access token in SharedPreferences
        SharedPreferences prefs=await SharedPreferences.getInstance();
        prefs.setString('access_token', loginResponseModel.accessToken);
        print("Checked accessToken saved: ${loginResponseModel.accessToken}");

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage()));
        print("Login this user: $email");
      }catch(e){
        print("Login failed");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text("Shopping"),centerTitle: true,backgroundColor: Colors.green.shade50,),
        body: Container(height: double.infinity, width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.white, Colors.green],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(key: _formkey,
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Center(
                      child: Image.asset(
                    "asssets/icons/shoppingicon.png",
                    height: 150,
                  )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Center(
                      child: RichText(
                          text: TextSpan(children: [
                    TextSpan(
                        text: "Shop local, ",
                        style: TextStyle(fontSize: 20, color: Colors.teal)),
                    TextSpan(
                        text: "Celebrate Bharat!",
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink))
                  ]))),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email field can't be blank";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Email",
                        fillColor: Colors.blueGrey.shade100,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextFormField(
                    controller: _passwordConttroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email field can't be blank";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Password",
                        fillColor: Colors.blueGrey.shade100,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                    obscureText: true,
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text("Forget Password",
                          style: TextStyle(fontSize: 15))),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Center(
                      child: ElevatedButton(
                    onPressed: (){_login(context);},
                    child: Text("Login", style: TextStyle(fontSize: 25)),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Center(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistrationScreen()));
                          },
                          child: Text(
                            "Create new account here",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          )))
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}