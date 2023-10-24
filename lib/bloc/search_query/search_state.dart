import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SearchState extends Equatable {
  final TextEditingController searchController = TextEditingController();

  @override
  List<Object> get props => [searchController];
}
