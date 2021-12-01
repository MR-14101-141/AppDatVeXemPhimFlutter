import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:testflutter2/Bloc/DienVien/event_dienvien.dart';
import 'package:testflutter2/Bloc/Phim/bloc_phim.dart';
import 'package:testflutter2/Bloc/Phim/event_phim.dart';
import 'package:testflutter2/screen/phimlist_screen.dart';
import 'Bloc/DienVien/bloc_dienvien.dart';
import 'Bloc/LoaiPhim/bloc_loaiphim.dart';
import 'Bloc/LoaiPhim/event_loaiphim.dart';
import 'Bloc/User/bloc_login.dart';
import 'screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => PhimBloc()..add(LoadDsPhim())),
          BlocProvider(
              create: (context) => LoaiPhimBloc()..add(LoadDsLoaiPhim())),
          BlocProvider(
              create: (context) => DienVienBloc()..add(LoadDsDienVien())),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return const MaterialApp(
            //debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: MyBar(title: 'Flutter Test Home Page'),
          );
        }));
  }
}

class MyBar extends StatefulWidget {
  const MyBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyBar> createState() => _MyBarState();
}

class _MyBarState extends State<MyBar> {
  static int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List screens = [];
  @override
  void initState() {
    super.initState();
    screens = [
      LoginScreen(title: '1', changeindex: (value) => _onItemTapped(value)),
      Navigator(
        onGenerateRoute: (settings) {
          Widget page = LoginScreen(
            title: '1',
            changeindex: (value) {
              _selectedIndex = value;
            },
          );
          if (settings.name == 'PhimListScreen') {
            page = const PhimListScreen(title: '2');
          }
          return MaterialPageRoute(builder: (context) => page);
        },
      ),
      const PhimListScreen(title: '2'),
    ];
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
            //),
            body: Center(
              child: screens[_selectedIndex],
            ),
            floatingActionButton: Container(
                height: 8.h,
                padding: EdgeInsets.only(left: 6.w),
                //margin: EdgeInsets.only(left: 3.w, right: 3.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.sp),
                    color: Colors.transparent),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.sp),
                  child: BottomNavigationBar(
                    selectedFontSize: 10.sp,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home,
                          size: 20.sp,
                          //color: Colors.black,
                        ),
                        label: 'Home',
                        backgroundColor: Colors.red,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.person,
                          size: 20.sp,
                          //color: Colors.black,
                        ),
                        label: 'User',
                        backgroundColor: Colors.green,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.school,
                          size: 20.sp,
                          //color: Colors.black,
                        ),
                        label: 'School',
                        backgroundColor: Colors.purple,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.school,
                          size: 20.sp,
                          //color: Colors.black,
                        ),
                        label: 'School',
                        backgroundColor: Colors.pink,
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: Colors.amber[800],
                    onTap: _onItemTapped,
                  ),
                ))));
  }
}
