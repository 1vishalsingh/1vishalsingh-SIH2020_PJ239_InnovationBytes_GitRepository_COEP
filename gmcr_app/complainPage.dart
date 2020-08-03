import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmcr_app/user.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:gmcr_app/ComplaintList.dart';
import 'package:intl/intl.dart';

final primaryColor = Colors.amber;
final whitecolor = Colors.white;

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
  final _usernumber = TextEditingController();
  final _inter_number = TextEditingController();
  final _description = TextEditingController();
  var url;
  String _date = 'Select Date';
  String _time = 'Select Time';
  File file;
  String _value;
  String _state;
  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  bool circuler = false;
  bool change = true;
  var size;
  var number;

  @override
  Widget build(BuildContext context) {
    final usernumber = widget.user.number;
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
          backgroundColor: Colors.white,
          body: circuler
              ? Container(
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(width: 20,),
                        Text(
                          'Please wait...',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          _space(20.0),
                          _text(
                              'Enter mobile number on which international \t call received*'),
                          change
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black54),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: Colors.white,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          '  $usernumber',
                                          style: TextStyle(
                                              fontSize: 20, letterSpacing: 1),
                                          textAlign: TextAlign.center,
                                        ),
                                        FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                number = usernumber;
                                                change = false;
                                              });
                                            },
                                            child: Text('change'))
                                      ],
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                      decoration: InputDecoration(
                                        prefixText: '+91 ',
                                        filled: true,
                                        fillColor: Colors.white,
                                        errorStyle: TextStyle(
                                            fontSize: 20, color: Colors.red),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'please enter correct number';
                                        }
                                        return null;
                                      },
                                      controller: _usernumber,
                                    ),
                                  ),
                                ),
                          _space(20.0),
                          _text('Select your operator'),
                          operator(),
                          _space(20.0),
                          _text('Select your State'),
                          countryState(),
                          _space(20.0),
                          _text('Select international number country code'),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            elevation: 1,
                            color: Colors.white54,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  title: _selectedDiologCountry != null
                                      ? _showcountry(_selectedDiologCountry)
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Select  ',
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black54,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Icon(
                                              Icons.arrow_drop_down,
                                              size: 25,
                                              color: Colors.black54,
                                            )
                                          ],
                                        ),
                                  onTap: _country,
                                )
                              ],
                            ),
                          ),
                          _space(20.0),
                          _text('Enter international number'),
                          _textfeild(
                              '', 'Enter Correct Mobile No.', _inter_number),
                          _space(20.0),
                          _text('Select Date and Time when call received'),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton.icon(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                color: Colors.white54,
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
                                icon: Icon(Icons.date_range,
                                    color: Colors.blueAccent),
                                label: Text(
                                  _date,
                                  style: TextStyle(color: Colors.black54),
                                )),
                          ),
                          _space(20.0),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton.icon(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                color: Colors.white54,
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
                          _space(20.0),
                          _text('Brief Description (optional)'),
                          SafeArea(
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: TextFormField(
                                maxLines: 10,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  errorStyle: TextStyle(
                                      fontSize: 20, color: Colors.red),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                controller: _description,
                              ),
                            ),
                          ),
                          _space(30.0),
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
                          _space(20.0),
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
    print(url);
    final idnum = DateTime.now().millisecondsSinceEpoch.toString();
    final idname = (_state[0].toUpperCase() + _state[1].toUpperCase());
    final id = (idname + idnum);
    final date = DateFormat("dd-MM-yyyy").format(DateTime.now());

    await Firestore.instance
        .collection('users')
        .document(uid)
        .collection('Complaints List')
        .document(id)
        .setData({
      'id': id,
      'date': date,
      'authenticate user1': widget.user.number,
      'operator': _value,
      'State': _state,
      'authenticate user2': ('+91 ' + _usernumber.text),
      'froud_person_country_code': codename,
      'froudperson_number': _inter_number.text,
      'call_receive_date': _date,
      'call_receive_time': _time,
      'description' : ('description : '+_description.text),
      'uid': widget.user.uid
    }).then((value) {
      Firestore.instance.collection('Complaints List').document(id).setData({
        'id': id,
        'date': date,
        'authenticate user1': widget.user.number,
        'operator': _value,
        'State': _state,
        'authenticate user2': ('+91 ' + _usernumber.text),
        'froud_person_country_code': codename,
        'froudperson_number': _inter_number.text,
        'call_receive_date': _date,
        'call_receive_time': _time,
        'description' : ('description : '+_description.text),
        'uid': widget.user.uid
      });
    }).then((value) {
      final uid = widget.user.uid;
      final user = User(uid: uid);
      showDialog<void>(
          context: (context),
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: SafeArea(
                child: Row(
                  children: <Widget>[
                    Text('your complaint submitted ',style: TextStyle(fontSize: 15),),
                    Icon(Icons.check_circle,color: Colors.green,)
                  ],
                ),
              ),
              content: Text('Complaint id $id',style: TextStyle(color: Colors.black),),
              actions:

              <Widget>[
                RaisedButton(
                    color: Colors.amber,
                    child: Text('Done'),
                    onPressed: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ComplaintList(
                                user: user,
                              )));
                    })
              ],
            );
          });
    }).catchError((error) {
      setState(() {
        circuler = false;
      });
      print(error);
    });
  }

  operator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.black12,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonFormField<String>(
            icon: Icon(
              Icons.arrow_drop_down,
              size: 25,
              color: Colors.black54,
            ),
            elevation: 15,
            onChanged: (String value) {
              setState(() {
                _value = value;
              });
            },
            hint: Text(
              'Select',
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
            validator: (chack) =>
                chack == null ? 'Please select operator' : null,
          ),
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

  _textfeild(prififtext, String errortext, final _controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: TextFormField(
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: 20,
          ),
          decoration: InputDecoration(
            prefixText: prififtext,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return errortext;
            }
            return null;
          },
          controller: _controller,
        ),
      ),
    );
  }

  _text(headtext) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          headtext,
          style: TextStyle(fontSize: 15, color: Colors.black),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  _space(a) {
    return SizedBox(
      height: a,
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

  countryState() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.black12,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonFormField<String>(
            icon: Icon(
              Icons.arrow_drop_down,
              size: 25,
              color: Colors.black54,
            ),
            elevation: 15,
            onChanged: (String value) {
              setState(() {
                _state = value;
              });
            },
            hint: Text(
              'Select',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 17,
              ),
            ),
            items: <String>[
              'Andra Pradesh',
              'Arunachal Pradesh',
              'Assam',
              'Bihar',
              'Chhattisgarh',
              'Goa',
              'Gujarat',
              'Haryana',
              'Himachal Pradesh',
              'Jammu and Kashmir',
              'Jharkhand',
              'Karnataka',
              'Kerala',
              'Madya Pradesh',
              'Maharashtra',
              'Manipur',
              'Meghalaya',
              'Mizoram',
              'Nagaland',
              'Orissa',
              'Punjab',
              'Rajasthan',
              'Sikkim',
              'Tamil Nadu',
              'Telagana',
              'Tripura',
              'Uttaranchal',
              'Uttar Pradesh',
              'West Bengal',
              'Andaman and Nicobar',
              'Chandigarh',
              'Dadar and Nagar Haveli',
              'Daman and Diu',
              'Delhi',
              'Lakshadeep',
              'Pondicherry',
              'Ladakh',
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
            value: _state,
            validator: (chack) => chack == null ? 'Please select State' : null,
          ),
        ),
      ),
    );
  }
}
