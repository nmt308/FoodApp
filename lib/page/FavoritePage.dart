import 'package:appf_review/model/products.dart';
import 'package:appf_review/services/firestore_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Products> _favoriteProducts = [];

  @override
  void initState() {
    super.initState();
    FirestoreMethods().getFavoriteProducts().then((favoriteProducts) {
      print(favoriteProducts);
      setState(() {
        _favoriteProducts = favoriteProducts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: ListView.builder(
          itemCount: _favoriteProducts.length,
          itemBuilder: (context, index) {
            return ProductItemList(product: _favoriteProducts[index]);
          }),
    ));
  }
}

class ProductItemList extends StatelessWidget {
  Products? product;
  ProductItemList({this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image.network(
              (product!.image).toString(),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${product!.title}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '${product!.description} ', // định dạng số thành chuỗi có 2 chữ số thập phân
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
