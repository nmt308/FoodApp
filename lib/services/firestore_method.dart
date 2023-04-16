// import 'package:app/models/UserModel.dart';
import 'package:appf_review/model/categories.dart';
import 'package:appf_review/model/orders.dart';
import 'package:appf_review/model/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //?
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
      // Đọc dữ liệu từ Firestore và tạo đối tượng Product tương ứng
      Products product = Products(
          id: doc['id'],
          title: doc['title'],
          description: doc['description'],
          price: doc['price'],
          image: doc['image']
          //Thêm các thuộc tính khác của Product tại đây
          );
      favoriteProducts.add(product);
    });
    print(favoriteProducts);
    return favoriteProducts;
  }

  Future<List<Map<String, dynamic>>> searchProduct(productName) async {
    try {
      // Lấy tham chiếu đến bộ sưu tập sản phẩm trên Firestore
      CollectionReference productsRef =
          FirebaseFirestore.instance.collection('products');

      // Sử dụng phương thức where để thực hiện tìm kiếm
      QuerySnapshot querySnapshot =
          await productsRef.where('title', isEqualTo: productName).get();

      // Lấy danh sách các tài liệu kết quả từ QuerySnapshot
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
      return []; // Trả về danh sách rỗng nếu có lỗi
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

  Future<List<Order>> getOrders() async {
    try {
      // Lấy tham chiếu đến bộ sưu tập orders của user hiện tại trên Firestore
      CollectionReference ordersRef = FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('listOrders');

      // Lấy dữ liệu từ Firestore
      QuerySnapshot querySnapshot = await ordersRef.get();

      // Lấy danh sách các tài liệu kết quả từ QuerySnapshot
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
      List<Order> orderList = [];

      // Duyệt qua từng tài liệu để lấy thông tin của order
      for (var document in documents) {
        String orderId = document.id;
        String orderName = document['name'];
        double orderTotal = document['total'];
        List<dynamic> orderProducts = document['products'];

        // Tạo một danh sách các sản phẩm của order
        List<Products> products = orderProducts.map((productData) {
          String productName = productData['title'];
          int productPrice = productData['price'];
          String productImage = productData["image"];
          return Products(
              title: productName, price: productPrice, image: productImage);
        }).toList();

        // Tạo một đối tượng Order chứa thông tin của order
        Order orderData =
            Order(name: orderName, total: orderTotal, products: products);

        orderList.add(orderData);
      }

      return orderList;
    } catch (e) {
      print('Lỗi khi lấy danh sách các order: $e');
      return []; // Trả về danh sách rỗng nếu có lỗi
    }
  }

  Future<void> addOrder(List<Products> products, sum) async {
    try {
      // Lấy tham chiếu đến bộ sưu tập đơn hàng của người dùng hiện tại
      CollectionReference ordersRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('listOrders');

      // Tạo một Map đại diện cho thông tin của đơn hàng mới
      Map<String, dynamic> orderData = {
        'name': DateTime.now().millisecondsSinceEpoch.toString(),
        'total': sum,
        'products': []
      };

      // Tạo danh sách sản phẩm từ danh sách listProduct
      List<Map<String, dynamic>> productList = [];

      for (var product in products) {
        Map<String, dynamic> productData = {
          'id': product.id, // Lấy giá trị id của sản phẩm
          'title': product.title, // Lấy giá trị title của sản phẩm
          'price': product.price, // Lấy giá trị price của sản phẩm
          'image': product.image // Lấy giá trị image của sản phẩm
        };
        productList.add(productData);
      }

      // Gán danh sách sản phẩm vào thuộc tính 'products' của đơn hàng
      orderData['products'] = productList;

      // Thêm đơn hàng mới vào đơn hàng
      await ordersRef.add(orderData);
    } catch (e) {
      print('Lỗi khi thêm đơn hàng: $e');
    }
  }
}
