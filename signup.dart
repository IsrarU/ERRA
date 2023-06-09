import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:http/http.dart' as http;
import 'package:userlocation/sign_in_5.dart';


class registraton extends StatefulWidget {
  const registraton({Key? key}) : super(key: key);

  @override
  State<registraton> createState() => _registratonState();
}

class _registratonState extends State<registraton> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  late ProgressDialog dialog;
  bool _obsxureText = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    new ProgressDialog(context,
        title: Text("Sign Up "), message: Text("User Registration. Please wait ..."));
    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.teal[900],
              width: MediaQuery.of(context).size.width,
              height:172.0,
              padding: EdgeInsets.fromLTRB(50.0, 50.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text("SIGN UP ERRA",style: TextStyle(color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.bold),),
                      SizedBox(width: 10.0,),
                      Image.asset("assets/images/erraLogo.png",width: 90.0,height: 90.0,color: Colors.white,),
                    ],
                  )
                ],
              ),
            ) ,
            Container(
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
                      SizedBox(height: 30.0,),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text("Name",style: TextStyle(color: Colors.teal[900],fontSize: 25.0,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 5.0,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: nameController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text("Email",style: TextStyle(color: Colors.teal[900],fontSize: 25.0,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 5.0,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )
                        ),
                      ),
                      SizedBox(height: 10.0,),
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
                      SizedBox(height: 10.0,),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text("Contact",style: TextStyle(color: Colors.teal[900],fontSize: 25.0,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 5.0,),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: contactController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: "Contact",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )
                        ),
                      ),
                      SizedBox(height: 40.0,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Column(
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

                                  UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: emailController.text, password: passController.text);

                                  var url = "https://jafasa.com/WomenSafety/api/registerUser.php";
                                  var response = await http.post(Uri.parse(url), body: {
                                    "email": emailController.text.toString().trim(),
                                    "contact": contactController.text.toString().trim(),
                                    "password": passController.text.toString().trim(),
                                    "name": nameController.text.toString().trim()
                                  });
                                  String data = jsonDecode(response.body);

                                  if (data == "success") {
                                    dialog.dismiss();
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => login()));

                                  } else if (data == "failed") {
                                    dialog.dismiss();
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Registration Failed ")));
                                  }

                                },
                                child: Text("SIGN IN",style: TextStyle(fontSize: 20.0),)),
                            SizedBox(height: 20.0,),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("continue with",style: TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),),
                                      InkWell(
                                          onTap: ()
                                          {
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login()));
                                          },
                                          child: Text("Sign in",style: TextStyle(color: Colors.red,fontSize: 15.0,fontWeight: FontWeight.bold),)),
                                      SizedBox(height: 40.0,),
                                    ],
                                  )

                                ],
                              ),

                            )
                          ],
                        ),
                      )
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
