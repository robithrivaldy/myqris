class WithdrawModel {
  int? id;
  String? bankCode;
  String? beneficiaryAccountNumber;
  String? beneficiaryAccountHolder;
  String? status;
  int? fee;
  int? amount;
  String? submissionStatus;
  String? sendBy;
  String? createdAt;
  String? updatedAt;

  WithdrawModel(
      {this.id,
      this.bankCode,
      this.beneficiaryAccountNumber,
      this.beneficiaryAccountHolder,
      this.status,
      this.fee,
      this.amount,
      this.submissionStatus,
      this.sendBy,
      this.createdAt,
      this.updatedAt});

  WithdrawModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    bankCode = json['bank_code'] ?? '';
    beneficiaryAccountNumber = json['beneficiary_account_number'] ?? '';
    beneficiaryAccountHolder = json['beneficiary_account_holder'] ?? '';
    status = json['status'] ?? '';
    fee = json['fee'] ?? 0;
    amount = json['amount'] ?? 0;
    submissionStatus = json['submission_status'] ?? '';
    sendBy = json['send_by'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_code'] = this.bankCode;
    data['beneficiary_account_number'] = this.beneficiaryAccountNumber;
    data['beneficiary_account_holder'] = this.beneficiaryAccountHolder;
    data['status'] = this.status;
    data['fee'] = this.fee;
    data['amount'] = this.amount;
    data['submission_status'] = this.submissionStatus;
    data['send_by'] = this.sendBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
