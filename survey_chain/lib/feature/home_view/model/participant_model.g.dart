// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantModel _$ParticipantModelFromJson(Map<String, dynamic> json) {
  return ParticipantModel(
    name: json['name'] as String?,
    age: json['age'] == null ? null : BigInt.parse(json['age'] as String),
  );
}

Map<String, dynamic> _$ParticipantModelToJson(ParticipantModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age?.toString(),
    };
