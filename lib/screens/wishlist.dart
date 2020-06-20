import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:plasmadonation/color.dart';
import 'package:plasmadonation/helper/helper.dart';
import 'package:url_launcher/url_launcher.dart';
class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  var data;
  var uid;
  bool progress = true; 
  bool showSearch =  false;
  TextEditingController searchfield = TextEditingController();
  
  QuerySnapshot _querySnapshot;
  Map mymap;
  HelperFunctions _helperFunctions = HelperFunctions();

  datastore()async{
    
  await _helperFunctions.getemail().then((value){
      setState(() {
        print(value);
        uid = value;
        
      });
      
    });
    
     await Firestore.instance.collection("users").document(uid).collection("Whitelist").getDocuments().then((sanpshot){
       setState(() {
         _querySnapshot = sanpshot;
         progress = false;

         
       });
       

     });






  }




  @override
  void initState() {

    this.datastore();
    super.initState();
  }



  Color bgclr = HexColor("#010022");
  Color sdclr = HexColor("#66000000");
  Color righclr = HexColor("#1C5E8D");
  Color leftclr = HexColor("#070639");
  Color color1 = HexColor("#131238");
  Color color2 = HexColor("#8D8CAA");
  Color color4 = HexColor("#1C5E8D");
  int index = 0;
  bool home = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      decoration: BoxDecoration(color: bgclr),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        
        children: <Widget>[

          Stack(
               children: <Widget>[
                 Container(
              height: MediaQuery.of(context).size.height/3+31,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [

                    BoxShadow(
                      color: sdclr.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [righclr , leftclr])),
                  child: Center(child: Text("Wishlist",
                  style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w400
                  ),)),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset("assets/v1.png"),
              ),
              Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset("assets/v2.png"),
              ),
               ],
          ),



          Expanded(
              child: _querySnapshot == null? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text("No Data"),
                ),
              ):
               Container(
              child: progress != false? Center(
                child: CircularProgressIndicator() ,
              ) : ListView.builder(
                itemCount: _querySnapshot==null? 0: _querySnapshot.documents.length,
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(8.0),
                        color: color1
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(_querySnapshot.documents[index].data["PhotoUrl"],
                                      height: 75.0,
                                      width: 75.0,
                                  ),
                              ),
                            
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 128,
                                height: 100 ,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_querySnapshot.documents[index].data["Blood"]+" Blood",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: .5
                                    ) ,),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(_querySnapshot.documents[index].data["name"]),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(_querySnapshot.documents[index].data["Area"]),
                                    
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _querySnapshot.documents[index].data["CovidRecovered"] != false? 
                                Text("Covid Recovered") : Container() ,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      Scaffold.of(context).showSnackBar(new SnackBar(
                                            content: new Text("Long Press on Heart To Remove",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14
                                            ),
                                            ),
                                            backgroundColor: color1,
                                        ));
                                    },
                                    onLongPress: ()async{
                                       await Firestore.instance.collection("users")
                                       .document(uid).
                                       collection("Whitelist")
                                       .document(_querySnapshot.documents[index].data["name"].toString()).delete();
                                       print("Delete");
                                       Scaffold.of(context).showSnackBar(new SnackBar(
                                            content: new Text("Deleted",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14
                                            ),
                                            ),
                                            backgroundColor: color1,
                                        ));

                                       datastore();









                                    },

                                      
                                      child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: color2
                                      ),
                                      child: Icon(Icons.favorite,size: 22,),
                                      
                                    ),
                                  ),
                                ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: ()async{

                                          String a = _querySnapshot.documents[index].data["Phone"];
                                          if (await canLaunch("tel: $a")) {
                                            await launch("tel: $a");
                                          } else {
                                            throw 'Could not launch';
                                          }
                                        },
                                  child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: color2
                                  ),
                                  child: Icon(Icons.call,size: 22,),
                                  
                                ),
                                      ),
                                    ),

                                
                                  ],
                                )




                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
                ),
            ),
          ),
        ],
      ),
    )
    
    );
  }
}