// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) {
  return QuestionModel(
    title: json['title'] as String?,
    answers: json['answers'] as List<dynamic>?,
    selectedAnswer: json['selectedAnswer'] as String?,
  );
}

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'answers': instance.answers,
      'selectedAnswer': instance.selectedAnswer,
    };
