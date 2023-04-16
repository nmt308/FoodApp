import 'package:appf_review/model/carts.dart';
import 'package:appf_review/model/products.dart';
import 'package:appf_review/components/CheckOutCart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CartPage extends StatelessWidget {
  static String routeName = "/carts";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Cart Details"),
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Products> cartdetails = Cart().getCart();
  double sum = 0.0;

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    cartdetails.forEach((product) {
      sum = sum + product.price!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(
            shrinkWrap: true,
            itemCount: cartdetails.length,
            itemBuilder: (context, index) => Column(
              children: [
                GestureDetector(
                  child: CartItem(
                    product: cartdetails[index],
                  ),
                  onTap: () => setState(() {
                    cartdetails.removeAt(index);
                    sum = 0.0;
                    cartdetails.forEach((product) {
                      sum = sum + product.price!;
                    });
                  }),
                ),
                Divider()
              ],
            ),
          )),
          CheckOutCart(
            products: cartdetails,
            sum: sum,
          )
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  Products? product;

  CartItem({this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5),
      padding: EdgeInsets.all(16),
      child: Row(children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Image.network((product!.image).toString()),
        ),
        Expanded(child: Text((product!.title).toString())),
        Expanded(child: Text(product!.price.toString())),
        Icon(Icons.delete_outlined)
      ]),
    );
  }
}
