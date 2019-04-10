import "package:flutter/material.dart"; 
import 'package:http/http.dart'; 
import 'dart:io';
import 'dart:convert';
import "../../SwipeAnimation/index.dart";
import "./cards.dart";
import "../../Session.dart";
import "./decks.dart"; 


class DefaultHomeScreen extends StatefulWidget{
  @override
   

  createState(){
    return DefaultHomeStateScreen(); 
  }

  
}

class DefaultHomeStateScreen extends State<DefaultHomeScreen>{

  Decks decksData;

  @override
  void initState(){
    super.initState();
    print("Default Home Screen w Decks initializing");
    _fetchData(); 
  }
  

    _fetchData() async {
      print("Fetching data"); 
    final response = await get("https://fakerinos.herokuapp.com/api/articles/deck", 
    headers: {HttpHeaders.authorizationHeader: "Token 3ade3638c37c5370ab3c0679a7a8107eee133ed7"}); 
    
    if (response.statusCode == 200) {
      var decodedJson = new List();
      
      decodedJson = jsonDecode(response.body); 
      print(decodedJson);
      decksData = Decks.fromJson(decodedJson);

      print("decks output");
      print(decksData.toJson()); 

      setState(() {
      });
    } else {
      // print(response.statusCode);
      throw Exception('Failed to load cards');
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: decksData == null ?
        Center(child: CircularProgressIndicator(),
        ) : 
        ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        itemBuilder: (BuildContext context, int index) {
          if(index <= 0 ) {
            return _buildCarousel(context, index ~/ 2);
          }
          else {
            return Divider(
              height: 3
            );
          }
        },
      ), );
  }
  

  Widget _buildCarousel(BuildContext context, int carouselIndex) {
    final headers = ["Recommended For You", "Trending", "Newest"]; 
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(headers[carouselIndex]),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 200.0,
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 0.8),
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildCarouselItem(context, carouselIndex, itemIndex);
            },
          ),
        )
      ],
    );
  }

  Widget _buildCarouselItem(BuildContext context, int carouselIndex, int itemIndex) {
    return Center(
      child: GestureDetector(
        onTap: ()=> Navigator.push(context,
        new MaterialPageRoute(builder: (context)=> CardDemo())),
        onDoubleTap: ()=> showDialog( 
          context: context,
          builder: (BuildContext context){
          return AlertDialog(
          title: new Text("You liked this"));
          }), 
        child: Card(
          elevation: 10,
          child: ListTile(
              leading: Icon(Icons.album), 
              title: Text(decksData.decks[itemIndex].subject), 
              subtitle: Text(decksData.decks[itemIndex].subject)
            ))
          
          
          
            ,));
            
            
  }


}
