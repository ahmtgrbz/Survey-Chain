// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  final _$surveyCountAtom = Atom(name: '_HomeViewModelBase.surveyCount');

  @override
  int get surveyCount {
    _$surveyCountAtom.reportRead();
    return super.surveyCount;
  }

  @override
  set surveyCount(int value) {
    _$surveyCountAtom.reportWrite(value, super.surveyCount, () {
      super.surveyCount = value;
    });
  }

  final _$questionCountAtom = Atom(name: '_HomeViewModelBase.questionCount');

  @override
  int get questionCount {
    _$questionCountAtom.reportRead();
    return super.questionCount;
  }

  @override
  set questionCount(int value) {
    _$questionCountAtom.reportWrite(value, super.questionCount, () {
      super.questionCount = value;
    });
  }

  final _$surveyMapAtom = Atom(name: '_HomeViewModelBase.surveyMap');

  @override
  Map<String, List<dynamic>> get surveyMap {
    _$surveyMapAtom.reportRead();
    return super.surveyMap;
  }

  @override
  set surveyMap(Map<String, List<dynamic>> value) {
    _$surveyMapAtom.reportWrite(value, super.surveyMap, () {
      super.surveyMap = value;
    });
  }

  final _$questionMapAtom = Atom(name: '_HomeViewModelBase.questionMap');

  @override
  Map<String, List<dynamic>> get questionMap {
    _$questionMapAtom.reportRead();
    return super.questionMap;
  }

  @override
  set questionMap(Map<String, List<dynamic>> value) {
    _$questionMapAtom.reportWrite(value, super.questionMap, () {
      super.questionMap = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_HomeViewModelBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$getSurveysAsyncAction = AsyncAction('_HomeViewModelBase.getSurveys');

  @override
  Future<void> getSurveys() {
    return _$getSurveysAsyncAction.run(() => super.getSurveys());
  }

  @override
  String toString() {
    return '''
surveyCount: ${surveyCount},
questionCount: ${questionCount},
surveyMap: ${surveyMap},
questionMap: ${questionMap},
isLoading: ${isLoading}
    ''';
  }
}
