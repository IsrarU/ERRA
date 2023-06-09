import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userlocation/AddContact.dart';



import 'main.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

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
  @override
  Widget build(BuildContext context) {

    final  myColors = Color(0xFF00695c);
    return Drawer(

      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: myColors,
            child: const DrawerHeader(
              decoration: BoxDecoration(
                // color: myColors,
              ),
              child: Center(child: Text('Emergency Rapid Response',
                  textAlign:TextAlign.center,
                  style:TextStyle(color: Colors.white, fontSize: 20.0))),
            ),
          ),
          ListTile(
            leading: Icon(
                Icons.account_circle,size: 30.0
            ),
            title: const Text('Add Contact',style: TextStyle(fontSize: 20.0),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddContact()));
            },
          ),
          ListTile(
            leading: Icon(
                Icons.add_alert_rounded,size: 30.0
            ),
            title: const Text('Emergency',style: TextStyle(fontSize: 20.0),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "Emergency Rapid Response")));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.people,size: 30.0,
            ),
            title: const Text('Profile',style: TextStyle(fontSize: 20.0),),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: Icon(
              Icons.logout,size: 30.0,
            ),
            title: const Text('Logout',style: TextStyle(fontSize: 20.0),),
            onTap: () async{
              // await preferences!.setString("email", "");
              // WidgetsBinding.instance!.addPostFrameCallback((_) {
              //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => login()));
              // });
            },
          ),
        ],
      ),
    );
  }
}
