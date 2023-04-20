// ignore_for_file: must_be_immutable

import '../../domain/entities/response_entity.dart';

class ResponseModel extends ResponseEntity {
  ResponseModel({
    required super.none,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        none: json['nudity']['none'],
      );
}
