import 'package:ai_music_app/HomePage.dart';
import 'package:ai_music_app/screens/Register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login extends StatefulWidget {
  //  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVisible;
  TextEditingController emailCont = new TextEditingController();
  TextEditingController passCont = new TextEditingController();

  String _email, _password;

  // String? errorMessage;

  // checkAuthentification() async {
  //   _auth.onAuthStateChanged.listen((user) {
  //     if (user != null) {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => HomePage()));
  //     }
  //   });

  //   @override
  //   void initState() {
  //     super.initState();
  //     this.checkAuthentification();
  //   }
  // }

  // login() async {
  //   if (_formKey.currentState.validate()) {
  //     _formKey.currentState.save();

  //     try {
  //       UserCredential user = await _auth.signInWithEmailAndPassword(
  //           email: _email, password: _password);
  //     } catch (e) {
  //       showError(e.errorMessage);
  //     }
  //   }
  // }

  // showError(String errorMessage) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("ERROR"),
  //           content: Text(errorMessage),
  //           actions: <Widget>[
  //             FlatButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text("OK"),
  //             )
  //           ],
  //         );
  //       });
  // }

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  Widget build(BuildContext context) {
    final _email = TextFormField(
      autofocus: false,
      controller: emailCont,
      keyboardType: TextInputType.emailAddress,
      // validator: (){};
      // onSaved: (value) {
      //   emailController.text = value;
      // },

      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        fillColor: Color(0xffffff),
        focusColor: Color(0xffffff),
        hoverColor: Color(0xffffff),
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
      //   passwordController.text = value;
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
        hintStyle: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        labelText: 'Password',
        labelStyle: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        prefixIcon: Icon(Icons.vpn_key_rounded, color: Colors.white),
      ),
      obscureText: true,
      style: TextStyle(
        fontSize: 17,
        color: Colors.white,
      ),
    );

    final loginButton = Material(
      color: Color(0xFF80CED3),
      elevation: 5,
      child: MaterialButton(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        onPressed: () async {
          if (emailCont.text != null && passCont.text != null) {
            var collectionRef = FirebaseFirestore.instance.collection('users');
            var docu =
                await collectionRef.doc(emailCont.text.toLowerCase()).get();
            // var users = await collectionRef.doc(emailCont.text).snapshots();
            bool check = docu.exists;
            var dc = docu.data();
            if (check) {
              if (dc['pass'] == passCont.text) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('email', emailCont.text.toLowerCase());
                prefs.setString('pass', passCont.text);

                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              } else {
                Fluttertoast.showToast(
                    msg: "Wrong Password",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0);
                print('wrong data');
              }
            } else {
              //email dosent exist
              Fluttertoast.showToast(
                  msg: "Invalid Fields",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          } else {
            Fluttertoast.showToast(
                msg: "Enter All Fields",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        child: Text(
          "LOGIN",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("AI Music App"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: 800,
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
                    "LOGIN",
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
                        _email,
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          margin: EdgeInsets.only(left: 20, right: 10),
                          // child: TextFormField(
                          //     validator: (input) {
                          //       if (input.isEmpty) return 'Enter EmailId';
                          //     },
                          //     onSaved: (input) => _email = input),
                        ),
                        SizedBox(width: 80),
                        SizedBox(height: 10),
                        _password,
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 10),
                          // child: TextFormField(
                          //     validator: (input) {
                          //       if (input.isEmpty) return 'Enter Password';
                          //       if (input.length < 8)
                          //         return '8 Characters needed';
                          //     },
                          //     onSaved: (input) => _password = input),
                        ),
                        SizedBox(height: 50),
                        loginButton,
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Haven't signed up? Please Sign Up ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()));
                              },
                              child: Text(
                                " Sign Up",
                                style: TextStyle(
                                  color: Color(0xFF80CED3),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        ),
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
