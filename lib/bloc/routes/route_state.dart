import 'package:equatable/equatable.dart';

class RouteState extends Equatable {
  final int index;
  const RouteState({required this.index});

  @override
  List<Object> get props => [index];
}
