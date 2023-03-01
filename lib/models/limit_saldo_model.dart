class LimitSaldoModel {
  String? message;
  String? errors;

  LimitSaldoModel({this.message, this.errors});

  LimitSaldoModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['errors'] = this.errors;
    return data;
  }
}
