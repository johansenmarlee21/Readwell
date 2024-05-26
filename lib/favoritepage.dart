import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readwell_app/book_card.dart';
import 'package:readwell_app/models/dummydata.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
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
                  Text('Favorite Page',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      )),
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
                  print(listBook[index].favorite);
                  if(listBook[index].favorite == true){
                    return BookCard(book: listBook[index], index: index,);
                  } else {
                    return const SizedBox(height: 0,);
                    // const Center(child:Text('You do not have any favorite book yet'));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
