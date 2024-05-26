import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readwell_app/models/bookmodels.dart';
import 'package:readwell_app/models/dummydata.dart';
import 'package:readwell_app/navbar.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key, required this.book, required this.index});
  final Book book;
  final index;

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffE0DED5),
        body: SafeArea(
          maintainBottomViewPadding: true,
          minimum: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            height: 350,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(10, 10),
                                    blurRadius: 5,
                                    color: Colors.black38,
                                    spreadRadius: 2),
                              ],
                            ),
                            child: Image.network(
                              widget.book.linkimage,
                              fit: BoxFit.fill,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => navbarall(),
                            ));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10 , 5 , 10 , 0),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        widget.book.booktitle,
                        style: GoogleFonts.poppins(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff605553),
                          shadows: [
                            const Shadow(color: Colors.black26, offset: Offset(2, 2)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.book.bookauthor,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff605553),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 65,
                        width: 360,
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xff605553),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Genre:   ${widget.book.bookgenre}",
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Rating: ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                for (var i = 0; i < widget.book.bookrating; i++)
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 370,
                    height: widget.book.pageheight ,
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff605553),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What can we do? ",
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            widget.book.booksynopsis,
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(right: 10),
          child: FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              listBook[widget.index].favorite = !listBook[widget.index].favorite;
                            });
                          },
                          backgroundColor: Colors.white,
                          child: Icon(
                            widget.book.favorite ? Icons.favorite : Icons.favorite_outline,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
        ),
        );
  }
}
