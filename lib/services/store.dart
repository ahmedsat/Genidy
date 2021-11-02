import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import '../models/product.dart';

class Store {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addProduct(Product product) {
    _firestore.collection(KProductCollection).add({
      KProductName: product.pname,
      KProductPrice: product.pprice,
      KProductDescription: product.pdescription,
      KProductCategory: product.pcategory,
      KProductImage: product.pimage,
      KProductInfo: product.pinfo,
      KProductQuantity: product.pquantity,
      KProductSale: product.psale,
    });
  }

  Stream<QuerySnapshot> getProducts() => _firestore.collection(KProductCollection).snapshots();
  deletProduct(id) => _firestore.collection(KProductCollection).doc(id).delete();
  editProduct(data, id) => _firestore.collection(KProductCollection).doc(id).update(data);

  storeOrders(data, List<Product> products) {
    DocumentReference documentReference = _firestore.collection(KOrdersCollection).doc();
    documentReference.set(data);
    for (Product product in products) {
      documentReference.collection(KOrderDetails).doc().set({
        KProductName: product.pname,
        KProductPrice: product.pprice,
        KProductQuantity: product.pquantity,
        KProductID: product.pid,
      });
    }
  }

  updateOrder(data, id) => _firestore.collection(KOrdersCollection).doc(id).update(data);

  Stream<QuerySnapshot> getOrders() => _firestore.collection(KOrdersCollection).snapshots();
  Stream<QuerySnapshot> getOrderDetails(docID) => _firestore.collection(KOrdersCollection).doc(docID).collection(KOrderDetails).snapshots();

  updateUser(data, id) {
    _firestore.collection(KOrdersCollection).doc(id).update(data);
  }

  void createUser(id) async {
    final CollectionReference postsRef = _firestore.collection(KUsersCollection);
    await postsRef.doc(id).set({
      KAddress: '',
      KPhoneNumber: '',
    });
  }

  Stream<DocumentSnapshot> getUserData(String uid) {
    try {
      return _firestore.collection(KUsersCollection).doc(uid).snapshots();
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
