import 'package:testflutter2/repository/Model/dienvien.dart';
import 'package:testflutter2/repository/Model/loaiphim.dart';

class Phim {
  final int idPhim;
  final int idNV;
  final String tenPhim;
  final int trangthai;
  final String imgPhim;
  final String mieutaPhim;
  final String daodienPhim;
  final String trailerPhim;
  final String thoiluongPhim;
  final String rate;
  final List<LoaiPhim> loaiphim;
  final List<DienVien> dienvien;

  Phim({
    required this.idPhim,
    required this.idNV,
    required this.tenPhim,
    required this.trangthai,
    required this.imgPhim,
    required this.mieutaPhim,
    required this.daodienPhim,
    required this.trailerPhim,
    required this.thoiluongPhim,
    required this.rate,
    required this.loaiphim,
    required this.dienvien,
  });

  factory Phim.fromJson(Map<String, dynamic> json) {
    return Phim(
      idPhim: json['idPhim'],
      idNV: json['idNV'],
      tenPhim: json['tenPhim'],
      daodienPhim: json['daodienPhim'],
      imgPhim: json['imgPhim'],
      mieutaPhim: json['mieutaPhim'],
      rate: json['rate'],
      thoiluongPhim: json['thoiluongPhim'],
      trailerPhim: json['trailerPhim'],
      trangthai: json['trangthai'],
      dienvien: (json['dienvien'] == null)
          ? []
          : (json['dienvien'] as List)
              .map((data) => DienVien.fromJson(data))
              .toList(),
      loaiphim: (json['loaiphim'] == null)
          ? []
          : (json['loaiphim'] as List)
              .map((data) => LoaiPhim.fromJson(data))
              .toList(),
      //loaiphim: (json['loaiphim'] as List)
      //.map((data) => LoaiPhim.fromJson(data))
      //.toList(),
      //dienvien: (json['dienvien'] as List)
      // .map((data) => DienVien.fromJson(data))
      // .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'idPhim': idPhim,
        'idNV': idNV,
        'tenPhim': tenPhim,
        'trangthai': trangthai,
        'daodienPhim': daodienPhim,
        'imgPhim': imgPhim,
        'mieutaPhim': mieutaPhim,
        'rate': rate,
        'thoiluongPhim': thoiluongPhim,
        'trailerPhim': trailerPhim,
        'loaiphim': loaiphim.map((data) => data.toJson()),
        'dienvien': dienvien.map((data) => data.toJson()),
      };
}
