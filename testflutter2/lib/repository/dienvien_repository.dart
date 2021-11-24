import 'dart:convert';
import 'package:http/http.dart';
import 'package:testflutter2/repository/Model/dienvien.dart';

class DienVienRepository {
  List<DienVien> lst = List.empty();

  Future<List<DienVien>> loadDsDienVien() async {
    final response = await get(Uri.parse(
        'http://10.0.2.2/tttn/public_html/home/dsphimdangchieu?page=1'));
    lst = (json.decode(response.body)['dsdv'] as List)
        .map((data) => DienVien.fromJson(data))
        .toList();
    return lst;
  }
}
