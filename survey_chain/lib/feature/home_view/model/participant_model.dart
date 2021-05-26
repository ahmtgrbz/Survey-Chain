import 'package:json_annotation/json_annotation.dart';

part 'participant_model.g.dart';

@JsonSerializable()
class ParticipantModel {
  String? name;
  BigInt? age;

  ParticipantModel({
    required this.name,
    required this.age,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return _$ParticipantModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ParticipantModelToJson(this);
  }
}
