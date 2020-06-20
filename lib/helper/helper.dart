import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  getlogin()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool name = sp.getBool("check");
    return name;

  }
  getemail()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String name = sp.getString("email");
    return name;

  }
  getname()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String name = sp.getString("name");
    return name;

  }
  getphotourl()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String name = sp.getString("photourl");
    return name;

  }
  getuid()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String name = sp.getString("uid");
    return name;

  }
  setemail(String email)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("email", email);

  }
  setname(String name)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("name", name);

  }
  setphotourl(String photourl)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("photourl", photourl);

  }
  setuid(String uid)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("uid", uid);

  }
  setlogin(bool login)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("check", login);

  }


}