import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:userlocation/ShowContact.dart';
import 'DbHelper.dart';


class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController name = TextEditingController();
  TextEditingController Number = TextEditingController();

  final dbHelper = DatabaseHelper.instance.database;
  // final helper = DatabaseHelper.instance.initDatabase();
  @override
  Widget build(BuildContext context) {
    ProgressDialog dialog = new ProgressDialog(context, title: Text("Add Contact !"), message: Text("Please wait ... "));
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
        backgroundColor: Colors.teal[900],elevation: 10.0,
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
                      'Add Emergency Responder',
                      style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.w500,
                          fontSize: 26),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Add Contact',
                      style: TextStyle(color:Colors.deepOrangeAccent, fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),

                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: Number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Number',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              SizedBox(height: MediaQuery.of(context).size.height*0.04,),
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
                                backgroundColor: Colors.teal[900]
                              ),
                              onPressed: (){
                            dialog.show();
                            _insert();
                            dialog.dismiss();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowContact()));
                            print("inserted");
                          }, child: Text("Add")))),
                      SizedBox(width: 10,),
                      Expanded(child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal[900],
                              ),
                              onPressed: (){
                            _query();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowContact()));
                          }, child: Text("Show")))),
                    ],
                  ),
                )

              ],
            )),
      ),
    );
  }




  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.name: name.text.toString(),
      DatabaseHelper.number: Number.text.toString()
    };
    final id = await DatabaseHelper.instance.insert(row);

    debugPrint('inserted row id: $id');
  }

  void _query() async {
    final allRows = await DatabaseHelper.read();
    debugPrint('query all rows:');
    for (final row in allRows!) {
      print(allRows);
    }
  }


  // void _update() async {
  //   // row to update
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnId: 1,
  //     DatabaseHelper.columnName: 'Mary',
  //     DatabaseHelper.columnNumber: 32
  //   };
  //   final rowsAffected = await dbHelper.update(row);
  //   debugPrint('updated $rowsAffected row(s)');
  // }
  //
  // void _delete() async {
  //   // Assuming that the number of rows is the id for the last row.
  //   final id = await dbHelper.queryRowCount();
  //   final rowsDeleted = await dbHelper.delete(id);
  //   debugPrint('deleted $rowsDeleted row(s): row $id');
  // }
}
