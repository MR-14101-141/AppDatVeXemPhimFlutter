import 'package:testflutter2/repository/Model/dienvien.dart';

abstract class DienVienState {}

class LoadDsDienVienSucess extends DienVienState {
  LoadDsDienVienSucess(this.lst);
  List<DienVien> lst;
}

class LoadDsDienVienFail extends DienVienState {
  LoadDsDienVienFail(this.err);
  final String err;
}

class DienVienLoading extends DienVienState {}
