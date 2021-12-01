import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:testflutter2/Bloc/User/bloc_login.dart';
import 'package:testflutter2/Bloc/User/event_login.dart';
import 'package:testflutter2/Bloc/User/state_login.dart';
import 'package:testflutter2/screen/phimlist_screen.dart';
import 'package:testflutter2/screen/register_screen.dart';
import '../Animation/_fadeanimation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'forgotpass.dart';

typedef IntCallback = Function(int value);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.title, required this.changeindex})
      : super(key: key);
  final IntCallback changeindex;
  final String title;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String emailKH = '';
  String passwordKH = '';
  bool isLoading = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? user;
  bool _passwordVisible = false;

  Future<void> _handleSignIn() async {
    final googleuser = await _googleSignIn.signIn();
    if (googleuser == null) return;
    user = googleuser;
    final googleAuth = await googleuser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
    debugPrint('Email=$googleuser');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSucess) {
          Navigator.pop(context);
          setState(() {
            isLoading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PhimListScreen(
                      title: LoginSucess().status,
                    )),
          );
        } else if (state is LoginFail) {
          Navigator.pop(context);
          setState(() {
            isLoading = false;
            widget.changeindex(2);
          });
        }
      },
      child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.cyan.shade50,
            //appBar: AppBar(
            //title: Text(widget.title),
            // ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _logo(),
                _pagetittle(),
                _input(),
                Padding(padding: EdgeInsets.only(top: 3.h)),
                _btn(),
                Padding(padding: EdgeInsets.only(top: 1.h)),
                _googlebtn(),
                Padding(padding: EdgeInsets.only(top: 2.h)),
                _register(),
                _forgotpassword(),
              ],
            ),
          )),
    );
  }

  Widget _logo() {
    return SizedBox(
      height: 35.h,
      child: Stack(
        children: <Widget>[
          FadeAnimation(
              delay: 1,
              child: Transform.rotate(
                  angle: -3.14 / 12.0,
                  child: Container(
                    margin: EdgeInsets.only(top: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://rapphimmeme.000webhostapp.com/hinhanh/Phim/2.jpg'),
                          fit: BoxFit.cover),
                    ),
                    width: 40.w,
                    height: 20.h,
                  ))),
          FadeAnimation(
              delay: 1.5,
              child: Transform.rotate(
                  angle: -3.14 / 30.0,
                  child: Container(
                    margin: EdgeInsets.only(left: 26.w, top: 10.h),
                    width: 40.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        image: const DecorationImage(
                            image: NetworkImage(
                                'https://rapphimmeme.000webhostapp.com/hinhanh/Phim/1.jpg'),
                            fit: BoxFit.cover)),
                  )))
        ],
      ),
    );
  }

  Widget _pagetittle() {
    return FadeAnimation(
        delay: 1.8,
        child: Text("Login",
            style: TextStyle(
                color: Colors.blue.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 35.sp)));
  }

  Widget _input() {
    return FadeAnimation(
        delay: 2,
        child: Container(
            margin: EdgeInsets.only(top: 2.h, left: 10.w, right: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.sp),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.blue.shade900,
                      blurRadius: 20,
                      offset: Offset(0, 1.sp))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.blue))),
                  child: TextField(
                      style: TextStyle(
                          color: Colors.blue.shade900, fontSize: 12.sp),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          suffixIcon: Icon(
                            Icons.alternate_email,
                            color: Theme.of(context).primaryColorDark,
                          )),
                      onChanged: (text) {
                        setState(() {
                          emailKH = text;
                        });
                      }),
                ),
                Container(
                  padding: EdgeInsets.all(2.w),
                  child: TextField(
                      obscureText: !_passwordVisible,
                      style: TextStyle(
                          color: Colors.blue.shade900, fontSize: 12.sp),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      onChanged: (text) {
                        setState(() {
                          passwordKH = text;
                        });
                      }),
                ),
              ],
            )));
  }

  Widget _btn() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.black,
            primary: Colors.blue,
            elevation: 10,
            fixedSize: Size(60.w, 6.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.sp))),
          ),
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      "Login",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    content: isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            "Do ya accept ?",
                            style: TextStyle(fontSize: 15.sp),
                          ),
                    actions: isLoading
                        ? <Widget>[]
                        : <Widget>[
                            Row(children: [
                              Padding(padding: EdgeInsets.only(right: 40.w)),
                              TextButton(
                                child: Text(
                                  "Yes",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: Text(
                                                "Login",
                                                style:
                                                    TextStyle(fontSize: 20.sp),
                                              ),
                                              content:
                                                  const CircularProgressIndicator(),
                                              elevation: 24.0,
                                              contentPadding: EdgeInsets.only(
                                                  bottom: 4.h,
                                                  top: 4.h,
                                                  left: 20.w,
                                                  right: 20.w),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.sp))),
                                            ));
                                  });
                                  context
                                      .read<LoginBloc>()
                                      .add(Login(emailKH, passwordKH));
                                },
                              ),
                              Padding(padding: EdgeInsets.only(right: 5.w)),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "No",
                                    style: TextStyle(fontSize: 15.sp),
                                  ))
                            ])
                          ],
                    elevation: 24.0,
                    contentPadding: EdgeInsets.only(
                        bottom: 4.h, top: 4.h, left: 20.w, right: 20.w),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.sp))),
                  )),
          child: FadeAnimation(
              delay: 2,
              child: Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25.sp),
              )));
    });
  }

  Widget _googlebtn() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 10,
          shadowColor: Colors.black,
          onPrimary: Colors.black26,
          primary: Colors.white,
          fixedSize: Size(60.w, 6.h),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.sp))),
        ),
        onPressed: () {
          _handleSignIn();
        },
        child: FadeAnimation(
          delay: 2,
          child: Image.asset('assets/google.png', height: 3.h, width: 10.w),
        ));
  }

  Widget _register() {
    return FadeAnimation(
        delay: 1,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RegisterScreen(
                        title: 'register',
                      )),
            );
          },
          child: Text(
            "Don't have account?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
              fontSize: 12.sp,
            ),
          ),
        ));
  }

  Widget _forgotpassword() {
    return FadeAnimation(
        delay: 1,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ResetPasswordScreen(
                        title: 'reset password',
                      )),
            );
          },
          child: Text(
            "Forgot password?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
              fontSize: 12.sp,
            ),
          ),
        ));
  }
}
