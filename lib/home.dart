import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jelajah/model/peopleModel.dart';
import 'package:jelajah/view/peopleView.dart';

import 'api/api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController peopleController = TextEditingController();

  Future<void> addPeople() async {
    print("asd");
    var response =
        await CallApi().postData({"people": peopleController.text}, "people");
    var body = jsonDecode(response.body);
    print(body);
    if (body['data'] != null) {
      setState(() {
        PeopleView.loadLogs();
      });
    } else if (body['message'] == 'Unauthenticated.') {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("People"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: peopleController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(13.0),
                labelText: "Add data",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                addPeople();
              },
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Container(
                height: 45.0,
                child: Center(
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: PeopleView.loadLogs(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length == 0)
                    return Center(
                        child: Text(
                      "Data tidak ada",
                    ));
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            People x = snapshot.data[i];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(x.name + "" + x.age + x.city),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
