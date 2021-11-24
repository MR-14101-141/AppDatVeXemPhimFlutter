class LoaiPhim {
  final int idLPhim;
  final int idNV;
  final String tenLPhim;
  final DateTime taoorsuangay;

  LoaiPhim(
      {required this.idLPhim,
      required this.idNV,
      required this.tenLPhim,
      required this.taoorsuangay});

  factory LoaiPhim.fromJson(Map<String, dynamic> json) {
    return LoaiPhim(
      idLPhim: json['idLPhim'],
      idNV: json['idNV'],
      tenLPhim: json['tenLPhim'],
      taoorsuangay: DateTime.parse(json['taoorsua_ngay']),
    );
  }

  Map<String, dynamic> toJson() => {
        'idLPhim': idLPhim,
        'idNV': idNV,
        'tenLPhim': tenLPhim,
        'taoorsua_ngay': taoorsuangay,
      };
}
