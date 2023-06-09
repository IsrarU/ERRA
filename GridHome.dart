import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userlocation/AddComplaint.dart';
import 'package:userlocation/AddContact.dart';
import 'package:userlocation/ComplaintList.dart';
import 'package:userlocation/MissingPersonList.dart';
import 'package:userlocation/main.dart';

import 'AddMissingPerson.dart';
import 'NavigationDrawer.dart';

class GridHome extends StatefulWidget {
  const GridHome({Key? key}) : super(key: key);

  @override
  State<GridHome> createState() => _GridHomeState();
}

class _GridHomeState extends State<GridHome> {
  var showtext = ["Add Contact","Emergency", "Add Complaint", "Complaint List",
    "Add Missing Person", "Missing Person List"];
  var showicon = ["assets/images/add-user.png","assets/images/alarm.png","assets/images/alarm.png",
    "assets/images/complain.png", "assets/images/complaint.png",
    "assets/images/confusion.png"];
  @override
  // SharedPreferences? preferences;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   initializePreference().whenComplete(() {
  //     setState(() {});
  //   });
  // }
  //
  // Future<void> initializePreference() async{
  //   this.preferences = await SharedPreferences.getInstance();
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.exit_to_app,color: Colors.red,),
        //     tooltip: 'Exit',
        //     onPressed: () async {
        //       await preferences!.setString("email", "");
        //       WidgetsBinding.instance!.addPostFrameCallback((_) {
        //         Navigator.pushReplacement(
        //             context, MaterialPageRoute(builder: (_) => login()));
        //       },
        //       );
        //     }
        //     )
        // ],
        title: Text("ERRA"),
        elevation: 10.0,
        backgroundColor: Colors.teal[900],
      ),
      drawer: NavigationDrawer(),
      body: GridView.builder(
          itemCount: showtext.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                if(index == 0){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddContact()));
                }
                else if(index == 1){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "Emergency Rapid Response")));
                }
                else if(index == 2)
                {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => AddComplaint()));
                }
                else if(index == 3)
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintList()));
                }
                else if(index == 4)
                  {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => AddMissingPerson()));
                  }
                else if(index ==5)
                  {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MissingPersonList()));
                  }

              },
              child: Card(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.teal[900],
                        child: Image.asset(showicon[index],height: 70.0,width: 70.0,),
                      ),
                      SizedBox(height: 16,),
                      Text(showtext[index],
                        style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
            );
          }),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Colors.red[900],
      //   foregroundColor: Colors.white,
      //   icon: Icon(Icons.exit_to_app),
      //   label: Text('Logout'),
      //   onPressed: () async{
      //    final SharedPreferences pref = await SharedPreferences.getInstance();
      //    pref.remove("email");
      //    Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
      //   },
      // ),
    );
  }
}
