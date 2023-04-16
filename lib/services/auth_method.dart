import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //publish ra ngoài
  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;

  void changePassword(String newPassword) async {
    try {
      // Lấy đối tượng người dùng hiện tại đang đăng nhập
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Cập nhật mật khẩu mới
        await user.updatePassword(newPassword);
        print("Mật khẩu đã được cập nhật thành công!");
      } else {
        print("Người dùng chưa đăng nhập");
      }
    } catch (e) {
      print("Lỗi khi cập nhật mật khẩu: $e");
    }
  }

  signIn(email, password) async {
    bool isAuth = false;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isAuth = true;
    } catch (e) {
      isAuth = false;

      print("Sign out error ${e}");
    }
    return isAuth;
  }

  void signOut(BuildContext context) async {
    try {
      _auth.signOut();
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', (Route<dynamic> route) => false);

      print("Sign out success");
    } catch (e) {
      print("Sign out error ${e}");
    }
  }
}
