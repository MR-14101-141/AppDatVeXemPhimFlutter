import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testflutter2/Bloc/LoaiPhim/event_loaiphim.dart';
import 'package:testflutter2/Bloc/LoaiPhim/state_loaiphim.dart';
import 'package:testflutter2/repository/Model/loaiphim.dart';
import 'package:testflutter2/repository/loaiphim_repository.dart';

class LoaiPhimBloc extends Bloc<LoaiPhimEvent, LoaiPhimState> {
  final _loaiphimRepository = LoaiPhimRepository();

  LoaiPhimBloc() : super(LoaiPhimLoading()) {
    on<LoadDsLoaiPhim>(_onLoadDsLoaiPhim);
  }

  void _onLoadDsLoaiPhim(
      LoadDsLoaiPhim event, Emitter<LoaiPhimState> emit) async {
    List<LoaiPhim> lst = List.empty();
    try {
      lst = await _loaiphimRepository.loadDsloaiphim();
      emit(LoadDsLoaiPhimSucess(lst));
    } catch (e) {
      emit(LoadDsLoaiPhimFail(e.toString()));
    }
  }
}
