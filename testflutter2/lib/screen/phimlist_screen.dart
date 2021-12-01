//import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:sizer/sizer.dart';
import 'package:testflutter2/Bloc/DienVien/bloc_dienvien.dart';
import 'package:testflutter2/Bloc/DienVien/state_dienvien.dart';
import 'package:testflutter2/Bloc/LoaiPhim/bloc_loaiphim.dart';
import 'package:testflutter2/Bloc/LoaiPhim/state_loaiphim.dart';
import 'package:testflutter2/Bloc/Phim/bloc_phim.dart';
import 'package:testflutter2/Bloc/Phim/event_phim.dart';
import 'package:testflutter2/Bloc/Phim/state_phim.dart';
import 'package:testflutter2/repository/Model/dienvien.dart';
import 'package:testflutter2/repository/Model/loaiphim.dart';
import 'package:testflutter2/repository/Model/phim.dart';
import 'package:testflutter2/screen/phimdetail_screen.dart';
// import 'package:http/http.dart' as http;
import '../Animation/_slideanimation.dart';

class PhimListScreen extends StatefulWidget {
  const PhimListScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PhimListScreen> createState() => _PhimListState();
}

class _PhimListState extends State<PhimListScreen> {
  List<Phim> listphim = List.empty();
  List<LoaiPhim> listloaiphim = List.empty();
  List<DienVien> listdienvien = List.empty();
  late ScrollController _scrollController;

  Future<void> _pullRefresh() async {
    context.read<PhimBloc>().add(RefreshDsPhim());
  }

  // Future<void> lazyload() async {
  //   final response = await http.get(Uri.parse(
  //       'https://rapphimmeme.000webhostapp.com/home?page=$pageCount'));
  //   if (mounted) {
  //     setState(() {
  //       list = List.from(list)
  //         ..addAll(json.decode(response.body)['dsphim']['data']);
  //     });
  //   }
  // }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      context.read<PhimBloc>().add(LoadDsPhim());
    }
  }

  @override
  initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade50,
      //appBar: AppBar(
      // title: Text(widget.title),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _searchbar(),
          Padding(
            padding: EdgeInsets.only(top: 0.5.h),
          ),
          Expanded(
              child: RefreshIndicator(
                  onRefresh: _pullRefresh,
                  child: CustomScrollView(
                      //scrollDirection: Axis.vertical,
                      controller: _scrollController,
                      shrinkWrap: true,
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: Container(child: _listcategories()),
                        ),
                        SliverToBoxAdapter(
                          child: Container(child: _listactor()),
                        ),
                        _listphim()
                        //SliverToBoxAdapter(
                        //child: _listphim(),
                        //)
                      ])))
        ],
      ),
    );
  }

  Widget _searchbar() {
    return Container(
        margin: EdgeInsets.only(top: 0.5.h, left: 1.w, right: 1.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.sp),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade900,
              )
            ]),
        child: Container(
          padding: EdgeInsets.all(2.w),
          child: TextField(
            readOnly: true,
            onTap: () => {},
            style: TextStyle(color: Colors.blue.shade900, fontSize: 12.sp),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColorDark,
                )),
          ),
        ));
  }

  Widget _listcategories() {
    return Container(
        height: 5.h,
        margin: EdgeInsets.all(2.w),
        child:
            BlocBuilder<LoaiPhimBloc, LoaiPhimState>(builder: (context, state) {
          //late List<Phim> list;
          if (state is LoadDsLoaiPhimSucess) {
            listloaiphim = state.lst;
            return GridView.count(
              mainAxisSpacing: 2.w,
              //crossAxisSpacing: 2.w,
              crossAxisCount: 1,
              childAspectRatio: 0.04.h,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: List.generate(
                listloaiphim.length,
                (index) {
                  return SlideAnimation(
                      delay: 3,
                      child: Stack(children: <Widget>[
                        Container(
                          width: 30.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7.sp),
                          ),
                          child: Center(
                              child: (listloaiphim[index].tenLPhim.length >= 10)
                                  ? Marquee(
                                      text: listloaiphim[index].tenLPhim,
                                      style: GoogleFonts.lato(
                                          fontSize: 15.sp,
                                          color: Colors.blue.shade800,
                                          fontWeight: FontWeight.bold),
                                      blankSpace: 8.w,
                                      pauseAfterRound:
                                          const Duration(seconds: 1),
                                      // overflow: TextOverflow.ellipsis,
                                    )
                                  : Text(
                                      listloaiphim[index].tenLPhim,
                                      style: GoogleFonts.lato(
                                          fontSize: 15.sp,
                                          color: Colors.blue.shade800,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                        ),
                        Positioned.fill(
                            child: Material(
                                borderRadius: BorderRadius.circular(7.sp),
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                )))
                      ]));
                },
              ).toList(),
            );
          } else if (state is LoadDsLoaiPhimFail) {
            debugPrint(state.err);
            return Center(child: Text(state.err));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }

  Widget _listactor() {
    return Container(
        height: 5.h,
        margin: EdgeInsets.all(2.w),
        child:
            BlocBuilder<DienVienBloc, DienVienState>(builder: (context, state) {
          if (state is LoadDsDienVienSucess) {
            listdienvien = state.lst;
            return GridView.count(
              mainAxisSpacing: 2.w,
              //crossAxisSpacing: 2.w,
              crossAxisCount: 1,
              childAspectRatio: 0.041.h,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: List.generate(
                listdienvien.length,
                (index) {
                  return SlideAnimation(
                      delay: 3,
                      child: Stack(children: <Widget>[
                        Container(
                          width: 30.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7.sp),
                          ),
                          child: Center(
                              child: (listdienvien[index].tenDV.length >= 11)
                                  ? Marquee(
                                      text: listdienvien[index].tenDV,
                                      style: GoogleFonts.lato(
                                          fontSize: 15.sp,
                                          color: Colors.blue.shade800,
                                          fontWeight: FontWeight.bold),
                                      blankSpace: 8.w,
                                      pauseAfterRound:
                                          const Duration(seconds: 1),
                                      //overflow: TextOverflow.ellipsis,
                                    )
                                  : Text(
                                      listdienvien[index].tenDV,
                                      style: GoogleFonts.lato(
                                          fontSize: 15.sp,
                                          color: Colors.blue.shade800,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                        ),
                        Positioned.fill(
                            child: Material(
                                borderRadius: BorderRadius.circular(7.sp),
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                )))
                      ]));
                },
              ).toList(),
            );
          } else if (state is LoadDsDienVienFail) {
            debugPrint(state.err);
            return Center(child: Text(state.err));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }

  Widget _listphim() {
    return BlocBuilder<PhimBloc, PhimState>(
      builder: (context, state) {
        //late List<Phim> list;
        if (state is LoadDsphimSucess) {
          listphim = state.lst;
          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == state.lst.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SlideAnimation(
                    delay: 3,
                    child: Stack(children: <Widget>[
                      Card(
                        elevation: 20,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.sp),
                        ),
                        child: Column(children: [
                          Expanded(
                              child: CachedNetworkImage(
                            //width: 20.w,
                            //height: 10.h,
                            imageUrl:
                                'https://rapphimmeme.000webhostapp.com/hinhanh/Phim/${listphim[index].imgPhim}',
                            imageBuilder: (context, imageProvider) => Container(
                              padding: EdgeInsets.only(top: 0.1.h, left: 3.w),
                              margin: EdgeInsets.all(6.sp),
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
                          )),
                          Text(
                            listphim[index].tenPhim,
                            style: GoogleFonts.lato(
                                fontSize: 15.sp,
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Thời lượng: ${listphim[index].thoiluongPhim}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.blue.shade800,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/imdb.png',
                                    height: 5.h, width: 10.w),
                                Text(
                                  listphim[index].rate,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ])
                        ]),
                      ),
                      Positioned.fill(
                          child: Material(
                              borderRadius: BorderRadius.circular(7.sp),
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PhimDetailScreen(
                                              title: 'detail',
                                              idPhim: listphim[index].idPhim,
                                            )),
                                  );
                                },
                              )))
                    ]));
              },
              childCount: state.lst.length + 1,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 1.h,
              crossAxisSpacing: 2.w,
              crossAxisCount: 2,
              childAspectRatio: 0.07.h,
            ),
          );
        } else if (state is LoadFail) {
          debugPrint(state.err);
          return SliverToBoxAdapter(
              child: SizedBox(
                  width: 100.w,
                  height: 100.w,
                  child: Center(child: Text(state.err))));
        } else {
          return SliverToBoxAdapter(
              child: SizedBox(
                  width: 100.w,
                  height: 150.w,
                  child: const Center(child: CircularProgressIndicator())));
        }
      },
    );
  }
}
