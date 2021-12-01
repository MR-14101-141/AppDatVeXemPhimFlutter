class Snack {
  final String tenSnack;
  final int soluongSnack;
  final double giatienSnack;

  Snack(
      {required this.tenSnack,
      required this.soluongSnack,
      required this.giatienSnack});

  factory Snack.fromJson(Map<String, dynamic> json) {
    return Snack(
        tenSnack: json['tenSnack'],
        soluongSnack: (json['soluongSnack'] == null) ? 1 : json['soluongSnack'],
        giatienSnack: json['giatienSnack']);
  }
  Map<String, dynamic> toJson() => {
        'tenSnack': tenSnack,
        'soluongSnack': soluongSnack,
        'giatienSnack': giatienSnack
      };
}
