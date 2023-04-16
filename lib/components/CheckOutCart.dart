import 'package:appf_review/model/products.dart';
import 'package:appf_review/services/firestore_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CheckOutCart extends StatelessWidget {
  double? sum;
  List<Products>? products;
  CheckOutCart({this.sum, this.products});

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
      children: <Widget>[
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
          onPressed: () => {FirestoreMethods().addOrder(products!, sum)},
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
