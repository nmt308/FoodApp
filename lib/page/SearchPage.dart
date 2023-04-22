import 'package:appf_review/model/products.dart';
import 'package:appf_review/page/ProductPage.dart';
import 'package:appf_review/services/firestore_method.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  static String routeName = "/search";

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> _productList = [];
  final search = TextEditingController();
  Future<void> _searchProduct(String productName) async {
    try {
      List<Map<String, dynamic>> productList =
          await FirestoreMethods().searchProduct(productName);

      setState(() {
        _productList = productList;
      });
    } catch (e) {
      print('Lỗi khi tìm kiếm sản phẩm: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: search,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Search Product",
                    ),
                  ),
                ),
                Container(
                  color: Colors
                      .blue, // Thiết lập màu nền của nút IconButton là màu xanh
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white, // Thiết lập màu trắng cho icon
                    ),
                    onPressed: () {
                      _searchProduct(search.text);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _productList.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> productData = _productList[index];

                  int productId = productData["id"];
                  String productDes = productData["description"];
                  String productName = productData['title'];
                  String productImage = productData['image'];
                  int productPrice = productData['price'];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ProductPage.routeName,
                          arguments: ProductDetailsArguments(
                              product: Products(
                                  id: productId,
                                  description: productDes,
                                  title: productName,
                                  image: productImage,
                                  price: productPrice)));
                    },
                    child: Row(
                      children: [
                        Image.network(
                          productImage,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name: $productName",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Price: $productPrice VNĐ",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
