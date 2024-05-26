import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readwell_app/models/bookmodels.dart';
import 'package:readwell_app/bookpage.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book, required this.index});
  final Book book;
  final index;

  @override
  Widget build(BuildContext context) {
    return Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 348,
                    height: 220,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookPage(
                              book: book,
                              index: index,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        backgroundColor: const Color(0xff333333),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: SizedBox(width: 130, child: Image.network(book.linkimage, fit: BoxFit.fill,))
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 168,
                                  child: Text(
                                    book.booktitle,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xffE0DED5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 168,
                                  child: Text(
                                    book.bookauthor,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: const Color(0xffE0DED5),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 168,
                                  height: 75,
                                  child: Text(
                                    book.booksynopsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: const Color(0xffE0DED5),
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
                                  width: 168,
                                  child: Text("Genre: ${book.bookgenre}",
                                  overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: const Color(0xffE0DED5),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    Text(
                                      "Rating: ",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: const Color(0xffE0DED5),
                                      ),
                                    ),
                                    for (var i=0;i< book.bookrating ;i++) const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 18,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            );
  }
}