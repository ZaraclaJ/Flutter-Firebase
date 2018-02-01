class FirebaseImage {
  int ownerId;
  String url;

  FirebaseImage(this.ownerId, this.url);

  toJson() {
    return {
      "ownerId": ownerId,
      "url": url,
    };
  }
}