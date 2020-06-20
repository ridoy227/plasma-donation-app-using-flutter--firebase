import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plasmadonation/color.dart';
import 'package:plasmadonation/helper/helper.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {


    String email;

  HelperFunctions _helperFunctions = HelperFunctions();
  QuerySnapshot searchSnapshot;
  Color color1 = HexColor("#010022");
  Color color2 = HexColor("#152755");
  Color color3 = HexColor("#100F51");
  
    @override
  void initState() {
    super.initState();
    this.datastore();
  }
  bool name = true;
  bool phone = true;
  bool blood = true;
  bool area = true;
  bool progress = true;
  Color color4 = HexColor("#1C5E8D");
  TextEditingController namefld = TextEditingController();
  TextEditingController phonefld = TextEditingController();
  TextEditingController bloodfld = TextEditingController();
  TextEditingController areafld = TextEditingController();

  nameEdit(){


    Firestore.instance
            .collection('users')
            .document(email)
            .updateData({
              "name": namefld.text

            }).then((result){
                  
                  setState(() {
                    name = true;
                    datastore();
                  });
            }).catchError((onError){
             print(onError);
            });






  }
  phoneEdit(){
    
    Firestore.instance
            .collection('users')
            .document(email)
            .updateData({
              "Phone": phonefld.text

            }).then((result){
                  
                  setState(() {
                    phone = true;
                    datastore();
                  });
            }).catchError((onError){
             print(onError);
            });






  }
  bloodEdit(){
    
    Firestore.instance
            .collection('users')
            .document(email)
            .updateData({
              "Blood": bloodfld.text.toUpperCase()

            }).then((result){
                  
                  setState(() {
                    blood = true;
                    datastore();
                  });
            }).catchError((onError){
             print(onError);
            });







  }
  areaEdit(){
    
    Firestore.instance
            .collection('users')
            .document(email)
            .updateData({
              "Area": areafld.text

            }).then((result){
                  
                  setState(() {
                    area = true;
                    datastore();
                  });
            }).catchError((onError){
             print(onError);
            });







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
         progress = false;
         print( sanpshot.documents[0].data["Email"] );

       });
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: progress !=false? Container(
            decoration: BoxDecoration(
                                
                                color: color3
                              ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,

            child: Center(child: CircularProgressIndicator(),)) : SingleChildScrollView(
                      child: Container(
              decoration: BoxDecoration(
                                
                                color: color3
                              ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child:  
                      Column(
                        
                      children: <Widget>[
                        SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_back),
                   onPressed: (){
                     Navigator.of(context).pushReplacementNamed("profile");
                   }
                   ),
                  Text("Edit Profile",style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: .5
                  ),
                  ),
                  IconButton(icon: Icon(Icons.info),
                   onPressed: (){
                     
                   }
                   )
                ],
              ),
              SizedBox(
                height: 8,
              ),


                        Container(
                              height: MediaQuery.of(context).size.height/2,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: color2
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                             
                                               Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: name !=true? Container(
                            
                            width: MediaQuery.of(context).size.width/1.5,
                            child: TextField(
                              
                              controller: namefld,
                              decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon( Icons.cancel),
                              
                              onPressed: () {
                                setState(() {
                                     name = true;
                                });
                              },),
                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color4),
                          
                          ),
                          border: const OutlineInputBorder(),
                          
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                          hintText: "Enter New Name",hintStyle: TextStyle(
                            fontSize: 14,
                            
                            
                          ),
                       
                          
                          
                        ),
                              

                            ),
                          ) :Text("Name : "+searchSnapshot.documents[0].data["name"],
                                                  style: TextStyle(
                                                    fontSize: 18
                                                  ),
                                                    overflow: TextOverflow.clip,
                                                                                         
                                                   ),
                                                ),
                                                name != false? GestureDetector(
                                                  onTap:(){
                                                    setState(() {
                                                      name = false;
                                                      
                                                    });

                                                    
                                                    
                                                  } ,
                                          child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: color3
                                            
                                          ),
                                          child: Icon( 
                                            Icons.edit
                                          ),
                                        ),
                                                ): GestureDetector(
                                                  onTap:(){
                                                    nameEdit();     
                                                  } ,
                                          child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: color3
                                            
                                          ),
                                          child: Icon( 
                                            Icons.done
                                          ),
                                        ),
                                                ),


                                              
                                            ],
                                          ),
                                        ),
                                       
                                        SizedBox(
                                          
                                          height: 8,
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                             
                                               Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: phone !=true? Container(
                            
                            width: MediaQuery.of(context).size.width/1.5,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: phonefld,
                              decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon( Icons.cancel),
                              
                              onPressed: () {
                                setState(() {
                                     phone = true;
                                });
                              },),
                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color4),
                          
                          ),
                          border: const OutlineInputBorder(),
                          
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                          hintText: "Enter New Phone Number",hintStyle: TextStyle(
                            fontSize: 14,
                            
                            
                          ),
                       
                          
                          
                        ),
                              

                            ),
                          ) :Text("Phone : "+searchSnapshot.documents[0].data["Phone"],
                                                  style: TextStyle(
                                                    fontSize: 18
                                                  ),
                                                    overflow: TextOverflow.clip,
                                                                                         
                                                   ),
                                                ),
                                                phone != false? GestureDetector(
                                                  onTap:(){
                                                    setState(() {
                                                      phone = false;
                                                      
                                                    });

                                                    
                                                    
                                                  } ,
                                          child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: color3
                                            
                                          ),
                                          child: Icon( 
                                            Icons.edit
                                          ),
                                        ),
                                                ): GestureDetector(
                                                  onTap:(){
                                                    phoneEdit();
                                                  } ,
                                          child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: color3
                                            
                                          ),
                                          child: Icon( 
                                            Icons.done
                                          ),
                                        ),
                                                ),


                                              
                                            ],
                                          ),
                                        ),
                                       
                                        SizedBox(
                                          height: 8,
                                        ),
Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                             
                                               Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: blood !=true? Container(
                            
                            width: MediaQuery.of(context).size.width/1.5,
                            child: TextField(
                              
                              controller: bloodfld,
                              decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon( Icons.cancel),
                              
                              onPressed: () {
                                setState(() {
                                     blood = true;
                                });
                              },),
                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color4),
                          
                          
                          ),
                          border: const OutlineInputBorder(),
                          
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                          hintText: "Enter Blood Group",hintStyle: TextStyle(
                            fontSize: 14,
                            
                            
                          ),
                       
                          
                          
                        ),
                              

                            ),
                          ) :Text("Blood : "+searchSnapshot.documents[0].data["Blood"],
                                                  style: TextStyle(
                                                    fontSize: 18
                                                  ),
                                                    overflow: TextOverflow.clip,
                                                                                         
                                                   ),
                                                ),
                                                blood != false? GestureDetector(
                                                  onTap:(){
                                                    setState(() {
                                                      blood = false;
                                                      
                                                    });

                                                    
                                                    
                                                  } ,
                                          child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: color3
                                            
                                          ),
                                          child: Icon( 
                                            Icons.edit
                                          ),
                                        ),
                                                ): GestureDetector(
                                                  onTap:(){
                                                    bloodEdit();
                                                  } ,
                                          child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: color3
                                            
                                          ),
                                          child: Icon( 
                                            Icons.done
                                          ),
                                        ),
                                                ),


                                              
                                            ],
                                          ),
                                        ),
                                       
                                        SizedBox(
                                          height: 8,
                                        ),
Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                             
                                               Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: area !=true? Container(
                            
                            width: MediaQuery.of(context).size.width/1.5,
                            child: TextField(
                              controller: areafld,
                              decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon( Icons.cancel),
                              
                              onPressed: () {
                                setState(() {
                                     area = true;
                                });
                              },),
                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color4),
                          
                          ),
                          border: const OutlineInputBorder(),
                          
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                          hintText: "Enter New Area",hintStyle: TextStyle(
                            fontSize: 14,
                            
                            
                          ),
                       
                          
                          
                        ),
                              

                            ),
                          ) :Text("Area : "+searchSnapshot.documents[0].data["Area"],
                                                  style: TextStyle(
                                                    fontSize: 18
                                                  ),
                                                    overflow: TextOverflow.clip,
                                                                                         
                                                   ),
                                                ),
                                                area != false? GestureDetector(
                                                  onTap:(){
                                                    setState(() {
                                                      area = false;
                                                      
                                                    });

                                                    
                                                    
                                                  } ,
                                          child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: color3
                                            
                                          ),
                                          child: Icon( 
                                            Icons.edit
                                          ),
                                        ),
                                                ): GestureDetector(
                                                  onTap:(){
                                                    areaEdit();

                                                    
                                                    
                                                  } ,
                                          child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: color3
                                            
                                          ),
                                          child: Icon( 
                                            Icons.done
                                          ),
                                        ),
                                                ),


                                              
                                            ],
                                          ),
                                        ),
                                       




                                      ],
                                    ),
                                  )
                                ],
                              )
                          ),
                          


                        
                        
                      ],
                    ),
                 
                 
                 
                  ),
          ),
    );
  
  
  }
}