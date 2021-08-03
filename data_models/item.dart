/// The structure of the Item object

class Item {
  final String? itemTitle;
  final String? itemCategory;
  final String? itemSender;

  Item({this.itemTitle, this.itemCategory, this.itemSender});

  @override
  String toString() {
    return "Title: " + itemTitle!.toString() +
        ", Category: " + itemCategory!.toString() +
        ", Sender: " + itemSender!.toString();
  }
}







