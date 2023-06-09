import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class MissingPersonList extends StatefulWidget {

  const MissingPersonList({Key? key}) : super(key: key);

  @override
  State<MissingPersonList> createState() => _MissingPersonListState();
}

class _MissingPersonListState extends State<MissingPersonList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Missing Person List"),
        elevation: 10.0,
        centerTitle: true,
        backgroundColor: Colors.teal[900],
      ),
      body: FutureBuilder(
        future: getMissingPersonList(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData && !snapshot.hasError)
          {
            List list = snapshot.data as List;
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index)
                {
                  return Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white38,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0)

                      ),

                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network("https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-Vector.png",
                                scale: 10.0,),
                              SizedBox(width: 5.0,),
                              Text(list[index]['uname'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),)
                            ],

                          ),
                          SizedBox(height: 4.0,),
                          Image.network("https://jafasa.com/WomenSafety/assets/img/"+list[index]['image'],
                            height: 230,
                            width: MediaQuery.of(context).size.width,
                            fit:BoxFit.fill,),
                          SizedBox(height: 5.0,),
                          Divider(thickness: 1,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Name", style: TextStyle(fontWeight: FontWeight.bold),),
                              Divider(thickness: 1,),
                              Text(list[index]['name'])
                            ],
                          ),
                          SizedBox(height: 5.0,),
                          Divider(thickness: 1,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Contact",style: TextStyle(fontWeight: FontWeight.bold),),
                              Divider(thickness: 1,),
                              Text(list[index]['contact'])
                            ],
                          ),
                          SizedBox(height: 5.0,),
                          Divider(thickness: 1,),
                          Text("Description", style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 6.0,),
                          Text(list[index]['description'], textAlign: TextAlign.justify,)

                        ],

                      )
                  );;
                });

          }
          else
          {
            return Center(child: CircularProgressIndicator());
          }
        },

      ),
    );;
  }

  getMissingPersonList() async
  {
    String url = "https://jafasa.com/WomenSafety/api/getMissingPerson.php";
    var response = await http.post(Uri.parse(url));
    var data = jsonDecode(response.body);
    print(data);
    return data;

  }
}
