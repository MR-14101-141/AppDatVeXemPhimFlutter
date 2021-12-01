import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:testflutter2/Bloc/User/bloc_login.dart';
import 'package:testflutter2/Bloc/User/event_login.dart';
import 'package:testflutter2/Bloc/User/state_login.dart';
import '../Animation/_fadeanimation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String emailKH = '';
  String passwordKH = '';
  String gioitinhKH = 'Nam';
  String phoneKH = '';
  String addressKH = '';
  String avatarKH =
      'https://i1.wp.com/gocsuckhoe.com/wp-content/uploads/2020/09/avatar-facebook.jpg';
  bool isLoading = false;
  GoogleSignInAccount? user;
  bool _passwordVisible = false;
  DateTime selectedDate = DateTime.now();
  var txt = TextEditingController();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        txt.text = DateFormat.yMd().format(picked);
      });
    }
  }

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
              _pagetittle(),
              _avatar(),
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
        child: Text("Register",
            style: TextStyle(
                color: Colors.blue.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 35.sp)));
  }

  Widget _avatar() {
    return FadeAnimation(
        delay: 1.8,
        child: IconButton(
            iconSize: 60.sp,
            onPressed: () {},
            icon: CachedNetworkImage(
              //width: 30.w,
              //height: 15.h,
              imageUrl: avatarKH,
              imageBuilder: (context, imageProvider) => Container(
                padding: EdgeInsets.only(top: 0.1.h, left: 3.w),
                margin: EdgeInsets.all(6.sp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    )),
              ),
              placeholder: (context, url) => Container(
                  padding: EdgeInsets.only(top: 0.1.h, left: 3.w),
                  margin: EdgeInsets.all(6.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  )),
              errorWidget: (context, url, error) => Container(
                  padding: EdgeInsets.only(top: 0.1.h, left: 3.w),
                  margin: EdgeInsets.all(6.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                  ),
                  child: const Center(child: Icon(Icons.error))),
            )));
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
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.blue))),
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
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.blue))),
                  child: TextField(
                      style: TextStyle(
                          color: Colors.blue.shade900, fontSize: 12.sp),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Name",
                        suffixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                      onChanged: (text) {
                        setState(() {
                          passwordKH = text;
                        });
                      }),
                ),
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.blue))),
                  child: DropdownButton<String>(
                    underline: const SizedBox(),
                    isExpanded: true,
                    //hint: Text('Giới tính'),
                    value: gioitinhKH,
                    //itemHeight: null,
                    items: <String>['Nam', 'Nữ', 'Không Xác Định']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: Colors.blue.shade900, fontSize: 12.sp),
                        ),
                      );
                    }).toList(),
                    onChanged: (text) {
                      setState(() {
                        gioitinhKH = text!;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.blue))),
                  child: TextField(
                      style: TextStyle(
                          color: Colors.blue.shade900, fontSize: 12.sp),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone",
                        suffixIcon: Icon(
                          Icons.phone_android,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                      onChanged: (text) {
                        setState(() {
                          passwordKH = text;
                        });
                      }),
                ),
                Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.blue))),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                                controller: txt,
                                readOnly: true,
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 12.sp),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Birth",
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    passwordKH = text;
                                  });
                                })),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.black,
                              primary: Colors.blue,
                              fixedSize: Size(6.w, 5.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.sp))),
                            ),
                            onPressed: () => _selectDate(context),
                            child: const FadeAnimation(
                                delay: 2,
                                child: Icon(
                                  Icons.calendar_today_rounded,
                                  color: Colors.white,
                                )))
                      ],
                    )),
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.blue))),
                  child: TextField(
                      style: TextStyle(
                          color: Colors.blue.shade900, fontSize: 12.sp),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Address",
                        suffixIcon: Icon(
                          Icons.home,
                          color: Theme.of(context).primaryColorDark,
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
                      "Register",
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
                "Register",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25.sp),
              )));
    });
  }
}
