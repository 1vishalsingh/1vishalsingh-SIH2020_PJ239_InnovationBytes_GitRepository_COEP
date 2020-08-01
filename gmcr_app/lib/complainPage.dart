import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmcr_app/user.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:gmcr_app/ComplaintList.dart';
import 'package:intl/intl.dart';

final primaryColor = Colors.deepPurpleAccent[400];

class ComplainPage extends StatefulWidget {
  final User user;
  const ComplainPage({this.user, Key key}) : super(key: key);

  @override
  _ComplainPageState createState() => _ComplainPageState();
}

class _ComplainPageState extends State<ComplainPage> {
  Country _selectedDiologCountry;
  final _formKey = GlobalKey<FormState>();
  var codename;
  final _name = TextEditingController();
  final _toperson = TextEditingController();
  final _formperson = TextEditingController();
  final _description = TextEditingController();
  var url;
  String _date = 'Select Date';
  String _time = 'Select Time';
  File file;
  String _value;
  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  bool circuler = false;
  bool filename = false;
  var size;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text('Register Your Complaint'),
          ),
          backgroundColor: primaryColor,
          body: circuler
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          _space(),
                          _space(),

                          Container(child: Column(children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.blueAccent,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                  Text(
                                    '   Your details',
                                    style: TextStyle(fontSize: 15, color: Colors.white),
                                    textAlign: TextAlign.start,
                                  ),
                                    IconButton(icon: Icon(Icons.info_outline,color: Colors.white,),onPressed:(){

                                    profile();

                                    } ,)
                                ],)
                            ),
                            Container(
                              color: Colors.white,
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                                child:Center(child:  Text(widget.user.name,style: TextStyle(color: Colors.black87,fontSize: 20),textAlign: TextAlign.start,),),),
                            Divider(height: 0,color: Colors.blueGrey,),
                            Container(
                              color: Colors.white,
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child:Center(child:  Text(widget.user.email,style: TextStyle(color: Colors.black87,fontSize: 20),textAlign: TextAlign.start,),),),
                            Divider(height: 0,color: Colors.blueGrey,),
                            Container(
                              color: Colors.white,
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child:Center(child:  Text(widget.user.number,style: TextStyle(color: Colors.black87,fontSize: 20),textAlign: TextAlign.start,),),)
                          ],),),
                          Divider(height: 0,color: Colors.blueGrey,),
                          _operator(),
                          _space(),
                          _space(),
                          Container(
                            child: Column(
                              children: <Widget>[
                            _text('Select the country code and enter Mobile number form Grey call received'),
                            Container(
                              color: Colors.white,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ListTile(
                                        title: _selectedDiologCountry != null
                                            ? _showcountry(_selectedDiologCountry)
                                            : Text('Select your country code',style: TextStyle(fontSize: 20,color: Colors.black54,),textAlign: TextAlign.start,),
                                        onTap: _country,
                                      )
                                    ],
                                  ),
                                )),
                                Divider(height:0,color: primaryColor,),
                            _textfeild('Enter international number',
                                'Enter Correct Mobile No.', _formperson),
                          ],),),
                          _space(),
                          _space(),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                              _text('Select Date and Time when call received'),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton.icon(
                                    color: Colors.white,
                                    onPressed: () async {
                                      final DateTime picked = await _selectDate();
                                      if (picked != null && picked != _dateTime) {
                                        setState(() {
                                          _dateTime = picked;
                                          _date =
                                          '${_dateTime.month}-${_dateTime.day}-${_dateTime.year}';
                                        });
                                      }
                                    },
                                    icon: Icon(Icons.date_range, color: Colors.blueAccent),
                                    label: Text(
                                      _date,
                                      style: TextStyle(color: Colors.black54),
                                    )),
                              ),
                              Divider(height:0,color: Colors.blueGrey,),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton.icon(
                                    color: Colors.white,
                                    onPressed: () async {
                                      final TimeOfDay picked = await _selectTime();
                                      if (picked != null && picked != _timeOfDay) {
                                        setState(() {
                                          _timeOfDay = picked;
                                          _time = _timeOfDay.toString();
                                        });
                                      }
                                    },
                                    icon: Icon(Icons.access_time,
                                        color: Colors.blueAccent),
                                    label: Text(
                                      _time,
                                      style: TextStyle(color: Colors.black54),
                                    )),
                              ),
                            ],),
                          ),
                          _space(),
                          _space(),
                          SafeArea(
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),),
                              child: Padding(
                                padding: const EdgeInsets.only(top:10.0,bottom: 10),
                                child: TextFormField(
                                  maxLines: 10,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Describe Your Complains...',
                                      errorStyle: TextStyle(
                                          fontSize: 20, color: Colors.red)),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please Describe Your Complains';
                                    }
                                    return null;
                                  },
                                  controller: _description,
                                ),
                              ),
                            ),
                          ),
                          _space(),
                          _space(),
                          Text('This is optional',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                          _space(),

                          Container(
                            height: 70,
                            width: 140,
                            child: RaisedButton(
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () async {
                                final image = await FilePicker.getFile(
                                  type: FileType.custom,
                                  allowedExtensions: ['jpg', 'pdf'],
                                );
                                setState(() {
                                  file = image;
                                });
                                if(file.lengthSync() <= 2000000){
                                  setState(() {
                                    size = file.toString();
                                    filename=true;
                                  });
                                }else{
                                  setState(() {
                                    size = 'file should be less then 2mb';
                                    filename=true;
                                  });
                                }
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(
                                    Icons.add,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Add file',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          _space(),

                          filename ? Text(size,style: TextStyle(color: Colors.white),) : Container(),

                          _space(),
                          _space(),
                          _space(),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                  focusElevation: 30,
                                  splashColor: Colors.lightBlueAccent,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  color: Colors.lightBlueAccent,
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                        setState(() {
                                          circuler = true;
                                        });
                                        addcomplain();
                                    }
                                  })),
                          _space(),
                          _space(),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> addcomplain() async {
    final uid = widget.user.uid;
    print(uid);
    url = await uploade(file);
    print(url);
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final date = DateFormat("dd-MM-yyyy").format(DateTime.now());

      await Firestore.instance
        .collection('users')
        .document(uid).collection('Complaints List').document(id).setData({
      'id': id,
      'date': date,
      'full_name': _name.text,
      'operator': _value,
      'toperson': ('+91 ' + _toperson.text),
      'from_person_country_code': codename,
      'formperson': _formperson.text,
      'call_receive_date_and_time': (_date + '  ' + _time),
      'description': _description.text,
      'url': url.toString(),
      'uid':widget.user.uid
    }).then((value){
    Firestore.instance.collection('Complaints List').document(id).setData({
      'id': id,
      'date': date,
      'full_name': _name.text,
      'operator': _value,
      'toperson': ('+91 ' + _toperson.text),
      'from_person_country_code': codename,
      'formperson': _formperson.text,
      'call_receive_date_and_time': (_date + '  ' + _time),
      'description': _description.text,
      'url': url.toString(),
      'uid':widget.user.uid
    });
      }).then((value) {
      final id = widget.user.uid;
      final user = User(uid: id);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ComplaintList(
                    user: user,
                  )));
    }).catchError((error){
      setState(() {
        circuler=false;
      });
      print(error);
    });
  }

  _operator() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButtonFormField<String>(
          icon: Icon(
            Icons.arrow_downward,
            color: Colors.black54,
          ),
          elevation: 15,
          onChanged: (String value) {
            setState(() {
              _value = value;
            });
          },
          hint: Text(
            'Select this mob number Operator',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 17,
            ),
          ),
          items: <String>[
            'Airtel',
            'BSNL',
            'Idea',
            'Jio',
            'Vodafone',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            );
          }).toList(),
          value: _value,
          validator: (chack) => chack == null ? 'Please Select Operator' : null,
        ),
      ),
    );
  }

  _selectDate() {
    return showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime.now());
  }

  _selectTime() {
    return showTimePicker(context: context, initialTime: _timeOfDay);
  }

  _textfeild(String labletext, String errortext, final _controller) {
    return TextFormField(
      keyboardType: TextInputType.text,
      style: TextStyle(
        fontSize: 20,
      ),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: labletext,
          errorStyle: TextStyle(fontSize: 20, color: Colors.red)),
      validator: (value) {
        if (value.isEmpty) {
          return errortext;
        }
        return null;
      },
      controller: _controller,
    );
  }

  _text(headtext) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          headtext,
          style: TextStyle(fontSize: 15, color: Colors.white),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  _space() {
    return SizedBox(
      height: 10,
    );
  }

  _country() {
    return showDialog(
        context: context,
        builder: (context) => Theme(
              data: Theme.of(context).copyWith(primaryColor: Colors.blueAccent),
              child: CountryPickerDialog(
                titlePadding: EdgeInsets.all(10),
                searchInputDecoration:
                    InputDecoration(hintText: 'Search Country...'),
                isSearchable: true,
                title: Text('Select Country Code'),
                onValuePicked: (Country country) {
                  setState(() {
                    _selectedDiologCountry = country;
                    codename = ('+' +
                        _selectedDiologCountry.phoneCode +
                        ' ' +
                        _selectedDiologCountry.name);
                  });
                },
                itemBuilder: _showcountry,
              ),
            ));
  }

  Widget _showcountry(Country country) {
    return Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(
          width: 8,
        ),
        Text('+${country.phoneCode}'),
        SizedBox(
          width: 10,
        ),
        Flexible(child: Text(country.name)),
      ],
    );
  }

  Future<String> uploade(File file) async {
    try {
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}');
      StorageUploadTask storageUploadTask = storageReference.putFile(file);
      var url = await (await storageUploadTask.onComplete).ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e);
      return null;
    }
  }

  profile() {
    final num = widget.user.number;
    final uid = widget.user.number;
    final detail = Num(num: num , uid: uid);

    showDialog<void>(
      context: (context),
//       false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('title'),
          content: Text('dialogBody'),
          actions: <Widget>[
            FlatButton(
              child: Text('buttonText'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}
