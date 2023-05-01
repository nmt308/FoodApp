import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:appf_review/model/carts.dart';
import 'package:appf_review/model/products.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddProductTocart extends StatefulWidget {
  Products? product;

  AddProductTocart({this.product});

  @override
  _AddProductTocartState createState() => _AddProductTocartState();
}

class _AddProductTocartState extends State<AddProductTocart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: MaterialButton(
          onPressed: () {
            Cart cart = Cart();
            cart.addProductToCart(widget.product!);
            Fluttertoast.showToast(
                msg: "Add to cart",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.green,
          child: Text(
            "Add to cart",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
