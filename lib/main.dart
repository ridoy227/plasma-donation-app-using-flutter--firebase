import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plasmadonation/color.dart';
import 'package:plasmadonation/helper/helper.dart';
import 'package:plasmadonation/screens/DashBoard.dart';
import 'package:plasmadonation/screens/editprofile.dart';
import 'package:plasmadonation/screens/profile.dart';
import 'package:plasmadonation/screens/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HelperFunctions _helperFunctions = HelperFunctions();
  bool check =false;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }
    getLoggedInState() async {
    await _helperFunctions.getlogin().then((value){

      if(value !=null){
        setState(() {
        check =false;
        check  = value;
        print(value);
      });
      

      }else{
        setState(() {
          check =false;
          
        });
        
      }
      
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Plasma Donation',
      theme: ThemeData.dark(

      ),
      home: check != false ? DashBoard() : MyHomePage(),

    
  routes: {
    'home': (context) => MyHomePage(),
    'signup': (context) => SignUp(),
    'dashboard': (context) => DashBoard(),
    'profile': (context) => Profile(),
    'editprofile': (context) => EditProfile(),
    
    
    
  },
  
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool login = true,progress = false,showpass = true;


  TextEditingController usernametext = TextEditingController();

  TextEditingController passwordtext = TextEditingController();
  final formKey = GlobalKey<FormState>();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  HelperFunctions _helperFunctions = HelperFunctions();
   _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      if( _googleSignIn.currentUser.displayName !=null ){
        _helperFunctions.setemail(_googleSignIn.currentUser.email);
        _helperFunctions.setname(_googleSignIn.currentUser.displayName);
        _helperFunctions.setphotourl(_googleSignIn.currentUser.photoUrl);
        Navigator.of(context).pushNamed("signup");
        
        
      }
    } catch (error) {
      print(error);
      
    }
  }
  Color color1 = HexColor("#010022");
  Color color2 = HexColor("#152755");
  Color color4 = HexColor("#1C5E8D");
  FirebaseAuth _auth = FirebaseAuth.instance;
    signin(){
    if(formKey.currentState.validate()  ){
      setState(() {
            progress = true;
          });

      
      try{
        _auth.signInWithEmailAndPassword(email: usernametext.text, password: passwordtext.text).then((value){
          if(value !=null){
            _helperFunctions.setlogin(login);
            _helperFunctions.setemail(usernametext.text.toString());
            Navigator.of(context).pushReplacementNamed("dashboard");

          }else{
            setState(() {
            progress = false;
          });

          }

        });

      }catch(e){
        print(e);
      }


    }

  }
  
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:SingleChildScrollView(
              child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: color1,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/bgnd.png",fit: BoxFit.fill,),
              ),
              Positioned(
                bottom: 120,
                left: MediaQuery.of(context).size.width/3.2,
                child: Text("Welcome \n to free blood \n donation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 0.8
                ),
                )
                )
                ],
              ),
              Expanded(
                    child: Container(
                    
                    
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: progress !=false? CircularProgressIndicator() : Column(
                        children: <Widget>[
                          SizedBox(
                            height: 25,

                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                              Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Email",
                          style: TextStyle(
                            fontSize: 14
                          )),
                        ),
                        Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal:10.0 ),
                      child: TextFormField(
                        
                            validator: (val){
                              return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                    null : "Enter correct email";
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
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                height: 35,
                                width: 88,
                                decoration: BoxDecoration(
                                  color: color2,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(
                                  child:FlatButton(onPressed: (){
                                    signin();

                                  }, child: Text('Sign In'))
                                ),
                              ),
                          ],
                        ),

                              
                            ],),
                          ),
                          //email field
                        
                                                
                          SizedBox(
                            height: 15,

                          ),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Need Account? " ),
                              GestureDetector(
                                onTap: (){
                                  _handleSignIn();
                                  
                                },
                                child: Hero(
                                  tag: "text",
                                  child: Text("SignUp" ,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18
                                  ) ,
                                  ),
                                ),
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            
            ],

          ),
        ),
      )
    );
  }
}

