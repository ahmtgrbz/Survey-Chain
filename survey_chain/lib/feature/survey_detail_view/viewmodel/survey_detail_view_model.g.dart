// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SurveyDataViewModel on _SurveyDataViewModelBase, Store {
  final _$questionsAtom = Atom(name: '_SurveyDataViewModelBase.questions');

  @override
  List<QuestionModel> get questions {
    _$questionsAtom.reportRead();
    return super.questions;
  }

  @override
  set questions(List<QuestionModel> value) {
    _$questionsAtom.reportWrite(value, super.questions, () {
      super.questions = value;
    });
  }

  @override
  String toString() {
    return '''
questions: ${questions}
    ''';
  }
}
