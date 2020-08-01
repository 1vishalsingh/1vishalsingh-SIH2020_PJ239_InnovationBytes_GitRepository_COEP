import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gmcr_app/home.dart';
import 'package:gmcr_app/register_page.dart';
import 'package:gmcr_app/user.dart';

final primaryColor = Colors.deepPurpleAccent[400];

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String phoneCodeSent, verificationID;
  final _phone = TextEditingController();
  final _code = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool circuler = false;
  bool verifyotp = true;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: primaryColor,
        body: circuler ? Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ) : Container(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: verifyotp
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 120,
                    ),
                    CircleAvatar(
                      radius: 50,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            letterSpacing: 0,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                              prefixText: '+91 ',
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Enter phone num'),
                          validator: (value) {
                            if (value.length != 10) {
                              return 'mobail Number must be of 10 digit ';
                            } else {
                              return null;
                            }
                          },
                          controller: _phone,
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          color: Colors.blue,
                          iconSize: 40,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            setState(() {
                              circuler = true;
                            });
                            Navigator.pop(context);
                          },
                        ),
                        RaisedButton(
                          focusElevation: 5,
                          elevation: 10,
                          splashColor: Colors.lightBlueAccent,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Text(
                            'Verify OTP',
                            style: TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                          color: Colors.blue,
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate()) {
                                      setState(() {
                                        circuler = true ;
                                      });
                                String phoneNum = "+91" + _phone.text.trim();
                                verifyPhone(phoneNum);
                              }
                            });
                          },
                        ),
                      ],
                    )
                  ],
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 120,
                    ),
                    CircleAvatar(
                      radius: 50,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: TextFormField(
                        style: TextStyle(letterSpacing: 5, fontSize: 20),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter OTP',
                          hintStyle: TextStyle(letterSpacing: 0),
                        ),
                        maxLength: 6,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.phone,
                        controller: _code,
                        validator: ((value) {
                          if (value.length != 6)
                            return 'please enter correct otp';
                          return null;
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          color: Colors.blue,
                          iconSize: 40,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            setState(() {
                              verifyotp = true;
                            });
                          },
                        ),
                        RaisedButton(
                          child: Text('Done'),
                          color: Colors.lightBlueAccent,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                circuler = true ;
                              });
                              String smsCode = _code.text;
                              signInWithOtp(smsCode, verificationID);
                            }
                          },
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  void verifyPhone(String phoneNum) async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential authResult) {
      signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed = (AuthException error) {
      print('$error.message');
    };

    final PhoneCodeSent phoneCodeSent =
        (String verID, [int forcedResend]) async {
      this.verificationID = verID;
      setState(() {
        circuler = false;
        verifyotp = false;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verID) {
      this.verificationID = verID;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNum,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  signIn(AuthCredential authCredential) {
    FirebaseAuth.instance
        .signInWithCredential(authCredential)
        .then((AuthResult currentUser) {
      if (currentUser.user.uid != null) {
        {
          Firestore.instance
              .collection('users')
              .document(currentUser.user.uid)
              .snapshots()
              .listen((event) {
            String number = currentUser.user.phoneNumber;
            String uid = currentUser.user.uid;
            try {
              String number = currentUser.user.phoneNumber;
              String uid = currentUser.user.uid;
              String name = event.data['Name'];
              String email = event.data['email'];
              print(email);
              print(uid);
              final userdetail =
              User(uid: uid, name: name, number: number, email: email);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                        user: userdetail,
                      )));
            } catch (e) {
              final user = Num(num: number, uid: uid);

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterPage(
                        user: user,
                      )));
            }
          });
        }
      }
    }).catchError((error) {
      switch (error.code) {
        case 'ERROR_INVALID_VERIFICATION_CODE':
          {
            Get.snackbar('OTP Verifing', 'Invalid OTP Enter',
                backgroundColor: Colors.blueAccent, colorText: Colors.black);
          }
          break;
        case 'ERROR_SESSION_EXPIRED':
          {
            Get.snackbar('OTP Verifing', 'Time Out Resend Again',
                backgroundColor: Colors.blueAccent, colorText: Colors.black);
          }
          break;
        default:
          {
            Get.snackbar(
              'OTP Verifing',
              'Something Went Wrong',
              backgroundColor: Colors.blueAccent,
              colorText: Colors.black,
            );
          }
          break;
      }
    });
  }

  signInWithOtp(phoneCodeSent, verificationID) {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationID, smsCode: phoneCodeSent);
    signIn(authCredential);
  }
}
