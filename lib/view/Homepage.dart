import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/model/CategoryModel.dart';
import 'package:ecommerce/model/ProductListModel.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(child: ListView(children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: ClipOval(child: Image.network(
              "https://storage.googleapis.com/a1aa/image/312375f4-73f5-47cd-b065-3667ec0d1702.jpeg",
              fit: BoxFit.cover,)),
            accountName: Text("Vishal"),
            accountEmail: Text("Vishal@gmail.com",),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart,),
            title: Text("Order"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.history,),
            title: Text("History"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person_off,),
            title: Text("Profile"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.payment,),
            title: Text("Payment"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout,),
            title: Text("Logout"),
            onTap: () {
              logOut(context);
            },
          ),
        ],)),
        body: SafeArea(
          child: Column(children: [
            const SizedBox(height: 5),
            CategoryWidget(),
            const SizedBox(height: 10),
            CarouselProduct(),
            const SizedBox(height: 10),
            ProductsWidget()
          ],)
        )
    );
  }
}
class CategoryWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ProductServices.fetchCategory(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Center(child: Text("Error: ${snapshot.error}"));
          }else if(!snapshot.hasData||snapshot.data!.isEmpty){
            return Center(child: Text("No category available"),);
          }else {
            List<CategoryModel> categories = snapshot.data!;
            return Container(height: 100,
              child: Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(margin: EdgeInsets.only(right: 5),
                        child: Stack(children: [
                          ClipRRect(borderRadius: BorderRadius.circular(6),
                              child: Image.network(categories[index].image,height: 150,)
                          ),
                          Align(alignment: Alignment.bottomCenter,child: Text(categories[index].name,style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),))
                        ],),
                      );
                    }
                ),
              ),
            );
          }
        });
  }
}

class CarouselProduct extends StatelessWidget {

  List<String> image=[
    'https://storage.googleapis.com/a1aa/image/879542b2-6525-448d-8c36-8228c2d2404d.jpeg',
    'https://storage.googleapis.com/a1aa/image/62e03519-5a56-4959-92d3-3f26093ee71d.jpeg',
    'https://storage.googleapis.com/a1aa/image/d39dce09-9e9c-4186-83ed-69540d32088c.jpeg',
    'https://storage.googleapis.com/a1aa/image/24dc7195-4f34-44d3-993e-46bc4d278ecd.jpeg',
    'https://storage.googleapis.com/a1aa/image/d019c2c1-db7d-4b9f-8303-9497bda2c362.jpeg'
  ];
  List<String> name=['Electronics','Clothe','Grocery','Travel','Shoe'];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: image.length,
        itemBuilder: (context,index,realIndex){
          return Column(children: [
            Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network(image[index],height: 300,fit: BoxFit.cover,))),
            SizedBox(height: 1),
            Text(name[index],style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
          ],);
        },
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 2.0,
          viewportFraction: 0.65,  // Control how much of the image is visible on each side
          scrollPhysics: BouncingScrollPhysics()
        ));
  }
}

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ProductServices.fetchProduct(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }else if(snapshot.hasError){
            return Text("Error : ${snapshot.error}");
          }else if(!snapshot.hasData||snapshot.data!.isEmpty){
            return Text("data is not available");
          }else{
            List<ProductListModel> products=snapshot.data!;
            return Container();
          }
        }
    );
  }
}


