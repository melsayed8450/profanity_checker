// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class ResponseEntity extends Equatable {
  double none;
  ResponseEntity(
      {required this.none,
     });

  @override
  // ignore: todo
  List<Object?> get props => [none];
}
