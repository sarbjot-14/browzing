class Item {
  String id = '';
  bool seen = false;
  int seenEnough = 0;
  String title = '';
  String itemId = '';
  String description = '';
  double price = 0.0;

  Item(
      {this.id,
      this.title,
      this.seen,
      this.seenEnough,
      this.itemId,
      this.description,
      this.price});
}
