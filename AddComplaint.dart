import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:userlocation/ComplaintList.dart';
class AddComplaint extends StatefulWidget {
  const AddComplaint({Key? key}) : super(key: key);

  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController imageController = new TextEditingController();
  XFile? image;

  List _images = [];
  var imagePath = "android/path/media/";

  final ImagePicker picker = ImagePicker();
  var img;

  selectImage(ImageSource media) async
  {
    img = await picker.pickImage(source: media);

     setState(() {
        imagePath = img.toString();
        imageController.text = img.path;
     });
  }
  //we can upload image from camera or from gallery based on parameter
  Future sendImage() async {



    var uri = "https://jafasa.com/WomenSafety/api/addComplaints.php";

    var request = http.MultipartRequest('POST', Uri.parse(uri));


    if(img != null){

      var pic = await http.MultipartFile.fromPath("image", img.path);
      request.fields['title'] = titleController.text;
      request.fields['description'] = descriptionController.text;


      request.files.add(pic);

      await request.send().then((result) {

        http.Response.fromStream(result).then((response) {

          var message = jsonDecode(response.body);

          // show snackbar if input data successfully
          final snackBar = SnackBar(content: Text(message['message']));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          //get new list images
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ComplaintList()));

        });

      }).catchError((e) {

        print(e);

      });
    }

  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[900]),
                    onPressed: () {
                      Navigator.pop(context);
                      selectImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[900]),
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      selectImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog dialog = new ProgressDialog(context, title: Text("Uploading Complaint"), message: Text("Complaint is Uploading . Please wait ..."));
    return Scaffold(
       appBar: AppBar(
         title: Text("Add Complaint"),
         elevation: 10.0,
         backgroundColor: Colors.teal[900],
       ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Add Complaint',
                      style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.w500,
                          fontSize: 26),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Your name will be in secrets',
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 17),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Title',
                    ),

                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: descriptionController,
                    maxLines: 5, //or null

                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Detail',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(height: 8.0,),
                InkWell(
                  onTap: (){
                     myAlert();
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: TextField(
                      controller: imageController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                         suffixIcon: Icon(Icons.photo_camera),
                        labelText: 'Select Image',
                      ),
                      keyboardType: TextInputType.number,
                      enabled: false,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                Text("براہ کرم ! غلط قسم کی معلومات کا اندراج کرنے سے اجتناب کریں-", style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.red),
                ),
                Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal[900],
                                foregroundColor: Colors.white
                              ),
                              onPressed: (){
                            dialog.show();

                            sendImage();


                          }, child: Text("Add Complaint")))),


                    ],
                  ),
                ),

              ],
            )),
      ),
    );
  }

  insertingComplaint()
  {

  }
}

