import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testflutter2/Bloc/Phim/event_phim.dart';
import 'package:testflutter2/Bloc/Phim/state_phim.dart';
import 'package:testflutter2/repository/Model/phim.dart';
import 'package:testflutter2/repository/phim_respository.dart';

class PhimBloc extends Bloc<PhimEvent, PhimState> {
  final _phimRepository = PhimRepository();

  PhimBloc() : super(PhimLoading()) {
    on<LoadDsPhim>(_onLoadDsPhim);
    on<RefreshDsPhim>(_onRefreshDsPhim);
    on<LoadPhimDetail>(_onLoadPhimDetail);
  }

  void _onLoadDsPhim(LoadDsPhim event, Emitter<PhimState> emit) async {
    List<Phim> lst = List.empty();
    try {
      lst = await _phimRepository.loadDsphim();
      //print('dsphim');
      emit(LoadDsphimSucess(lst));
    } catch (e) {
      emit(LoadFail(e.toString()));
    }
  }

  void _onLoadPhimDetail(LoadPhimDetail event, Emitter<PhimState> emit) async {
    try {
      Phim phim = await _phimRepository.loadphimddetail(event.idphim);
      emit(LoadphimdetailSucess(phim));
    } catch (e) {
      emit(LoadFail(e.toString()));
    }
  }

  void _onRefreshDsPhim(RefreshDsPhim event, Emitter<PhimState> emit) async {
    emit(PhimLoading());
    try {
      List<Phim> lst = await _phimRepository.refreshDsPhim();
      emit(LoadDsphimSucess(lst));
    } catch (e) {
      emit(LoadFail(e.toString()));
    }
  }
}
