import 'package:flutter/material.dart';
import 'package:plasmadonation/color.dart';
import 'package:plasmadonation/helper/authentication.dart';
import 'package:plasmadonation/helper/database.dart';
import 'package:plasmadonation/helper/helper.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var name,photourl,email;
  String result = "Null";
  bool click = true, progress = false;
  bool covidreport = false;

  TextEditingController phonetext = TextEditingController();
  TextEditingController passwordtext = TextEditingController();
  TextEditingController areatext = TextEditingController();
  TextEditingController usernametext = TextEditingController();
  DatabaseMethod _databaseMethod = DatabaseMethod();
  AuthMethod _authMethod = AuthMethod();
    HelperFunctions _helperFunctions = HelperFunctions();
    int _radiolisten = 0;
  Color color1 = HexColor("#010022");
  Color color2 = HexColor("#152755");
  Color color3 = HexColor("#B4B4B4");
  Color color4 = HexColor("#1C5E8D");
  
  bool ap = false;
  bool an = false;
  bool bp = false;
  bool bn = false;
  bool op = false;
  bool on = false;
  bool abp = false;
  bool abn = false;
  bool showpass = true;
  var uid;
  

  
  

  final formKey = GlobalKey<FormState>();

  

  saveData(){
    if(formKey.currentState.validate()  ){
      
      Map<String, dynamic> userInfo = {
        "Emailname" : name,
        "name" : usernametext.text,

        "Email" : email,
        "password": passwordtext.text,
        "PhotoUrl" : photourl,
        "Phone" : phonetext.text,
        "Area" : areatext.text,
        "Blood" : result,
        "CovidRecovered" : covidreport,
        
      };
      setState(() {
            progress = true;
          });
      _authMethod.signUp(email, passwordtext.text).then((value){
        if(value !=null){
          
          _databaseMethod.uploadUserInfo(userInfo, uid);
          _helperFunctions.setlogin(progress);
          Navigator.of(context).pushReplacementNamed("dashboard");
          

        }
        else{
           setState(() {
        progress = false;
      });
      }


      });


    }

  }
  
  @override
  void initState() {
    this.getid();
    
    super.initState();
  }
  getid()async{
    _helperFunctions.getemail().then((res){
      setState(() {
        email = res;
        uid = res;
      });
      } ).catchError((error) => print(error));

      _helperFunctions.getname().then((res){
      setState(() {
        name = res;
      });
      } ).catchError((error) => print(error));
      _helperFunctions.getphotourl().then((res){
      setState(() {
        photourl = res;
      });
      } ).catchError((error) => print(error));
  }
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: progress !=false? Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color1
        ),
        child: Center(
          child: CircularProgressIndicator(),)) : 
          SingleChildScrollView(
              child:  Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height+99,
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(
                  color: color1
            ),
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    
                    children: <Widget>[
                      SizedBox(
                        height: 30,

                      ),
                      Hero(
                        tag: 'text',
                        child: Text("SignUp",style: 
                        TextStyle(
                          fontSize: 18,
                          letterSpacing: .4,

                        )
                        ,),
                      ),
                      SizedBox(
                        height: 30,

                      ),
                      
                      
                      Form(
                        key: formKey,
                        child: 
                      SingleChildScrollView(
                                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //first name last name field
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text("First and last name",
                              style: TextStyle(
                                fontSize: 14
                              )),
                            ),
                            Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal:10.0 ),
                          child: TextFormField(
                            
                                validator: (val){
                                  return val.isEmpty? "Please Type Your Name":null;
                                },
                                
                                controller: usernametext,
                              keyboardType: TextInputType.text,
                              
                              
                              
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: color4),
                                
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8.0),
                                hintText: "Type Here",
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                
                                ),
                                
                              ),
                          ),
                        ),
                        //password field
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text("Password",
                              style: TextStyle(
                                fontSize: 14
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal:10.0 ),
                              child: TextFormField(
                                validator: (val){
                                  return val.isEmpty || val.length <5? "Please Enter Password 6+ digit":null;
                                },
                                
                                
                              controller: passwordtext,
                              keyboardType: TextInputType.text,
                              obscureText: showpass,

                              decoration: InputDecoration(
                                
                                focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                
                                ),
                                enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: color4),
                                ),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showpass
                                    ? Icons.visibility_off
                                    :  Icons.visibility,
                                    color: showpass !=true? Colors.red:Colors.white,
                                    
                                    ),
                                    
                                    onPressed: () {
                                      setState(() {
                                          showpass = !showpass;
                                      });
                                    },),
                                contentPadding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8),
                                hintText: "Type Here",
                                border: const OutlineInputBorder(),
                                
                              ),
                              
                        ),
                            ),
                            //phone number field
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text("Phone Number",
                              style: TextStyle(
                                fontSize: 14
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal:10.0 ),
                              child: TextFormField(
                               
                                validator: (val){
                                  return val.isEmpty || val.length <11? "Phone Number Must be Contain 11 Numbers":null;
                                },
                                
                                controller: phonetext,
                              keyboardType: TextInputType.number,
                              
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                
                                ),
                                enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: color4),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8),
                                hintText: "Type Here",
                                border: const OutlineInputBorder(),
                                
                              ),
                        ),
                            ),
                            //area name field 
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0 ),
                              child: Text("Location",
                              style: TextStyle(
                                fontSize: 14
                              ),),
                            ),                 
                            Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal:10.0 ),
                          child: TextFormField(
                            
                            
                                validator: (val){
                                  return val.isEmpty? "Please Type Your Area Name":null;
                                },
                                
                                controller: areatext,
                              keyboardType: TextInputType.text,
                              
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.location_on),
                                focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                
                                ),
                                enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: color4),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8),
                                hintText: "Area Name",
                                border: const OutlineInputBorder(),
                              ),
                          ),
                        ),


                        //blood group
                        Column(children: <Widget>[
                          Text("Blood Group  "+result),
                          Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          result = "A+";
                                          ap = true;
                                            an = false;
                                            bp = false;
                                            bn = false;
                                            op = false;
                                            on = false;
                                            abp = false;
                                            abn = false;
                                        });
                                      },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            height: 25,
                                            width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: ap != false? color3:color2 
                                            

                                            
                                          ),
                                          child: Center(
                                            child: Text("A+",style: TextStyle(color: Colors.white,
                                            fontSize: 18
                                            ),),
                                          ),
                                      ),
                                        ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            result = "A-";
                                            ap = false;
                                            an = true;
                                            bp = false;
                                            bn = false;
                                            op = false;
                                            on = false;
                                            abp = false;
                                            abn = false;
                                          });
                                        },
                                          child: Container(
                                          height: 25,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: an !=false? color3: color2
                                          ),
                                          child: Center(
                                            child: Text("A-",style: TextStyle(color: Colors.white,
                                            fontSize: 18
                                            ),),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            result = "B+";
                                            ap = false;
                                            an = false;
                                            bp = true;
                                            bn = false;
                                            op = false;
                                            on = false;
                                            abp = false;
                                            abn = false;
                                          });
                                        },
                                          child: Container(
                                          height: 25,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: bp != false? color3:color2
                                          ),
                                          child: Center(
                                            child: Text("B+",style: TextStyle(color: Colors.white,
                                            fontSize: 18
                                            ),),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            result = "B-";
                                            ap = false;
                                            an = false;
                                            bp = false;
                                            bn = true;
                                            op = false;
                                            on = false;
                                            abp = false;
                                            abn = false;
                                          });
                                        },
                                          child: Container(
                                          height: 25,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: bn !=false? color3: color2
                                          ),
                                          child: Center(
                                            child: Text("B-",style: TextStyle(color: Colors.white,
                                            fontSize: 18
                                            ),),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            result = "O+";
                                            ap = false;
                                            an = false;
                                            bp = false;
                                            bn = false;
                                            op = true;
                                            on = false;
                                            abp = false;
                                            abn = false;
                                          });
                                        },
                                          child: Container(
                                          height: 25,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: op != false? color3 : color2
                                          ),
                                          child: Center(
                                            child: Text("O+",style: TextStyle(color: Colors.white,
                                            fontSize: 18
                                            ),),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            result = "O-";
                                            ap = false;
                                            an = false;
                                            bp = false;
                                            bn = false;
                                            op = false;
                                            on = true;
                                            abp = false;
                                            abn = false;
                                          });
                                        },
                                          child: Container(
                                          height: 25,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: on != false? color3:color2
                                          ),
                                          child: Center(
                                            child: Text("O-",style: TextStyle(color: Colors.white,
                                            fontSize: 18
                                            ),),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            result = "AB+";
                                            ap = false;
                                            an = false;
                                            bp = false;
                                            bn = false;
                                            op = false;
                                            on = false;
                                            abp = true;
                                            abn = false;
                                          });
                                        },
                                          child: Container(
                                          height: 25,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: abp != false? color3:color2
                                          ),
                                          child: Center(
                                            child: Text("AB+",style: TextStyle(color: Colors.white,
                                            fontSize: 18
                                            ),),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            result = "AB-";
                                            ap = false;
                                            an = false;
                                            bp = false;
                                            bn = false;
                                            op = false;
                                            on = false;
                                            abp = false;
                                            abn = true;
                                          });
                                        },
                                          child: Container(
                                          height: 25,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: abn != false? color3:color2
                                          ),
                                          child: Center(
                                            child: Text("AB-",style: TextStyle(color: Colors.white,
                                            fontSize: 18
                                            ),),
                                          ),
                                        ),
                                      ),
                                    ),




                                  ],
                                )),

                                //end of blood group

                                //this is covid status button
                                Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text("Covid-19 Recovered"),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[

                                        
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Radio(
                                            onChanged: (val){
                                              setState(() {
                                                _radiolisten = 1;
                                                covidreport = true;
                                                
                                              });

                                            },
                                            groupValue: _radiolisten ,
                                            value: 1,
                                            activeColor: color3,
                                            
                                            ),
                                            Text("YES"),
                                            Radio(
                                            onChanged: (val){
                                              setState(() {
                                                _radiolisten = 2;
                                                covidreport = false;
                                                
                                              });

                                            },
                                            groupValue: _radiolisten,
                                            value: 2,
                                            activeColor: color3,
                                            
                                            ),
                                            Text("NO"),
                                            SizedBox(
                                              width: 8,
                                            )
                                            ],
                                          ),
                                        )


                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),

                                //this is save button
                                GestureDetector(
                                  onTap: (){
                                    saveData();
                                  },
                                  child: Container(
                                  height: 35,
                                  width: MediaQuery.of(context).size.width-20,
                                  decoration: BoxDecoration(
                                    color: color2,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Center(
                                     child: Text('Save')
                                  ),
                              ),
                                ),
                              
                             
                            
                          
                          





                        ],)



                          ],
                        ),
                      )
                      )

                    ],
                ),
            
          ),
        ),
              ),
              
              
      ),
    );
  
  }
}