import 'package:json_annotation/json_annotation.dart';
part 'survey_model.g.dart';

@JsonSerializable()
class SurveyModel {
  String? name;
  List<dynamic>? questions;

  SurveyModel({
    this.name,
    this.questions,
  });

  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return _$SurveyModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SurveyModelToJson(this);
  }
}
