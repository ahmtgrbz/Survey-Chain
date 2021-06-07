// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyModel _$SurveyModelFromJson(Map<String, dynamic> json) {
  return SurveyModel(
    name: json['name'] as String?,
    questions: json['questions'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$SurveyModelToJson(SurveyModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'questions': instance.questions,
    };
