class BankModel {
  String? name;
  String? code;
  bool? canDisburse;
  bool? canNameValidate;

  BankModel({this.name, this.code, this.canDisburse, this.canNameValidate});

  BankModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    canDisburse = json['can_disburse'];
    canNameValidate = json['can_name_validate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['can_disburse'] = this.canDisburse;
    data['can_name_validate'] = this.canNameValidate;
    return data;
  }
}
