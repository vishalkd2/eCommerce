import 'package:ecommerce/model/ProductListModel.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductListModel product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            product.title,
            style: TextStyle(fontSize: 15),
          ),
          backgroundColor: Colors.orange.shade300,
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.orange.shade300,
            Colors.white70,
            Colors.green
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(height: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: product.images.length,
                  itemBuilder: (context,index){
                    return Container(margin: EdgeInsets.all(5),child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network(product.images[index],height: 200,)));
                  }),
            ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(product.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(product.description),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Price: ${product.price}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  ElevatedButton(onPressed: (){}, child: Text("Buy",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                  Spacer(),
                  ElevatedButton(onPressed: (){}, child: Text("Cart",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),

                ],),
              )

            ],),
        ));
  }
}
