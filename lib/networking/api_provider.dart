import 'package:http/http.dart' as http;
import 'package:savings_app/networking/api_response_handler.dart';

class ApiProvider {
  static const baseUrl = "https://animechan.vercel.app/api";

  Future<Map<String, dynamic>> getCall(String endPoint) async {
    var client = http.Client();
    String urlString = baseUrl + endPoint;
    Uri url = Uri.parse(urlString);
    try {
      var uriResponse = await client.get(
        url,
        headers: {},
      );
      return ApiResponseHandler.output(uriResponse);
    } catch (e) {
      return ApiResponseHandler.outputError();
    }
  }
}
