import 'package:appf_review/model/carts.dart';
import 'package:appf_review/model/products.dart';
import 'package:appf_review/components/CheckOutCart.dart';
import 'package:flutter/material.dart';

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
    void clearCart() {
      Cart().clearProduct();

      setState(() {
        cartdetails = [];
        sum = 0;
      });
    }

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
            clearCart: clearCart,
          )
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final Products? product;

  const CartItem({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product!.image!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product!.title!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${product!.price} VNĐ',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            child: IconButton(
              icon: const Icon(Icons.delete_outlined),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
