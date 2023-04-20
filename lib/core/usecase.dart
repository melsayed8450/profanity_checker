import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class UseCase<Type> {
  Future<Type> call(XFile? imageFile);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
