// import 'package:app/models/UserModel.dart';
import 'package:appf_review/model/categories.dart';
import 'package:appf_review/model/notification.dart';
import 'package:appf_review/model/orders.dart';
import 'package:appf_review/model/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() {
    return FirebaseFirestore.instance.collection('categories').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() {
    return FirebaseFirestore.instance.collection('products').snapshots();
  }

  Future<List<Products>> getFavoriteProducts() async {
    print("Called");
    List<Products> favoriteProducts = [];
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('listFavorite')
        .get();

    querySnapshot.docs.forEach((doc) {
      Products product = Products(
          id: doc['id'],
          title: doc['title'],
          description: doc['description'],
          price: doc['price'],
          image: doc['image']);
      favoriteProducts.add(product);
    });
    print(favoriteProducts);
    return favoriteProducts;
  }

  Future<List<Notifications>> getNotifications() async {
    List<Notifications> notifications = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('notifications').get();
    for (DocumentSnapshot snapshot in querySnapshot.docs) {
      Notifications notification = Notifications(
          title: snapshot['title'],
          body: snapshot['body'],
          image: snapshot['image']);
      notifications.add(notification);
    }
    return notifications;
  }

  Future<List<Map<String, dynamic>>> searchProduct(productName) async {
    try {
      CollectionReference productsRef =
          FirebaseFirestore.instance.collection('products');

      QuerySnapshot querySnapshot =
          await productsRef.where('title', isEqualTo: productName).get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
      List<Map<String, dynamic>> productList = [];

      // Duyệt qua từng tài liệu để lấy thông tin sản phẩm
      for (var document in documents) {
        int productId = document['id'];
        String productDes = document['description'];
        String productName = document['title'];
        int productPrice = document['price'];
        String productImage = document['image'];

        // Tạo một đối tượng Map chứa thông tin sản phẩm
        Map<String, dynamic> productData = {
          'id': productId,
          'title': productName,
          'price': productPrice,
          'image': productImage,
          'description': productDes
        };
        productList.add(productData);
      }
      return productList;
    } catch (e) {
      print('Lỗi khi tìm kiếm sản phẩm: $e');
      return [];
    }
  }

  addFavorite(product) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('listFavorite')
          .add({
        'id': product.id,
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'image': product.image,
      });
      print(product);
    } catch (e) {
      print("error");
    }
  }

  addNotification(title, body) async {
    print(title + body);
    // Lưu nội dung thông báo vào Firestore
    await _firestore.collection('notifications').add({
      'title': title,
      'body': body,
    });

    print("add ok");
  }

  Future<List<Order>> getOrders() async {
    try {
      CollectionReference ordersRef = FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('listOrders');

      // Lấy dữ liệu từ Firestore
      QuerySnapshot querySnapshot = await ordersRef.get();

      // Lấy danh sách các tài liệu kết quả từ QuerySnapshot
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
      List<Order> orderList = [];

      for (var document in documents) {
        String orderId = document.id;
        String orderName = document['name'];
        double orderTotal = document['total'];
        List<dynamic> orderProducts = document['products'];

        List<Products> products = orderProducts.map((productData) {
          String productName = productData['title'];
          int productPrice = productData['price'];
          String productImage = productData["image"];
          return Products(
              title: productName, price: productPrice, image: productImage);
        }).toList();

        Order orderData =
            Order(name: orderName, total: orderTotal, products: products);

        orderList.add(orderData);
      }

      return orderList;
    } catch (e) {
      print('Lỗi khi lấy danh sách các order: $e');
      return [];
    }
  }

  Future<void> addOrder(List<Products> products, sum) async {
    try {
      CollectionReference ordersRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('listOrders');

      Map<String, dynamic> orderData = {
        'name': DateTime.now().millisecondsSinceEpoch.toString(),
        'total': sum,
        'products': []
      };

      // Tạo danh sách sản phẩm từ danh sách listProduct
      List<Map<String, dynamic>> productList = [];

      for (var product in products) {
        Map<String, dynamic> productData = {
          'id': product.id,
          'title': product.title,
          'price': product.price,
          'image': product.image
        };
        productList.add(productData);
      }

      orderData['products'] = productList;

      await ordersRef.add(orderData);
    } catch (e) {
      print('Lỗi khi thêm đơn hàng: $e');
    }
  }
}
