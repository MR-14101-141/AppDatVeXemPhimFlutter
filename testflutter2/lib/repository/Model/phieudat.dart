import 'package:testflutter2/repository/Model/snack.dart';
import 'package:testflutter2/repository/Model/ve.dart';

class PhieuDat {
  final int idPhieuDat;
  final int idKH;
  final String statusKH;
  final String idKM;
  final double tiendat;
  final String ngaydat;
  final String ngayhethan;
  final String statusCTPD;
  final List<Ve> dsve;
  final List<Snack> dssnack;

  PhieuDat({
    required this.idPhieuDat,
    required this.idKH,
    required this.statusKH,
    required this.idKM,
    required this.tiendat,
    required this.ngaydat,
    required this.ngayhethan,
    required this.statusCTPD,
    required this.dsve,
    required this.dssnack,
  });

  factory PhieuDat.from(Map<String, dynamic> json) {
    return PhieuDat(
      idPhieuDat: json['idPhieuDat'],
      idKH: json['idKH'],
      statusKH: json['statusKH'],
      idKM: json['idKM'],
      tiendat: json['tiendat'],
      ngaydat: json['ngaydat'],
      ngayhethan: json['ngayhethan'],
      statusCTPD: json['statusCTPD'],
      dsve: (json['dsve'] == null)
          ? []
          : (json['dsve'] as List).map((data) => Ve.fromJson(data)).toList(),
      dssnack: (json['dssnack'] == null)
          ? []
          : (json['dssnack'] as List)
              .map((data) => Snack.fromJson(data))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'idPhieuDat': idPhieuDat,
        'idKH': idKH,
        'statusKH': statusKH,
        'idKM': idKM,
        'tiendat': tiendat,
        'ngaydat': ngaydat,
        'ngayhethan': ngayhethan,
        'dsve': dsve,
        'dssnack': dssnack
      };
}
