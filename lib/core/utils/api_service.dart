import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  Future<Response> post({
    required String url,
    required Map<String, dynamic> body,
    required String token,
    String? contenttype,
  }) async {
    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          contentType: contenttype ?? 'application/json',
        ),
      );
      return response;
    } on DioException catch (e) {
      print("=========== STRIPE ERROR ===========");
      print(e.response?.data);
      print("====================================");
      rethrow;
    } catch (e) {
      print("=========== STRIPE ERROR ===========");
      print(e.toString());
      print("====================================");
      rethrow;
    }
  }
}
