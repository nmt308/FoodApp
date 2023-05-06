import 'package:appf_review/model/carts.dart';
import 'package:appf_review/model/products.dart';
import 'package:appf_review/page/OrderPage.dart';
import 'package:appf_review/services/firestore_method.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckOutCart extends StatelessWidget {
  double? sum;
  List<Products>? products;
  Function? clearCart;
  CheckOutCart({this.sum, this.products, this.clearCart});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      minimumSize: Size(100, 50),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(color: Colors.green)),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: MaterialButton(
          height: 50,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(color: Colors.green)),
          color: Colors.white,
          textColor: Colors.green,
          onPressed: () {},
          child: Text(
            "Sum:${sum}",
            style: TextStyle(fontSize: 14.0),
          ),
        )),
        Expanded(
            child: MaterialButton(
          height: 50,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(color: Colors.green)),
          onPressed: () => {
            FirestoreMethods().addOrder(products!, sum),
            clearCart!(),
            Fluttertoast.showToast(
                msg: "Checkout successful",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Color.fromARGB(255, 89, 201, 128),
                textColor: Colors.white,
                fontSize: 16.0),
            // Navigator.pushNamed(context, OrderPage.routeName)
          },
          color: Colors.green,
          textColor: Colors.white,
          child: Text(
            "Check out".toUpperCase(),
            style: TextStyle(fontSize: 14),
          ),
        ))
      ],
    );
  }
}
