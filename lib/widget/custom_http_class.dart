import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapplication/model/news_model_class.dart';
import 'package:http/http.dart' as http;
import 'package:newsapplication/widget/constant_class.dart';

class CustomHttpClass{



 // Future<List<dynamic>> fetchAllData() async{
 //
 //   List<Articles> allNewsData = [];
 //   Articles? articles;
 //
 //   //var response = await http.get(Uri.parse("${baseUrl}q=apple&page=$pageNo&pageSize=10&sortBy=$sortBy&apiKey=${token}"));
 //   var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));
 //
 //   var data = jsonDecode(response.body);
 //
 //   print(data);
 //
 //   // for(var i in data["articles"]){
 //   //   articles = Articles.fromJson(i);
 //   //   allNewsData.add(articles);
 //   // }
 //
 //   // return allNewsData;
 //   return data;
 //  }


  Future<List<Articles>> fetchAllData({required int pageNo, required String sortBy}) async{

    List<Articles> allNewsData = [];
    Articles? articles;

    var response = await http.get(Uri.parse("${baseUrl}q=apple&page=$pageNo&pageSize=10&sortBy=$sortBy&apiKey=${token}"));
    //var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));
    print(response.body);
    var data = jsonDecode(response.body);
    print(data);

    for(var i in data["articles"]){
      articles = Articles.fromJson(i);
      allNewsData.add(articles);
    }

     return allNewsData;
    //return data;
   }

//for search data
  Future<List<Articles>> searchAllData({required String searchItem,required int pageNo,}) async{

    List<Articles> allNewsData = [];
    Articles? articles;

    var response = await http.get(Uri.parse("${baseUrl}q=$searchItem&page=$pageNo&pageSize=10&apiKey=${token}"));
    //var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));
    print(response.body);
    var data = jsonDecode(response.body);



    for(var i in data["articles"]){
      articles = Articles.fromJson(i);
      allNewsData.add(articles);
    }

    return allNewsData;
    //return data;
  }




}