import 'package:bloc_test/model/SecondModelClass.dart';
import 'package:dio/dio.dart';

import '../model/modelDTO.dart';

class ApiRepository {
  final Dio _dio = Dio();

  Future<List<ModelDTO>> fetchData(String email) async {
    try {
      final response = await _dio.get(
        "https://emergingideas.ae/test_apis/read.php",
        queryParameters: {"email": email},
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = response.data;
        final List<ModelDTO> modelList =
            jsonResponse.map((json) => ModelDTO.fromJson(json)).toList();
        return modelList;
      } else {
        throw DioError(
          requestOptions: response.requestOptions,
          response: response,
          error: "Failed to fetch data",
        );
      }
    } catch (e) {
      throw DioError(
        requestOptions: RequestOptions(path: ""),
        error: "Error: $e",
      );
    }
  }

  Future<List<SecondModelDTO>> fetchSecondData(String email) async {
    try {
      final response = await _dio.get(
        "https://emergingideas.ae/test_apis/read.php",
        queryParameters: {"email": email},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = response.data;
        final List<SecondModelDTO> modelList =
            jsonResponse.map((json) => SecondModelDTO.fromJson(json)).toList();
        return modelList;
      } else {
        throw DioError(
          requestOptions: response.requestOptions,
          response: response,
          error: "Failed to fetch data",
        );
      }
    } catch (e) {
      throw DioError(
        requestOptions: RequestOptions(path: ""),
        error: "Error: $e",
      );
    }
  }

  Future<String> deleteData(String email, int id) async {
    try {
      final response = await _dio.get(
        "https://emergingideas.ae/test_apis/delete.php",
        queryParameters: {"email": email, "id": id},
      );

      if (response.statusCode == 200) {
        String message = "";
        if (response.data is List && (response.data as List).isNotEmpty) {
          message = response.data[0]["message"];
        }
        return message;
      } else {
        throw DioError(
          requestOptions: response.requestOptions,
          response: response,
          error: "Failed ",
        );
      }
    } catch (e) {
      throw DioError(
        requestOptions: RequestOptions(path: ""),
        error: "Error: $e",
      );
    }
  }

  Future<String> updateData(String email, int id, String description,
      String title, String? img) async {
    try {
      Map<String, dynamic> queryParameters = {
        "email": email,
        "id": id,
        "title": title,
        "description": description
      };
      if (img != null) {
        queryParameters['img_link'] = img;
      }

      final response = await _dio.post(
        "https://emergingideas.ae/test_apis/edit.php",
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        String message = "";
        if (response.data is List && (response.data as List).isNotEmpty) {
          message = response.data[0]["message"];
        }
        return message;
      } else {
        print(response.statusCode);
        return "";
        // throw DioError(
        //   requestOptions: response.requestOptions,
        //   response: response,
        //   error: "Failed ",
        // );
      }
    } catch (e) {
      throw DioError(
        requestOptions: RequestOptions(path: ""),
        error: "Error: $e",
      );
    }
  }

  Future<String> createPost(
      String email, String description, String title, String img) async {
    try {
      final response = await _dio.post(
        "https://emergingideas.ae/test_apis/create.php",
        data: {
          "email": email,
          "title": title,
          "description": description,
          'img_link': img,
        },
      );

      if (response.statusCode == 200) {
        String message = "";
        if (response.data is List && (response.data as List).isNotEmpty) {
          message = response.data[0]["message"];
        }
        return message;
      } else {
        throw DioError(
          requestOptions: response.requestOptions,
          response: response,
          error: "Failed ",
        );
      }
    } catch (e) {
      throw DioError(
        requestOptions: RequestOptions(path: ""),
        error: "Error: $e",
      );
    }
  }
}
