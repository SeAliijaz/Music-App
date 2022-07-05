// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/Widgets/custom_card.dart';

class MusicPlayerScreen extends StatelessWidget {
  const MusicPlayerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ///App Bar Row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child:
                      CustomCard(child: Center(child: Icon(Icons.arrow_back))),
                ),
                Text(
                  "Audio Player",
                  style: GoogleFonts.getFont("Salsa",
                      textStyle: TextStyle(fontSize: 20)),
                ),
                SizedBox(
                    height: 50,
                    width: 50,
                    child: CustomCard(child: Center(child: Icon(Icons.menu)))),
              ],
            ),
          ),

          ///Album Cover

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomCard(
              child: Column(
                children: [
                  Image.asset(
                    "images/cover_art.png",
                  ),
                  Text("Icons Will be displayed here")
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
