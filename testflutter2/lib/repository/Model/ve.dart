class Ve {
  final int idVe;
  final String vitrighe;
  final String vitriphong;
  final String tenPhim;
  final String ngaychieu;
  final String giochieu;
  final double tongtien;

  Ve(
      {required this.idVe,
      required this.vitrighe,
      required this.vitriphong,
      required this.tenPhim,
      required this.ngaychieu,
      required this.giochieu,
      required this.tongtien});

  factory Ve.fromJson(Map<String, dynamic> json) {
    return Ve(
        idVe: json['idVe'],
        vitrighe: json['vitrighe'],
        vitriphong: json['vitriphong'],
        tenPhim: json['tenPhim'],
        ngaychieu: json['ngaychieu'],
        giochieu: json['giochieu'],
        tongtien: json['tongtien']);
  }
  Map<String, dynamic> toJson() => {
        'idVe': idVe,
        'vitrighe': vitrighe,
        'vitriphong': vitriphong,
        'tenPhim': tenPhim,
        'ngaychieu': ngaychieu,
        'giochieu': giochieu
      };
}
