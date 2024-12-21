import 'package:ecommerce/services/UserService.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
   LandingPage({super.key});

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordConttroller=TextEditingController();
  final _formkey=GlobalKey<FormState>();
  UserService userService=UserService();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Shopping"),centerTitle: true,backgroundColor: Colors.green.shade50,),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.deepOrange,Colors.white,Colors.green],
        begin: Alignment.topLeft,end: Alignment.bottomRight),
        ),
        child: Stack(children: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  Center(child: Image.asset("asssets/icons/shoppingicon.png",height:150,)),
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  Center(
                    child: RichText(text: TextSpan(children: [
                      TextSpan(text: "Shop local, ",style: TextStyle(fontSize: 20,color: Colors.teal)),
                      TextSpan(text: "Celebrate Bharat!",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.pink))
                    ]))),
                  SizedBox(height: MediaQuery.of(context).size.height*0.1),
                  TextFormField(controller: emailController,validator: (value){if(value==null||value.isEmpty){return "Email field can't be blank";}},decoration: InputDecoration(labelText: "Email",fillColor: Colors.blueGrey.shade100,filled: true,border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),keyboardType: TextInputType.emailAddress,),
                  SizedBox(height: MediaQuery.of(context).size.height*0.02),
                  TextFormField(controller: passwordConttroller,validator: (value){if(value==null||value.isEmpty){return "Email field can't be blank";}},decoration: InputDecoration(labelText: "Password",fillColor: Colors.blueGrey.shade100,filled: true,border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),obscureText: true,),
                  Align(alignment: Alignment.bottomRight,child: Text("Forget Password",style: TextStyle(fontSize: 15))),
                  SizedBox(height: MediaQuery.of(context).size.height*0.04),
                  Center(child: ElevatedButton(onPressed: (){}, child: Text("Login",style: TextStyle(fontSize: 25)),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),)),
                  // Center(child: TextButton(onPressed: (){}, child: Text("Login",style: TextStyle(fontSize: 20),),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),)),
                  SizedBox(height: MediaQuery.of(context).size.height*0.1),
                  Center(child: Text("Create new account here",style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline),))





                ],
              ),
        ),
          ],
        ),
      )
    );
  }
}
