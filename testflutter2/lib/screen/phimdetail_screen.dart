import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:testflutter2/Animation/_fadeanimation.dart';
import 'package:testflutter2/screen/suatchieulist_screen.dart';

class PhimDetailScreen extends StatefulWidget {
  const PhimDetailScreen({Key? key, required this.title, required this.idPhim})
      : super(key: key);
  final String title;
  final int idPhim;
  @override
  State<PhimDetailScreen> createState() => _PhimDetailScreen();
}

class _PhimDetailScreen extends State<PhimDetailScreen> {
  late Map<String, dynamic> phim;
  late bool loading = true;

  Future<void> loadphimddetail(int idphim) async {
    final response = await get(
        Uri.parse('http://10.0.2.2/tttn/public_html/home/singlePhim/$idphim'));
    setState(() {
      phim = json.decode(response.body);
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadphimddetail(widget.idPhim);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade100,
      body: (loading)
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(children: [
              _backbtn(),
              Padding(padding: EdgeInsets.only(top: 2.h)),
              _phimdetailup(),
              _phimdetaildown(),
            ])),
      bottomNavigationBar: _btn(),
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

  Widget _img() {
    return CachedNetworkImage(
      width: 40.w,
      height: 30.h,
      imageUrl:
          'https://rapphimmeme.000webhostapp.com/hinhanh/Phim/${phim['imgPhim']}',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.sp),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            )),
        //child: FadeInImage.assetNetwork(
        // placeholder: 'assets/loading.gif',
        // image:
        // 'https://rapphimmeme.000webhostapp.com/hinhanh/Phim/${lst[index]["imgPhim"]}',
        // fit: BoxFit.cover,
        // ),
      ),
      placeholder: (context, url) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.sp),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          )),
      errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.sp),
          ),
          child: const Center(child: Icon(Icons.error))),
    );
  }

  Widget _phimdetailup() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        width: 2.w,
      ),
      _img(),
      SizedBox(
        width: 2.w,
      ),
      SizedBox(
          width: 55.w,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              phim['tenPhim'],
              style: GoogleFonts.lato(
                  fontSize: 23.sp,
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.w900),
              overflow: TextOverflow.ellipsis,
            ),
            Padding(padding: EdgeInsets.only(top: 2.h)),
            Text(
              'Thời lượng phim: ${phim['thoiluongPhim']}',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.blue.shade800,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Row(children: [
              Image.asset('assets/imdb.png', height: 5.h, width: 10.w),
              Text(
                phim['rate'],
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.blue.shade800,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ]),
            Text(
              'Thể loại: ${phim['LPhim']}',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.blue.shade800,
              ),
            ),
            Text(
              'Diễn viên: ${phim['DV'].toString().replaceAll('[', '').replaceAll(']', '')}',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.blue.shade800,
              ),
            ),
            Text(
              'Đạo diễn: ${phim['daodienPhim']}',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.blue.shade800,
              ),
            ),
          ])),
    ]);
  }

  Widget _phimdetaildown() {
    return Stack(children: [
      Container(
        margin: EdgeInsets.only(top: 2.h),
        padding: EdgeInsets.only(left: 2.w, right: 2.w),
        width: 100.w,
        height: 97.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.sp),
                topRight: Radius.circular(30.sp)),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade300,
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ]),
      ),
      Container(
          margin: EdgeInsets.only(top: 2.h),
          padding: EdgeInsets.only(left: 2.w, right: 2.w),
          width: 100.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.sp),
                topRight: Radius.circular(30.sp)),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Nội dung phim',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              phim['mieutaPhim'],
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black,
              ),
            ),
          ]))
    ]);
  }

  Widget _btn() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.black,
          primary: Colors.blue,
          elevation: 10,
          fixedSize: Size(60.w, 6.h),
        ),
        onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SuatChieuScreen(
                          title: 'suatchieu',
                          idPhim: widget.idPhim,
                        )),
              )
            },
        child: FadeAnimation(
            delay: 2,
            child: Text(
              "Đặt vé",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25.sp),
            )));
  }
}
