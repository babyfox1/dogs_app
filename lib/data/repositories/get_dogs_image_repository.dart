import 'package:dio/dio.dart';

import 'package:dogs_app/data/models/dogs_data_model.dart';

class GetDogsImageRepository {
  final Dio dio = Dio();

  Future getDogsData() async {
    try {
      final Response response =
          await dio.get('https://dog.ceo/api/breeds/image/random');
      print('object');
      DogsDataModel model = DogsDataModel.fromJson(response.data);
      return model;
    } catch (e) {
      if (e is DioException) {
        return (e.response?.data['message']);
      }
      return e.toString();
    }
  }
}
