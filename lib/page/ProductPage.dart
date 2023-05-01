import 'package:appf_review/components/AddToCart.dart';
import 'package:appf_review/services/firestore_method.dart';
import 'package:flutter/material.dart';
import 'package:appf_review/model/products.dart';

class ProductPage extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments? arguments =
        ModalRoute.of(context)?.settings.arguments as ProductDetailsArguments?;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Image.network((arguments!.product!.image!)),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name product: ${arguments.product!.title}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Description: ${arguments.product!.description}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Price: ${arguments.product!.price} VNĐ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              flex: 1,
            ),
            Row(
              children: [
                AddProductTocart(product: arguments.product!),
                SizedBox(
                  height: 50,
                  width: 10,
                ),
                MaterialButton(
                    height: 50,
                    onPressed: () {
                      AddToFavorite(arguments.product!);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color.fromARGB(255, 229, 226, 225),
                    child: Icon(
                      Icons.favorite,
                      color: Color.fromARGB(201, 244, 67, 54),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void AddToFavorite(product) async {
    FirestoreMethods().addFavorite(product);
  }
}

class ProductDetailsArguments {
  final Products? product;

  ProductDetailsArguments({this.product});
}
