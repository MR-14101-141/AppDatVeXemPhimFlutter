import 'dart:convert';
import 'package:http/http.dart';
import 'package:testflutter2/repository/Model/loaiphim.dart';

class LoaiPhimRepository {
  List<LoaiPhim> lst = List.empty();

  Future<List<LoaiPhim>> loadDsloaiphim() async {
    final response = await get(Uri.parse(
        'http://10.0.2.2/tttn/public_html/home/dsphimdangchieu?page=1'));
    lst = (json.decode(response.body)['dslphim'] as List)
        .map((data) => LoaiPhim.fromJson(data))
        .toList();
    return lst;
  }
}
