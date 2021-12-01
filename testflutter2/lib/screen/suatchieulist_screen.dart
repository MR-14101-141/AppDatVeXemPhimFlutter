import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:testflutter2/Animation/_fadeanimation.dart';
import 'package:testflutter2/screen/ghelist_screen.dart';

class SuatChieuScreen extends StatefulWidget {
  const SuatChieuScreen({Key? key, required this.title, required this.idPhim})
      : super(key: key);
  final String title;
  final int idPhim;
  @override
  State<SuatChieuScreen> createState() => _SuatChieuScreen();
}

class _SuatChieuScreen extends State<SuatChieuScreen> {
  late Map<String, dynamic> dssc;
  late List lst;
  late bool loading = true;

  Future<void> loaddssc() async {
    final response = await get(Uri.parse(
        'http://10.0.2.2/tttn/public_html/home/dsSC/${widget.idPhim}'));
    setState(() {
      dssc = json.decode(response.body);
      loading = false;
    });
  }

  Future<void> pullRefresh() async {
    setState(() {
      loading = true;
    });
    loaddssc();
  }

  @override
  void initState() {
    super.initState();
    loaddssc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade50,
      body: Column(children: [
        _backbtn(),
        Padding(padding: EdgeInsets.only(top: 2.h)),
        (loading)
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: pullRefresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: _suatchieu(),
                ))
      ]),
    );
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

  Widget _ngaychieu(ngaychieu) {
    return Padding(
      padding: EdgeInsets.all(2.h),
      child: Text(ngaychieu,
          style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900)),
    );
  }

  Widget _giochieu(sc) {
    return Padding(
      padding: EdgeInsets.all(1.h),
      child: ElevatedButton(
          onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GheListScreen(
                            title: 'detail',
                            idSC: sc['idSC'],
                          )),
                )
              },
          child: Text(
            sc['giochieu'].toString().substring(0, 5),
            style: TextStyle(fontSize: 25.sp),
          )),
    );
  }

  Widget _suatchieu() {
    for (var key in dssc.keys) {
      return Container(
          width: 55.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.sp))),
          child: Column(children: [
            _ngaychieu(key),
            for (List<dynamic> value in dssc.values)
              for (Map<String, dynamic> sc in value) _giochieu(sc),
          ]));
    }
    return const CircularProgressIndicator();
  }
}
