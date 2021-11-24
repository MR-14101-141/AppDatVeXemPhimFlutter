import 'package:testflutter2/repository/Model/loaiphim.dart';

abstract class LoaiPhimState {}

class LoadDsLoaiPhimSucess extends LoaiPhimState {
  LoadDsLoaiPhimSucess(this.lst);
  List<LoaiPhim> lst;
}

class LoadDsLoaiPhimFail extends LoaiPhimState {
  LoadDsLoaiPhimFail(this.err);
  final String err;
}

class LoaiPhimLoading extends LoaiPhimState {}
