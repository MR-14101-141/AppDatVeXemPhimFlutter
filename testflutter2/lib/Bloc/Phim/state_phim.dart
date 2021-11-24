import 'package:testflutter2/repository/Model/phim.dart';

abstract class PhimState {}

class LoadDsphimSucess extends PhimState {
  LoadDsphimSucess(this.lst);
  List<Phim> lst;
}

class LoadDsPhimFail extends PhimState {
  LoadDsPhimFail(this.err);
  final String err;
}

class PhimLoading extends PhimState {}
