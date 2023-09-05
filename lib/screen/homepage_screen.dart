import 'package:flutter/material.dart';
import 'package:newsapplication/model/news_model_class.dart';
import 'package:newsapplication/screen/news_details_page_screen.dart';
import 'package:newsapplication/screen/searchpage_screen.dart';
import 'package:newsapplication/widget/custom_http_class.dart';
import 'package:page_transition/page_transition.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  int pageNo = 1 ;
  String sortBy = "publishedAt";

  List<String> list = [
    "publishedAt",
    "popularity",
    "relevancy",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text("News App",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        ),

        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: SearchPageScreen(),
                      inheritTheme: true,
                      ctx: context),
                );
              },
              icon: Icon(Icons.search,
              color: Colors.black,
                size: 28,
              ),
          )
        ],
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [

              Container(
                height: 80,
               // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                            InkWell(
                                onTap: (){
                                    if(pageNo < 0 ) {

                                    }else {
                                      setState(() {
                                        pageNo = pageNo - 1;
                                      });
                                    }
                                },
                                child: Container(
                                  height: 40,
                                    width: 50,
                                    color: Colors.blue,
                                    child: Center(child: Text("Prev"))),
                            ),


                            Flexible(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 9,
                                    itemBuilder: (context, index){
                                    return InkWell(
                                      onTap: (){
                                        setState(() {
                                          pageNo = index-1;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          left: 10
                                        ),
                                        // margin: EdgeInsets.only(
                                        //   left: 20,
                                        // ),
                                        height: 15,
                                        width: 25,
                                        color: index == pageNo + 1 ? Colors.blue : Colors.transparent,
                                        child: Center(child: Text("${index+1}",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black,
                                        ),
                                        )),
                                      ),
                                    );
                                    },
                                )
                            ),



                            InkWell(
                              onTap: (){
                                if(pageNo > 9){

                                }else{
                                  setState(() {
                                    pageNo = pageNo + 1 ;
                                  });
                                }
                              },
                              child: Container(
                                  height: 40,
                                  width: 50,
                                  color: Colors.blue,
                                  child: Center(child: Text("Next"))),
                            ),
                  ],
                ),
              ),
              Container(
                child: DropdownButton<String>(
                  value: sortBy,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      sortBy = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),


              FutureBuilder<List<Articles>>(
                  future: CustomHttpClass().fetchAllData(pageNo: pageNo, sortBy: sortBy),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else
                      if(snapshot.hasError){
                      return Center(child: Text("Something error"));
                    }else if(snapshot.data == null){
                      return Center(child: Text("No Data Found"));
                    }
                    return ListView.builder(
                         physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index){

                          var foysal = snapshot.data![index];

                          return Container(
                            padding: EdgeInsets.all(12),
                            child: ListTile(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewsDetailsPageScreen(
                                  articles: foysal,
                                )));
                              },

                              leading: Image.network("${foysal.urlToImage}"),
                              //leading: Text("${foysal["postId"]}"),

                              title: Text("${foysal.title}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              ),

                              subtitle: Text("${foysal.description}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                ),
                              ),

                              //trailing: Text("${foysal.publishedAt}"),
                            ),
                          );
                        },
                        itemCount: snapshot.data!.length
                    );
                  }
              ),
            ],
          ),
        ),
      ),

    );
  }
}
