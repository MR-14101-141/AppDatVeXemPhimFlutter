import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:testflutter2/Animation/_fadeanimation.dart';

class GheListScreen extends StatefulWidget {
  const GheListScreen({Key? key, required this.title, required this.idSC})
      : super(key: key);
  final String title;
  final int idSC;
  @override
  State<GheListScreen> createState() => _GheListScreen();
}

class _GheListScreen extends State<GheListScreen> {
  late Map<String, dynamic> dsghe;
  late List lst;
  late bool loading = true;

  Future<void> loadghelist(int idSC) async {
    final response = await get(
        Uri.parse('http://10.0.2.2/tttn/public_html/home/dsGhe/$idSC'));
    setState(() {
      dsghe = json.decode(response.body);
      loading = false;
    });
  }

  _pullRefresh() {
    loadghelist(widget.idSC);
  }

  @override
  void initState() {
    super.initState();
    loadghelist(widget.idSC);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan.shade50,
        body: (loading)
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _pullRefresh(),
                child: SingleChildScrollView(
                    child: Column(children: [
                  _backbtn(),
                  Padding(padding: EdgeInsets.only(top: 2.h)),
                  _suatchieu(),
                ])),
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

  Widget _suatchieu() {
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
}
