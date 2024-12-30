import 'package:ecommerce/view/LandingPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/UserRegisterationModel.dart';
import '../provider/UserProvider.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  TextEditingController _nameController=TextEditingController();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _avatarController=TextEditingController(text: 'https://picsum.photos/800');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.deepOrange,Colors.white,Colors.green],begin: Alignment.topLeft,end: Alignment.bottomRight)),

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name',border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),fillColor: Colors.white30,filled: true),
                  validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email',filled: true,fillColor: Colors.white30,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password',fillColor: Colors.white30,filled: true,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  obscureText: true,
                  validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                TextFormField(
                  controller: _avatarController,
                  readOnly: true,
                  decoration: InputDecoration(labelText: 'Avatar Url',filled: true,fillColor: Colors.white30,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final user = UserRegistrationModel(
                        name: _nameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                        avatar: _avatarController.text.trim(),
                      );
                      Provider.of<UserProvider>(context, listen: false).registerUser(user);
                    }
                  },
                  child: Text('Register'),
                ),
                Consumer<UserProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (provider.errorMessage != null) {
                      return Text(provider.errorMessage!,
                          style: TextStyle(color: Colors.red));
                    }
                    if (provider.userData != null) {
                      return Text("Registration is successfull");
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
