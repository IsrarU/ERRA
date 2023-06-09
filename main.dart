import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shake/shake.dart';
import 'package:background_sms/background_sms.dart';
import 'package:telephony/telephony.dart';
import 'package:userlocation/splash_screen.dart';
import 'DbHelper.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
}
  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = MyHttpOverrides();
    final dbHelper = DatabaseHelper.instance.database;
    // initialize the database
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    runApp(const MyApp());
  }

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emergency Rapid Response',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    var sms = "";

    final Telephony telephony = Telephony.instance;




  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () async {
        Location location = new Location();

        bool _serviceEnabled;
        PermissionStatus _permissionGranted;
        LocationData _locationData;

        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            return;
          }
        }

        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            return;
          }
        }

        _locationData = await location.getLocation();

        double latitude = _locationData.latitude!;
        double longitude = _locationData.longitude!;
        // double latitude = 33.9838;
        // double longitude = 71.7639;

        var permissionGranted = await telephony.requestPhoneAndSmsPermissions;

        sms = "I am in Trouble. Please Help me /n https://www.google.com/maps/place/$latitude,$longitude";
        List<Map<String, dynamic>>? contactList = await DatabaseHelper.read();
        for(int i = 0; i<contactList!.length; i++) {
          print(contactList[i]['name']);
          print(contactList[i]['number']);

          telephony.sendSms(to: contactList[i]['number'].toString(), message: sms);

          print("Msg sent ");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Shake!'),
            ),
          );
          // Do stuff on phone shake
        }
      },
      minimumShakeCount: 5,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        elevation: 10.0,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[900]
                ),
                onPressed: () async {
              Location location = new Location();

              bool _serviceEnabled;
              PermissionStatus _permissionGranted;
              LocationData _locationData;

              _serviceEnabled = await location.serviceEnabled();
              if (!_serviceEnabled) {
                _serviceEnabled = await location.requestService();
                if (!_serviceEnabled) {
                  return;
                }
              }

              _permissionGranted = await location.hasPermission();
              if (_permissionGranted == PermissionStatus.denied) {
                _permissionGranted = await location.requestPermission();
                if (_permissionGranted != PermissionStatus.granted) {
                  return;
                }
              }

              _locationData = await location.getLocation();

              double latitude = _locationData.latitude!;
              double longitude = _locationData.longitude!;
              // double latitude = 33.9838;
              // double longitude = 71.7639;

              var permissionGranted = await telephony.requestPhoneAndSmsPermissions;
              print("Latitude is $latitude and Longnitude is $longitude");
              print("https://www.google.com/maps/33.9838,71.7639");
              sms = "I am in Trouble. Please Help me /n https://www.google.com/maps/place/$latitude,$longitude";
               List<Map<String, dynamic>>? contactList = await DatabaseHelper.read();
               for(int i = 0; i<contactList!.length; i++) {
               print(contactList[i]['name']);

               telephony.sendSms(to: contactList[i]['number'].toString(), message: sms);
              }
            }
                , child: Text("Send Emergency SMS")),

          ],
        ),
      ),


    );
  }
  _sendSMS() async {
    int _sms = 0;



  }



//  onSendSmsTap()  {
//   FocusScope.of(context).requestFocus(new FocusNode());
//
//     print("Sending SMS");
//     setState(() {
//       _loading = true;
//     });
//
//      telephony.sendSms(
//         to: "03018763644",
//         message: "Good Work ",
//         statusListener: listener
//     );
//   }
// }
// sendMessage() async
// {
//   final Telephony telephony = Telephony.instance;
//   bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
//
//   await telephony.sendSms(
//       to: "0320971337",
//       message: "May the force be with you!"
//   );
//
// }
// Future<void> _makePhonesms(String phoneNumber) async {
//   final Uri launchUri = Uri(
//     scheme: 'sms',
//     path: phoneNumber,
//   );
//   await launchUrl(launchUri);
// }
}
