import 'package:dio/dio.dart';
import 'package:flutter_mal/models/trace_model.dart';
import 'package:image_picker/image_picker.dart';

class TraceApi {
  Future<TraceModel> searchImage({
    required XFile xfile,
  }) async {
    try {
      FormData formData = FormData.fromMap(
        {
          'image': await MultipartFile.fromFile(
            xfile.path,
          )
        },
      );

      final response = await Dio().post(
        'https://api.trace.moe/search?anilistInfo',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'image/jpeg',
          },
        ),
      );

      print(response);

      return TraceModel.fromJson(response.data);
    } catch (e) {
      throw "$e";
    }
  }
}
