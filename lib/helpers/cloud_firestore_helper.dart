import 'package:cloud_firestore/cloud_firestore.dart';

import '../modals/item_modal.dart';

class CloudFirestoreHelper {
  CloudFirestoreHelper._();
  static final CloudFirestoreHelper cloudFirestoreHelper =
      CloudFirestoreHelper._();
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference foodRef;
  late CollectionReference favouritesRef;

  void connectionWithFoodCollection({required String collectionName}) {
    foodRef = firebaseFirestore.collection(collectionName);
  }

  Future<void> updateFavouriteStatus(
      {required String id, required Map<String, dynamic> data}) async {
    await foodRef.doc(id).update(data);
  }

  Stream<QuerySnapshot> fetchAllRecords({required String collectionName}) {
    connectionWithFoodCollection(collectionName: collectionName);

    return foodRef.snapshots();
  }

  void connectionWithFavouritesCollection() {
    favouritesRef = firebaseFirestore.collection('favourite_items');
  }

  Future<void> addToFavourites({required String id, required Item data}) async {
    connectionWithFavouritesCollection();
    Map<String, dynamic> addedData = {
      "name": data.name,
      "price": data.price,
      "delivery_time": data.deliveryTime,
      "image_URL": data.image,
      "ratings": data.ratings,
      "isFavourite": data.isFavourite,
    };
    return await favouritesRef.doc(id).set(addedData);
  }

  Future<void> removeFromFavourites({required String id}) async {
    connectionWithFavouritesCollection();
    return await favouritesRef.doc(id).delete();
  }
}
