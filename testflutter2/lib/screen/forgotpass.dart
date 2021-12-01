import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:testflutter2/Bloc/User/bloc_login.dart';
import 'package:testflutter2/Bloc/User/state_login.dart';
import '../Animation/_fadeanimation.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String emailKH = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              _backbtn(),
              Padding(padding: EdgeInsets.only(top: 1.h)),
              _pagetittle(),
              _input(),
              Padding(padding: EdgeInsets.only(top: 3.h)),
              _btn(),
            ],
          ),
        ));
  }

  Widget _backbtn() {
    return FadeAnimation(
      delay: 1,
      child: Row(children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 30.sp,
            color: Colors.blue,
          ),
        ),
      ]),
    );
  }

  Widget _pagetittle() {
    return FadeAnimation(
        delay: 1.8,
        child: Text("Reset Password",
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
          onPressed: () => {},
          child: FadeAnimation(
              delay: 2,
              child: Text(
                "Reset Password",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25.sp),
              )));
    });
  }
}
