import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gmcr_app/user.dart';
import 'package:intl/intl.dart';
final primaryColor = Colors.deepPurpleAccent[400];

class ComplaintList extends StatefulWidget {
  final User user;
  const ComplaintList({this.user, Key key}) : super(key: key);
  @override
  _ComplaintListState createState() => _ComplaintListState();
}

class _ComplaintListState extends State<ComplaintList> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Complaint List'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('users')
                    .document(widget.user.uid)
                    .collection('Complaints List')
//                      .orderBy('date',descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Stack(
                      children: <Widget>[
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            controller: scrollController,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              final id = snapshot.data.documents[index].data['id'];
                              final name = snapshot.data.documents[index].data['date'];
                              return Card(
                                elevation: 5,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.edit_attributes,
                                    color: Colors.green,
                                    size: 50,
                                  ),
                                  title: Text('Complaint Id : $id'),
                                  subtitle: Text('Date : $name'),
                                ),
                              );
                            }),
                      ],
                    );
                  } else {
                    return
                      Container(
                          child: Center(
                            child: Text("You Don't Have Any Complaints",
                      style: TextStyle(color: Colors.white),
                    ),
                          ),
                      );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
