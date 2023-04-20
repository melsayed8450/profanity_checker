import 'package:image_picker/image_picker.dart';
import 'package:profanity_filter_app/profanity/domain/entities/response_entity.dart';
import '../../../core/api_provider.dart';
import '../models/response_model.dart';

abstract class RemoteDataSource {
  Future<ResponseEntity> getResponse(XFile? imageFile);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final ApiProvider apiProvider;
  RemoteDataSourceImpl(this.apiProvider);

  @override
  Future<ResponseEntity> getResponse(XFile? imageFile) async {
    final output = await apiProvider.post(imageFile);
    return ResponseModel(
      none: output,
    );
  }
}
