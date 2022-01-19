import 'package:ai_music_app/NavigationBar.dart';
import 'package:ai_music_app/screens/Login.dart';
import 'package:ai_music_app/tabs/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ai_music_app/screens/Start.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  // const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // final firstNameEditingController = new TextEditingController();
  // final lastNameEditingController = new TextEditingController();
  // final emailEditingController = new TextEditingController();
  // final passwordEditingController = new TextEditingController();
  // final confirmPasswordEditingController = new TextEditingController();

  bool _passwordVisible;

  TextEditingController emailCont = new TextEditingController();
  TextEditingController passCont = new TextEditingController();
  TextEditingController nameCont = new TextEditingController();

  bool isObsecure = true;
  // File _image;
  bool isloading = false;
  bool userValid = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  Widget build(BuildContext context) {
    final firstName = TextFormField(
      autofocus: false,
      controller: nameCont,
      keyboardType: TextInputType.name,
      // validator: (){};
      // onSaved: (value) {
      //   nameCont.text = value;
      // },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        labelText: 'Name',
        labelStyle: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        prefixIcon: Icon(Icons.person, color: Colors.white),
      ),
      style: TextStyle(
        fontSize: 17,
        color: Colors.white,
      ),
    );

    final _email = TextFormField(
      autofocus: false,
      controller: emailCont,
      keyboardType: TextInputType.emailAddress,
      // validator: (){};
      // onSaved: (value) {
      //   emailCont.text = value;
      // },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        labelText: 'Email ID',
        labelStyle: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        prefixIcon: Icon(Icons.email_rounded, color: Colors.white),
      ),
      style: TextStyle(
        fontSize: 17,
        color: Colors.white,
      ),
    );

    final _password = TextFormField(
      autofocus: false,
      controller: passCont,

      // validator: (){};
      // onSaved: (value) {
      //   passwordEditingController.text = value;
      // },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.white),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            }),
        prefixIcon: Icon(Icons.vpn_key_rounded, color: Colors.white),
        hintStyle: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        labelText: 'Password',
        labelStyle: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
      ),

      style: TextStyle(
        fontSize: 17,
        color: Colors.white,
      ),
    );

    final registerButton = Material(
      color: Color(0xFF80CED3),
      elevation: 5,
      child: MaterialButton(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        onPressed: () async {
          print("Registering Button Clicked");

          //check if email is valid
          bool emailValid =
              RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                  .hasMatch(emailCont.text);
          print(emailValid);

          //check user exist
          bool check = false;

          var collectionRef = FirebaseFirestore.instance.collection('users');
          var docu = await collectionRef.doc(emailCont.text).get();
          // var users = await collectionRef.doc(emailCont.text).snapshots();
          check = docu.exists;
          if (check) {
            Fluttertoast.showToast(
                msg: "User Already Exist please Login",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            if (emailValid) {
              if (nameCont.text != null &&
                      nameCont.text != '' &&

                      // usernameCont.text != '' &&
                      emailCont.text != null &&
                      // emailCont.text != '' &&
                      passCont.text != null
                  // &&
                  // passCont.text != ''
                  ) {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(emailCont.text)
                    .set({
                  'email': emailCont.text.toLowerCase(),
                  'name': nameCont.text,
                  'pass': passCont.text,
                  'photo':
                      'https://www.cybersport.ru/assets/img/no-photo/user.png',

                  // 'phone': phoneCont.text == null
                  //     ? 'Enter Phone Number'
                  //     : phoneCont.text,
                  // // 'birthdate': 'Enter Birth Date',
                  'extra': 0,
                  'Privacy': 0,
                  'extra1': 'abc',
                  'val': 'value',
                  // 'locality': locality,

                  'searchname': nameCont.text.toLowerCase(),
                  // 'lat': lat == null ? 34.0479 : lat,
                  // 'lng': lng == null ? 100.6197 : lng,
                  // 'address': Add == null || Add == '' ? 'Address' : Add
                  // .substring(0, 50)
                  // ,
                }).then((value) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('email', emailCont.text.toLowerCase());
                  prefs.setString('pass', passCont.text);
                  // prefs.setString('name', nameCont.text);
                  // prefs.setString('username', usernameCont.text);
                  prefs.setBool('theme', true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                }).catchError((e) {
                  Fluttertoast.showToast(
                      msg:
                          "Error Registering🙁! Please Try Again After Sometime",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                });
              } else {
                print(nameCont.text);

                print(emailCont.text);
                print(passCont.text);
                Fluttertoast.showToast(
                    msg: "Please Enter All Field",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0);
                print('enter all fields');
              }
            } else {
              Fluttertoast.showToast(
                  msg: "Enter valid Email Address",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        child: Text(
          "REGISTER",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("AI Music App"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF343434),
                  Color(0xFF343434),
                  Color(0xFF832078),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.all(40.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 100),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/icon.png'),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                      color: Color(0xFF80CED3),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        firstName,
                        SizedBox(height: 10),
                        _email,
                        SizedBox(height: 10),
                        _password,
                        SizedBox(height: 50),
                        registerButton,
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Already have an account? Please Sign In",
                              style: TextStyle(
                                // textAlign: TextAlign.Center,
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: Text(
                                " Sign In",
                                style: TextStyle(
                                  color: Color(0xFF80CED3),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
