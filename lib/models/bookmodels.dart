class Book {
  Book(
      {required this.bookID,
      required this.linkimage,
      required this.booktitle,
      required this.bookauthor,
      required this.bookgenre,
      required this.bookrating,
      required this.booksynopsis,
      required this.pageheight,
      required this.favorite});
  String bookID;
  String linkimage;
  String booktitle;
  String bookauthor;
  String bookgenre;
  int bookrating;
  String booksynopsis;
  double pageheight;
  bool favorite;
}
