import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userlocation/signup.dart';

import 'GridHome.dart';

class login extends StatefulWidget {

  @override
  State<login> createState() => _loginState();

}

class _loginState extends State<login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  late ProgressDialog dialog;
  bool _obsxureText = true;
  SharedPreferences? preferences;

  FirebaseAuth auth = FirebaseAuth.instance;




  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   initializePreference().whenComplete((){
  //     setState(() {});
  //   });
  //
  //
  //   if(preferences?.getString("email") != "")
  //     {
  //        Navigator.push(context, MaterialPageRoute(builder: (context) => GridHome()));
  //     }
  // }
  // Future<void> initializePreference() async{
  //   this.preferences = await SharedPreferences.getInstance();
  // }
  @override
  Widget build(BuildContext context) {
    ProgressDialog dailog = new ProgressDialog(context, title: Text("Sign In"), message: Text("User Login ..."));
    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.teal[900],
              width: MediaQuery.of(context).size.width,
              height:280.0,
              padding: EdgeInsets.fromLTRB(40.0, 40.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text("SIGN IN ERRA",style: TextStyle(color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.bold),),
                      SizedBox(width: 10.0,),
                      Image.asset("assets/images/erraLogo.png",width: 90.0,height: 90.0,color: Colors.white,),
                    ],
                  )
                ],
              ),
            ) ,
            Container(
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.only(topLeft: Radius.circular(60.0),topRight: Radius.circular(60.0)),
              // ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius:  BorderRadius.only(topLeft: Radius.circular(40.0),topRight: Radius.circular(40.0)),
                ),
                elevation: 26.0,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50.0,),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text("Email",style: TextStyle(color: Colors.teal[900],fontSize: 25.0,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 5.0,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.home),
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )
                        ),
                      ),
                      SizedBox(height: 36.0,),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text("Password",style: TextStyle(color: Colors.teal[900],fontSize: 25.0,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 5.0,),
                      TextFormField(
                        controller: passController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon:  Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              onTap: (){
                                setState((){
                                  _obsxureText = !_obsxureText;
                                },
                                );
                              },
                              child: Icon(_obsxureText?Icons.visibility : Icons.visibility_off),
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )
                        ),
                        obscureText: _obsxureText,
                      ),

                      SizedBox(height: 60.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.only(left: 55.0,right: 55.0,top: 10.0,bottom: 10.0),
                                  backgroundColor: Colors.teal[900],
                                  alignment: Alignment.center,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  )

                              ),
                              onPressed: ()async{

                                dialog = new ProgressDialog(context,
                                    title: Text("Login User .."), message: Text("Please wait ...."));
                                dialog.show();

                                UserCredential userCredential = await auth.signInWithEmailAndPassword(email: emailController.text, password: passController.text);
                                User? user = userCredential.user;

                                if(user != null)
                                {
                                  var url = "https://jafasa.com/WomenSafety/api/userLogin.php";
                                  var response = await http.post(Uri.parse(url), body: {
                                    "email": emailController.text.toString().trim(),
                                    "password": passController.text.toString().trim()
                                  });
                                  String data = jsonDecode(response.body);

                                  if (data == "success") {
                                    dialog.dismiss();
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GridHome()));
                                  } else if (data == "failed") {
                                    dialog.dismiss();

                                    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("Invalid User Login "+data)));

                                  }
                                }


                              },
                              child: Text("SIGN IN",style: TextStyle(fontSize: 20.0),)),
                          SizedBox(height: 50.0,),
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Don't have an account",style: TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),),
                                    InkWell(
                                        onTap: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>registraton()));
                                        },
                                        child: Text("Sign Up",style: TextStyle(color: Colors.red,fontSize: 15.0,fontWeight: FontWeight.bold),)),
                                    SizedBox(height: 41.5,),
                                  ],
                                )

                              ],
                            ),

                          )
                        ],
                      ),

                    ],


                  ),


                ),

              ),
            ),

          ],


        ),
      ),
    );
  }
}
