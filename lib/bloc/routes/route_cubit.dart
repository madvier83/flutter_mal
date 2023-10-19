import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mal/bloc/routes/route_state.dart';

class RouteCubit extends Cubit<RouteState> {
  RouteCubit() : super(const RouteState(index: 0));

  void navigate({required int index}) {
    emit(RouteState(index: index));
  }
}
