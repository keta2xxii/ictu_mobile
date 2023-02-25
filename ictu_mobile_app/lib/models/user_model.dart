import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    this.email,
    this.username,
    this.password,
    this.displayName,
    this.avatar,
    this.donviId,
    this.realms,
    this.roleIds,
    this.status,
    this.isAdmin,
    this.isDelete,
    this.deleteBy,
    this.verified,
    this.verificationToken,
    this.verifiedAt,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  final String? email;
  final String? username;
  final String? password;
  @JsonKey(name: 'display_name')
  final String? displayName;
  final String? avatar;
  @JsonKey(name: 'donvi_id')
  final int? donviId;
  final List<String>? realms;
  @JsonKey(name: 'role_ids')
  final String? roleIds;
  final int? status;
  @JsonKey(name: 'is_admin')
  final int? isAdmin;
  @JsonKey(name: 'is_delete')
  final int? isDelete;
  @JsonKey(name: 'delete_by')
  final int? deleteBy;
  final int? verified;
  @JsonKey(name: 'verification_token')
  final String? verificationToken;
  @JsonKey(name: 'verified_at')
  final DateTime? verifiedAt;
  @JsonKey(name: 'created_by')
  final int? createdBy;
  @JsonKey(name: 'updated_by')
  final int? updatedBy;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  static List<UserModel> fromList(dynamic data) {
    return (data as List).map((obj) => UserModel.fromJson(obj)).toList();
  }

  factory UserModel.fromJson(dynamic json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
