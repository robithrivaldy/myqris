class TransactionsModel {
  int? id;
  String? referenceNumber;
  int? driverId;
  int? amount;
  int? fee;
  int? total;
  String? status;
  String? qrCode;
  String? paidAt;
  String? paidBy;
  String? paidByLogo;
  String? expiredAt;
  String? createdAt;
  String? updatedAt;

  TransactionsModel(
      {this.id,
      this.referenceNumber,
      this.driverId,
      this.amount,
      this.fee,
      this.total,
      this.status,
      this.qrCode,
      this.paidAt,
      this.paidBy,
      this.paidByLogo,
      this.expiredAt,
      this.createdAt,
      this.updatedAt});

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceNumber = json['reference_number'];
    driverId = json['driver_id'];
    amount = json['amount'];
    fee = json['fee'];
    total = json['total'];
    status = json['status'];
    qrCode = json['qr_code'] ?? '';
    paidAt = json['paid_at'] ?? '';
    paidBy = json['paid_by'] ?? '';
    paidByLogo = json['paid_by_logo'] ?? '';
    expiredAt = json['expired_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_number'] = this.referenceNumber;
    data['driver_id'] = this.driverId;
    data['amount'] = this.amount;
    data['fee'] = this.fee;
    data['total'] = this.total;
    data['status'] = this.status;
    data['qr_code'] = this.qrCode;
    data['paid_at'] = this.paidAt;
    data['paid_by'] = this.paidBy;
    data['paid_by_logo'] = this.paidByLogo;
    data['expired_at'] = this.expiredAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
