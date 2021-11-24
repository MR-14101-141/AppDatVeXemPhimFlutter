import 'package:device_info/device_info.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginRepository {
  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  Future<String> login({
    required String emailKH,
    required String passwordKH,
  }) async {
    try {
      String deviceKH = await _getId();
      var formData = <String, String>{
        'emailKH': emailKH,
        'passwordKH': passwordKH,
        'deviceKH': deviceKH,
      };
      Map<String, String> headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8'
      };
      String link = 'https://rapphimmeme.000webhostapp.com/api/actionlogin';
      var url = Uri.parse(link);
      var request = MultipartRequest('POST', url)..fields.addAll(formData);
      request.headers.addAll(headers);
      var response = await request.send();
      final String respStr = await response.stream.bytesToString();
      Map<String, dynamic> json = await jsonDecode(respStr);

      const storage = FlutterSecureStorage();
      if (json["status"] == "success") {
        await storage.write(key: 'emailKH', value: emailKH);
      }

      return json["status"];
    } catch (err) {
      return err.toString();
    }
  }

  Future<String> logout() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
    return 'logout';
  }
}
