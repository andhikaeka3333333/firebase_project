class ExpenseModel {
  final String id;
  final String title;
  final String price;
  final bool checked;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.price,
    required this.checked,
  });

  factory ExpenseModel.fromJson(String id, Map<String, dynamic> json) {
    return ExpenseModel(
      id: id,
      title: json['title'],
      price: json['price'],
      checked: json['checked'] == true,
    );
  }

  Map<String, dynamic> toJson({ bool id = true }) {
    var data = {
      'title': title,
      'price': price,
      'checked': checked == true,
    };
    if (id) data['id'] = this.id;
    return data;
  }

  ExpenseModel copyWith({
    String? id,
    String? title,
    String? price,
    bool? checked,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      checked: checked ?? this.checked,
    );
  }
}