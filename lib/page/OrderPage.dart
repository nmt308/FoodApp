import 'package:appf_review/model/orders.dart';
import 'package:appf_review/services/firestore_method.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:appf_review/model/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class OrderPage extends StatefulWidget {
  static String routeName = "/order";
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Order> _orders = [];
  @override
  void initState() {
    super.initState();
    FirestoreMethods().getOrders().then((orders) {
      setState(() {
        _orders = orders as List<Order>;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: ListView.builder(
          itemCount: _orders.length,
          itemBuilder: (context, index) {
            return OrderItem(order: _orders[index]);
          }),
    ));
  }
}

class OrderItem extends StatelessWidget {
  Order? order;
  OrderItem({this.order});

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
              (order!.products[0].image).toString(),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
              child: SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${order!.name}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Total: ${order!.total.toInt()} VNĐ', // định dạng số thành chuỗi có 2 chữ số thập phân
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: order!.products.length,
                  itemBuilder: (context, index) {
                    var product = order!.products[index];
                    return Text(
                      '- ${product.title} (${product.price} VNĐ)',
                      style: TextStyle(fontSize: 14),
                    );
                  },
                ),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
