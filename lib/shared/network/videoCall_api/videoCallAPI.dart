import 'dart:convert';
import 'package:http/http.dart' as http;

String token =
    "6033893ed2db81a2d2750c81aded4518e84b2bdb323643c4b11d364668bdb350";

Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

  return json.decode(httpResponse.body)['roomId'];
}
