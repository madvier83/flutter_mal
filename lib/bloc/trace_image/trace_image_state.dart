import 'package:equatable/equatable.dart';
import 'package:flutter_mal/models/trace_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class TraceImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class TraceImageInit extends TraceImageState {}

class TraceImageLoading extends TraceImageState {}

class TraceImageSuccess extends TraceImageState {
  final TraceModel data;
  TraceImageSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class TraceImageError extends TraceImageState {
  final String message;
  TraceImageError({required this.message});

  @override
  List<Object> get props => [message];
}

class TraceImageSelected extends TraceImageState {
  final XFile file;
  TraceImageSelected({required this.file});

  @override
  List<Object> get props => [file];
}
