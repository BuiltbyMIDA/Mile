class BankModel {
  bool? status;
  String? message;
  List<BankModelData>? data;

  BankModel({this.status, this.message, this.data});

  BankModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BankModelData>[];
      json['data'].forEach((v) {
        data!.add(new BankModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankModelData {
  int? id;
  String? name;
  String? slug;
  String? code;
  String? longcode;
  String? gateway;
  bool? payWithBank;
  bool? supportsTransfer;
  bool? active;
  String? country;
  String? currency;
  String? type;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  BankModelData(
      {this.id,
        this.name,
        this.slug,
        this.code,
        this.longcode,
        this.gateway,
        this.payWithBank,
        this.supportsTransfer,
        this.active,
        this.country,
        this.currency,
        this.type,
        this.isDeleted,
        this.createdAt,
        this.updatedAt});

  BankModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    code = json['code'];
    longcode = json['longcode'];
    gateway = json['gateway'];
    payWithBank = json['pay_with_bank'];
    supportsTransfer = json['supports_transfer'];
    active = json['active'];
    country = json['country'];
    currency = json['currency'];
    type = json['type'];
    isDeleted = json['is_deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['code'] = this.code;
    data['longcode'] = this.longcode;
    data['gateway'] = this.gateway;
    data['pay_with_bank'] = this.payWithBank;
    data['supports_transfer'] = this.supportsTransfer;
    data['active'] = this.active;
    data['country'] = this.country;
    data['currency'] = this.currency;
    data['type'] = this.type;
    data['is_deleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}