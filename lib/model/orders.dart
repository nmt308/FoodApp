import 'package:appf_review/model/products.dart';

class Order {
  String name;
  double total;
  List<Products> products;

  Order({required this.name, required this.total, required this.products});
}
