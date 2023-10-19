class HistoryModel {
  final int? id;
  final String name;

  HistoryModel({this.id, required this.name});

  Map<String, dynamic> toMap(HistoryModel item) {
    return {
      "id": item.id,
      "history": item.name,
    };
  }
}
