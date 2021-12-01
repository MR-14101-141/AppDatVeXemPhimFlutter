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
  late List dsgheselect = [];
  late List dsghe = [];
  late bool loading = true;
  int selectedCard = -1;

  Future<void> loadghelist() async {
    final response = await get(Uri.parse(
        'http://10.0.2.2/tttn/public_html/home/dsGhe/${widget.idSC}'));
    setState(() {
      dsghe = (json.decode(response.body) as List);
      loading = false;
    });
  }

  Future<void> _pullRefresh() async {
    setState(() {
      //dsghe = List.empty();
      loading = true;
    });
    loadghelist();
  }

  @override
  void initState() {
    super.initState();
    loadghelist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan.shade50,
        body: (loading)
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [_backbtn(), listghe()],
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

  Widget _forwardbtn() {
    return FadeAnimation(
      delay: 1,
      child: Row(children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_forward,
            size: 30.sp,
            color: Colors.blue,
          ),
        ),
      ]),
    );
  }

  Widget listghe() {
    return RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Container(
          padding: EdgeInsets.all(10.w),
          child: GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 1.h,
                crossAxisSpacing: 6.w,
                crossAxisCount: 4,
                childAspectRatio: 0.135.h,
              ),
              children: List.generate(
                  dsghe.length,
                  (index) => (dsghe[index]['statusVe'] == 'Còn trống')
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade400,
                          ),
                          onPressed: () => {
                            setState(() {
                              dsgheselect.add(dsghe[index]);
                              dsghe[index]['statusVe'] = 'Đặt';
                            }),
                          },
                          child: const Icon(
                            Icons.chair,
                          ),
                        )
                      : (dsghe[index]['statusVe'] == 'Đặt')
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue.shade900),
                              onPressed: () => {
                                setState(() {
                                  dsgheselect.remove(dsghe[index]);
                                  dsghe[index]['statusVe'] = 'Còn trống';
                                }),
                              },
                              child: const Icon(
                                Icons.chair,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.sp)),
                                color: Colors.red,
                              ),
                              child: const Icon(
                                Icons.chair,
                                color: Colors.white,
                              ),
                            )).toList()),
        ));
  }
}
