import 'package:flutter/material.dart';
import 'DbHelper.dart';
class ShowContact extends StatefulWidget {
  const ShowContact({Key? key}) : super(key: key);

  @override
  State<ShowContact> createState() => _ShowContactState();
}

class _ShowContactState extends State<ShowContact> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        elevation: 10.0,
        title: Text("Contacts List"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future:DatabaseHelper.read(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData && !snapshot.hasError)
            {
              List contacts = snapshot.data as List;
              return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(7.0),
                        height: 100,


                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Image.asset("assets/images/add-user.png", scale: 8.0,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                     SizedBox(width: 10.0,),
                                    Text(contacts[index]['name'],
                                      style: TextStyle(fontSize: 18.0, color: Colors.teal,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                SizedBox(height: 20.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    SizedBox(width: 10.0,),
                                    Text("0"+contacts[index]['number'].toString(), style: TextStyle(fontSize: 16.0, color: Colors.teal),),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          else
            {
               return Center(child: Text("No Contact here"),);
            }

        },

      )
    );
  }

}
