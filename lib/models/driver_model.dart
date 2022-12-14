class DriverModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? googleId;
  int? saldo;
  String? status;
  String? idCardNumber;
  String? idCardDocPath;
  String? createdAt;
  String? updatedAt;

  DriverModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.googleId,
    this.saldo,
    this.status,
    this.idCardNumber,
    this.idCardDocPath,
    this.createdAt,
    this.updatedAt,
  });

  DriverModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'] ?? '';
    googleId = json['google_id'];
    saldo = json['saldo'] ?? 0;
    status = json['status'];
    idCardNumber = json['id_card_number'] ?? '';
    idCardDocPath = json['id_card_doc_path'] ?? '';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
