import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  String? title;
  List<dynamic>? answers;
  String? selectedAnswer;

  QuestionModel({
    this.title,
    this.answers,
    this.selectedAnswer = '',
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return _$QuestionModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuestionModelToJson(this);
  }
}
