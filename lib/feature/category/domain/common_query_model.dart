import 'package:equatable/equatable.dart';

class CommonQueryModel extends Equatable {
  const CommonQueryModel({this.search, this.id, this.date});

  final String? search;
  final String? id;
  final DateTime? date;

  @override
  List<Object?> get props => [search, id, date];

  @override
  bool get stringify => false;
}
