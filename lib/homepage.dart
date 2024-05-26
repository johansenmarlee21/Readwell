import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readwell_app/book_card.dart';
import 'package:readwell_app/models/dummydata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE0DED5),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'For You',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                shrinkWrap: true,
                itemCount: listBook.length,
                itemBuilder: (context, index) {
                  // print(listBook[index].favorite);
                  return BookCard(
                    book: listBook[index],
                    index: index,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
