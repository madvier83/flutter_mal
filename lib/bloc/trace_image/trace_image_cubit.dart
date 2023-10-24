import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mal/bloc/trace_image/trace_image_state.dart';
import 'package:flutter_mal/models/api/trace_api.dart';
import 'package:flutter_mal/models/trace_model.dart';
import 'package:image_picker/image_picker.dart';

class TraceImageCubit extends Cubit<TraceImageState> {
  TraceImageCubit() : super(TraceImageInit());

  void selectImage(XFile file) {
    emit(TraceImageSelected(file: file));
  }

  void searchImage(XFile file) async {
    try {
      emit(TraceImageLoading());
      final TraceModel response = await TraceApi().searchImage(xfile: file);
      emit(TraceImageSuccess(data: response));
    } on Exception catch (e) {
      emit(TraceImageError(message: e.toString()));
    }
  }
}
