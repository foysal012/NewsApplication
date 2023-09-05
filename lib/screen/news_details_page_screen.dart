import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:newsapplication/model/news_model_class.dart';
import 'package:newsapplication/screen/searchpage_screen.dart';
import 'package:page_transition/page_transition.dart';

class NewsDetailsPageScreen extends StatefulWidget {
   NewsDetailsPageScreen({Key? key, this.articles}) : super(key: key);

  Articles? articles;

  @override
  State<NewsDetailsPageScreen> createState() => _NewsDetailsPageScreenState();
}

class _NewsDetailsPageScreenState extends State<NewsDetailsPageScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text("News Details",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        // actions: [
        //   IconButton(
        //     onPressed: (){
        //       Navigator.push(
        //         context,
        //         PageTransition(
        //             type: PageTransitionType.rightToLeft,
        //             child: SearchPageScreen(),
        //             inheritTheme: true,
        //             ctx: context),
        //       );
        //     },
        //     icon: Icon(Icons.search,
        //       color: Colors.black,
        //       size: 28,
        //     ),
        //   )
        // ],
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 130,
              width: double.infinity,
              child: Text("${widget.articles!.title}",
                // style: TextStyle(
                //   fontWeight: FontWeight.bold,
                //   color: Colors.black,
                //   fontSize: 20,
                // ),
                style: GoogleFonts.fjallaOne(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                ),
              ),
            ),

            SizedBox(height: 4,),

            Divider(
              height: 5,
              color: Colors.grey,
              thickness: 2,
              indent: 12,
              endIndent: 12,
            ),

            SizedBox(height: 4,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 12,
                    right: 12,
                  ),
                  child: Column(
                    children: [
                      Text("Author:"),
                      Text("${widget.articles!.author}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(
                    left: 12,
                    right: 12,
                  ),
                  child: Column(
                    children: [
                      Text("Date:",),
                      Text("${Jiffy.parse("${widget.articles!.publishedAt}").format(pattern: "MMM do yy, h:mm a")}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            SizedBox(height: 4,),

            Divider(
              height: 5,
              color: Colors.grey,
              thickness: 3,
              indent: 12,
              endIndent: 12,
            ),

            SizedBox(height: 15,),

            Container(
              height: 130,
              width: double.infinity,
              child: Text("${widget.articles!.description}",
                // style: TextStyle(
                //   fontWeight: FontWeight.w500,
                //   color: Colors.black,
                //   fontSize: 16,
                // ),
                style: GoogleFonts.eduSaBeginner(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16,
                ),
              ),
            ),

            SizedBox(height: 12,),

            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.pink,
                  width: 3
                ),
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(image: NetworkImage("${widget.articles!.urlToImage}"))
              ),
            ),

            SizedBox(height: 20,),

            Container(

              width: double.infinity,
              child: Text("${widget.articles!.content}",
              style: GoogleFonts.lora(
                fontSize: 16,
                fontWeight: FontWeight.w100,
                color: Colors.black,
              ),
              ),
            ),
            
            SizedBox(height: 5,),

            // InkWell(
            //   onTap: (){
            //     final websiteUrl = Uri.parse("${ widget.articles!.url}");
            //    setState(() {
            //      launchUrl(
            //        websiteUrl,
            //        mode: LaunchMode.inAppWebView,
            //      );
            //    });
            //   },
            //   child: Container(
            //     height: 40,
            //     width: 80,
            //     color: Colors.blue,
            //     child: Center(child: Text("Visit")),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
