import 'package:myqris/models/transactions_model.dart';

class MainModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? saldo;
  String? status;
  String? idCardNumber;
  String? idCardDocUrl;
  List<TransactionsModel>? transactions;
  String? createdAt;
  String? updatedAt;

  MainModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.saldo,
      this.status,
      this.idCardNumber,
      this.idCardDocUrl,
      this.transactions,
      this.createdAt,
      this.updatedAt});

  MainModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'] ?? '';
    saldo = json['saldo'];
    status = json['status'];
    idCardNumber = json['id_card_number'] ?? '';
    idCardDocUrl = json['id_card_doc_url'] ?? '';
    if (json['transactions'] != null) {
      transactions = <TransactionsModel>[];
      json['transactions'].forEach((v) {
        transactions!.add(new TransactionsModel.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['saldo'] = this.saldo;
    data['status'] = this.status;
    data['id_card_number'] = this.idCardNumber;
    data['id_card_doc_url'] = this.idCardDocUrl;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
