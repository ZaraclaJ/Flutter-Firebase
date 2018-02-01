import 'package:firebase_database/firebase_database.dart';

class FirebaseImage {
  String key;
  String ownerId;
  String url;

  FirebaseImage(this.ownerId, this.url);

  FirebaseImage.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        ownerId = snapshot.value["ownerId"],
        url = snapshot.value["url"];

  toJson() {
    return {
      "ownerId": ownerId,
      "url": url,
    };
  }
}