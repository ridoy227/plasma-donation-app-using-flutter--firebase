import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plasmadonation/color.dart';
import 'package:plasmadonation/helper/helper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Color color1 = HexColor("#010022");
  Color color2 = HexColor("#152755");
  Color color3 = HexColor("#100F51");
  bool hasdata = false;
  bool login = false;
  
  String email;

  HelperFunctions _helperFunctions = HelperFunctions();
  GoogleSignIn _googleSignIn = GoogleSignIn();
  QuerySnapshot searchSnapshot;
  
  @override
  void initState() {
    super.initState();
    this.datastore();
  }
    datastore()async{
      await _helperFunctions.getemail().then((value){
      setState(() {
        print(value);
        email = value;
        
      });
      
    });
        print(email);




     await Firestore.instance.collection("users")
     .where('Email', isEqualTo: email)
     .getDocuments().then((sanpshot){
       searchSnapshot = sanpshot;
       setState(() {
         searchSnapshot = sanpshot;
         hasdata = true;
         print( sanpshot.documents[0].data["Email"] );

       });
     });
  }
  
  logOut()async{
    _googleSignIn.signOut();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
            login = false;
            preferences.clear();
          });
          
          
    await _helperFunctions.setlogin(login);

    Navigator.of(context).pushReplacementNamed("home");

    
   


  }

  editProfile(){
    Navigator.of(context).pushReplacementNamed("editprofile");
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hasdata !=true? Container(
        height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: color1
          ),

        child: Center(
              child: CircularProgressIndicator(),
            ),
      ) :  Stack(
        children: <Widget>[

          Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: color1
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_back),
                   onPressed: (){
                     Navigator.of(context).pushReplacementNamed("dashboard");
                   }
                   ),
                  Text("Profile",style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: .5
                  ),
                  ),
                  IconButton(icon: Icon(Icons.info),
                   onPressed: (){
                     Navigator.of(context).pushReplacementNamed("dashboard");
                   }
                   )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              //this is profile
              Container(
                width: MediaQuery.of(context).size.width,
                child:        
                    Stack(
                  children: <Widget>[
                    Container(
                      height: 230,
                      width: MediaQuery.of(context).size.width,
                    ),



                      
                     
                       Positioned(
                         
                         left: 8,
                         right: 8,
                         bottom: 1,
                           child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: color2
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width/2+41,
                                
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 75,
                                        ),
                                        Flexible(
                                            child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(searchSnapshot.documents[0].data["name"],
                                            style: TextStyle(
                                              fontSize: 18
                                            ),
                                              overflow: TextOverflow.clip,
                                                                                   
                                             ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),

                                    Row(
                                      children: <Widget>[

                                        SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: color3
                                        
                                      ),
                                      child: Icon( 
                                        Icons.bubble_chart
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(searchSnapshot.documents[0].data["Blood"]+" Blood",
                                          style: TextStyle(
                                            fontSize: 14
                                          ),
                                          )

                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: <Widget>[

                                        SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: color3
                                        
                                      ),
                                      child: Icon( 
                                        Icons.location_on
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(searchSnapshot.documents[0].data["Area"],
                                          style: TextStyle(
                                            fontSize: 14
                                          ),
                                          )

                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: <Widget>[

                                        SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: color3
                                        
                                      ),
                                      child: Icon( 
                                        Icons.phone_android
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(searchSnapshot.documents[0].data["Phone"],
                                          style: TextStyle(
                                            fontSize: 14
                                          ),
                                          )

                                      ],
                                    ),



                                  ],
                                ),
                              )
                            ],
                          )
                      ),
                       ),
                       Positioned (
                        top: 2,
                        left: 8,
                          child: Container(
                          height: 69,
                          width: 69,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: color2
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: ClipRRect(
                                            borderRadius: BorderRadius.circular(13.0),
                                            child: Image.network(searchSnapshot.documents[0].data["PhotoUrl"],
                                                height: 44.0,
                                                width: 44.0,
                                            ),
                                        ),
                          ),
                        ),
                      ),

                      //Dp Add button 
                      Positioned(
                        top: 45,
                        left: 50,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white
                          ),
                          child: Center(child: Icon(Icons.add,color: Colors.black,size: 20,)),
                          
                        ),)
                    
                    
                  ],
                ),
             
             
              ),

                SizedBox(
                height: 14,
              ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 8
                  ),
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: color2
                    ),
                    child: MaterialButton(
                      
                      onPressed: (){
                        editProfile();
                      },
                      child: Text("Edit Profile"),
                    
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                       Text("Donation Info",style: TextStyle(
                          fontSize: 24,
                        ),),
                        Text("Add New",style: TextStyle(
                          fontSize: 14,
                          color: Colors.white54
                        ),),
                        

                        
                      
                    ],
                  ),
                ),



            ],
          ),
    ),


    Positioned(
      bottom: 15,
      left: 0,
      right: 0,
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: color2
                      ),
                      child: MaterialButton(
                        
                        onPressed: (){
                          logOut();

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.exit_to_app),
                            SizedBox(
                              width: 5,
                            ),
                            Text("LogOut"),
                          ],
                        ),
                      
                      )
                     ),
      ),
                   ),
        ],
      ),
    );
  }
}