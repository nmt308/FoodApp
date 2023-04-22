import 'package:appf_review/page/AllProductPage.dart';
import 'package:appf_review/page/ProductPage.dart';
import 'package:appf_review/services/firestore_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:appf_review/model/products.dart';

class HomeProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                "Popular Products",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green),
              )),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AllProductPage()),
                  );
                },
                child: Text(
                  "See more",
                  style: TextStyle(fontSize: 16, color: Colors.lightGreen),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirestoreMethods().getAllProducts(), // Stream from Firestore
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // Check if snapshot has data
                  List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
                      snapshot.data!.docs;
                  return GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.7),
                    itemBuilder: (context, index) {
                      Map<String, dynamic> categoryData = docs[index].data();
                      Products product = Products(
                        id: categoryData['id'],
                        title: categoryData['title'],
                        image: categoryData['image'],
                        description: categoryData["description"],
                        price: categoryData["price"],
                      );
                      return ProductItem(product: product);
                    },
                  );
                } else {
                  return CircularProgressIndicator(); // Show loading indicator while data is being fetched
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  Products? product;
  ProductItem({this.product});

  @override
  Widget build(BuildContext context) {
    if (product!.image != null) {}
    return GestureDetector(
      onTap: () {
        // Utilities.data.add(product);
        Navigator.pushNamed(context, ProductPage.routeName,
            arguments: ProductDetailsArguments(product: product!));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network((product!.image!), fit: BoxFit.fill),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text((product!.title.toString())),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.green),
                child: Text(
                  "${product?.price} VNĐ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
