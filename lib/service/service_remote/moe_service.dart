import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app/model/moe_model.dart';

class MoeService {
  Future<MoeModel> getMoe({
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
        'https://api.trace.moe/search',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'image/jpeg',
          },
        ),
      );

      print(response.data);
      return MoeModel.fromJson(response.data);
    } catch (e) {
      throw "$e";
    }
  }
}
