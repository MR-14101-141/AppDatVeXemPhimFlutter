import 'package:testflutter2/repository/Model/phim.dart';

abstract class PhimState {}

class LoadDsphimSucess extends PhimState {
  LoadDsphimSucess(this.lst);
  List<Phim> lst;
}

class LoadphimdetailSucess extends PhimState {
  LoadphimdetailSucess(this.phim);
  Phim phim;
}

class LoadFail extends PhimState {
  LoadFail(this.err);
  final String err;
}

class PhimLoading extends PhimState {}
