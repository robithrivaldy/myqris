class ProfileModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? saldo;
  String? status;
  String? idCardNumber;
  String? idCardDocUrl;
  String? fcmToken;
  String? bankCode;
  String? beneficiaryAccountNumber;
  String? beneficiaryAccountHolder;
  String? createdAt;
  String? updatedAt;

  ProfileModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.saldo,
      this.status,
      this.idCardNumber,
      this.idCardDocUrl,
      this.fcmToken,
      this.bankCode,
      this.beneficiaryAccountNumber,
      this.beneficiaryAccountHolder,
      this.createdAt,
      this.updatedAt});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    saldo = json['saldo'] ?? 0;
    status = json['status'] ?? '';
    idCardNumber = json['id_card_number'] ?? '';
    idCardDocUrl = json['id_card_doc_url'] ?? '';
    fcmToken = json['fcm_token'] ?? '';
    bankCode = json['bank_code'] ?? '';
    beneficiaryAccountNumber = json['beneficiary_account_number'] ?? '';
    beneficiaryAccountHolder = json['beneficiary_account_holder'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['saldo'] = this.saldo;
    data['status'] = this.status;
    data['id_card_number'] = this.idCardNumber ?? '';
    data['id_card_doc_url'] = this.idCardDocUrl ?? '';
    data['fcm_token'] = this.fcmToken;
    data['bank_code'] = this.bankCode ?? '';
    data['beneficiary_account_number'] = this.beneficiaryAccountNumber ?? '';
    data['beneficiary_account_holder'] = this.beneficiaryAccountHolder ?? '';
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
