class DivisionModel {
  final String code;
  final String name;

  DivisionModel.fromJson({required Map<String, dynamic> json})
    : code = json['code'],
      name = json['name'];
}