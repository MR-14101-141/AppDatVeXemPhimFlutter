abstract class PhimEvent {}

class LoadDsPhim extends PhimEvent {}

class LoadPhimDetail extends PhimEvent {
  LoadPhimDetail(this.idphim);
  int idphim;
}

class RefreshDsPhim extends PhimEvent {}
