import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:newsapplication/model/news_model_class.dart';
import 'package:newsapplication/screen/news_details_page_screen.dart';
import 'package:newsapplication/widget/custom_http_class.dart';

class SearchPageScreen extends StatefulWidget {
  const SearchPageScreen({Key? key}) : super(key: key);



  @override
  State<SearchPageScreen> createState() => _SearchPageScreenState();
}

class _SearchPageScreenState extends State<SearchPageScreen> {

  TextEditingController searchController = TextEditingController();

  int pageNo = 1 ;

  List<Articles> searchData = [];
  List<String> searchKeyWord = ["football", "cricket", "politics", "nasa", "water", "food", "health"];

  bool isSearch = true;
  FocusNode? focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [

          SizedBox(height: 60,),

          TextFormField(
            controller: searchController,
            focusNode: focusNode,
            onChanged: (value)async{
              searchData = await CustomHttpClass().searchAllData(searchItem: searchController.text.toString(), pageNo: pageNo,);
              isSearch = false;
              setState(() {
              // focusNode!.nextFocus();
              });
            },
           //  onEditingComplete: () async{
           // searchData = await CustomHttpClass().searchAllData(searchItem: searchController.text.toString(), pageNo: pageNo,);
           // isSearch = false;
           // setState(() {
           //  focusNode!.nextFocus();
           // });
           //  },
            decoration: InputDecoration(
              labelText: "Search",
               hintText: "food...",
              prefixIcon: IconButton(
                onPressed: (){
                  focusNode!.unfocus();
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_outlined),
              ),
              suffixIcon: IconButton(
                onPressed: (){
                  searchController.clear();
                  searchData = [];
                  focusNode!.unfocus();
                  isSearch = true;
                  setState(() {

                  });
                },
                icon: Icon(Icons.cancel_outlined),
              ),
              enabledBorder:OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.pink,
                  width: 3,
                )
              ),

              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.pink,
                    width: 3,
                  )
              ),

            ),
          ),

          SizedBox(height: 5,),

          // InkWell(
          //   onTap: (){
          //     //CustomHttpClass().searchAllData(searchItem: searchController.text, pageNo: pageNo,);
          //   },
          //   child: Container(
          //
          //     height: 40,
          //     width: 100,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(12),
          //       border: Border.all(
          //         width: 3,
          //       ),
          //       color: Colors.green,
          //     ),
          //
          //     child: Center(child: Text("Search",)),
          //   ),
          // ),

          isSearch == true ? Container(
            height: 100,
            padding: const EdgeInsets.only(
                left: 16.0,
            right: 16,
              bottom: 16,
            ),
            child: MasonryGridView.count(
                itemCount: searchKeyWord.length,
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      searchData = await CustomHttpClass()
                          .searchAllData(
                          pageNo: 1,
                          searchItem: "${searchKeyWord[index]}");
                      setState(() {});
                    },
                    child: Text("${searchKeyWord[index]}"),
                  );
                }),
          ) : SizedBox(height: 0,),

          searchData.isNotEmpty
              ? Expanded(
                child: ListView.builder(
                //physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: searchData.length,
                itemBuilder: (context, index) {
                  return ListTile(

                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewsDetailsPageScreen(
                        articles: searchData[index],
                      )));
                    },
                    leading:
                    Image.network("${searchData[index].urlToImage}"),
                    title: Text("${searchData[index].title}"),
                    subtitle: Text("${searchData[index].description}"),
                  );
                }),
              )
              : SizedBox(height: 0,)

        ],
      ),


    );
  }
}
