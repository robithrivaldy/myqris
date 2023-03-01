class LimitTransactionModel {
  String? message;
  String? errors;

  LimitTransactionModel({this.message, this.errors});

  LimitTransactionModel.fromJson(Map<String, dynamic> json) {
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
