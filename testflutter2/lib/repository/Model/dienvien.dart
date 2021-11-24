class DienVien {
  final int idDV;
  final int idNV;
  final String tenDV;
  final DateTime taoorsuangay;

  DienVien(
      {required this.idDV,
      required this.idNV,
      required this.tenDV,
      required this.taoorsuangay});

  factory DienVien.fromJson(Map<String, dynamic> json) {
    return DienVien(
      idDV: json['idDV'],
      idNV: json['idNV'],
      tenDV: json['tenDV'],
      taoorsuangay: DateTime.parse(json['taoorsua_ngay']),
    );
  }

  Map<String, dynamic> toJson() => {
        'idDV': idDV,
        'idNV': idNV,
        'tenDV': tenDV,
        'taoorsua_ngay': taoorsuangay,
      };
}
