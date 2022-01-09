// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:river_makale/providers/user_provider.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory User({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    required String avatar,
    @JsonKey(unknownEnumValue: Role.normal) required Role role,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
