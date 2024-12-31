import 'package:ecommerce/model/CategoryModel.dart';
import 'package:ecommerce/model/LoginResponseModel.dart';
import 'package:ecommerce/services/ProductServices.dart';
import 'package:ecommerce/view/LandingPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

Future<void>logOut(BuildContext context)async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  await prefs.remove('access_token');
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (contect)=>LandingPage()));
}

class _HomepageState extends State<Homepage> {
late Future<List<CategoryModel>> categories;

  @override
  void initState(){
    super.initState();
    categories=ProductServices.fetchCategory();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        drawer: Drawer(child: ListView(children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: ClipOval(child: Image.network("https://storage.googleapis.com/a1aa/image/312375f4-73f5-47cd-b065-3667ec0d1702.jpeg",fit: BoxFit.cover,)),
              accountName: Text("Vishal"),
              accountEmail: Text("Vishal@gmail.com",),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart,),
            title: Text("Order"),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.history,),
            title: Text("History"),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.person_off,),
            title: Text("Profile"),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.payment,),
            title: Text("Payment"),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.logout,),
            title: Text("Logout"),
            onTap: (){logOut(context);},
          ),
        ],)),
        body: SafeArea(
          child: Container(height: double.infinity, width: double.infinity,
            decoration: BoxDecoration(gradient: LinearGradient(
                colors: [Colors.deepOrange.shade100,Colors.white70,Colors.green.shade100],
                begin: Alignment.topLeft,end: Alignment.bottomRight)),
            child:FutureBuilder<List<CategoryModel>>(
              future: categories,
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                if(snapshot.hasError){
                  return Center(child: Text("error:${snapshot.error}"),);
                }if(snapshot.hasData){
                  List<CategoryModel> categoryData=snapshot.data!;
                  return ListView.builder(
                  itemCount: categoryData.length,
                  itemBuilder: (context,index){
                    CategoryModel catg=categoryData[index];
                    return ListTile(
                      leading: Image.network(catg.image),
                      title: Text(catg.name),
                    );
                  });

                }else{
                  return Center(child: Text(("no data")),);
                }
              },
            )
          ),
        ),
      );
  }
}
