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

  final _$surveyListAtom = Atom(name: '_HomeViewModelBase.surveyList');

  @override
  List<SurveyModel> get surveyList {
    _$surveyListAtom.reportRead();
    return super.surveyList;
  }

  @override
  set surveyList(List<SurveyModel> value) {
    _$surveyListAtom.reportWrite(value, super.surveyList, () {
      super.surveyList = value;
    });
  }

  final _$joinedSurveysAtom = Atom(name: '_HomeViewModelBase.joinedSurveys');

  @override
  List<BigInt> get joinedSurveys {
    _$joinedSurveysAtom.reportRead();
    return super.joinedSurveys;
  }

  @override
  set joinedSurveys(List<BigInt> value) {
    _$joinedSurveysAtom.reportWrite(value, super.joinedSurveys, () {
      super.joinedSurveys = value;
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

  final _$participantModelAtom =
      Atom(name: '_HomeViewModelBase.participantModel');

  @override
  ParticipantModel get participantModel {
    _$participantModelAtom.reportRead();
    return super.participantModel;
  }

  @override
  set participantModel(ParticipantModel value) {
    _$participantModelAtom.reportWrite(value, super.participantModel, () {
      super.participantModel = value;
    });
  }

  final _$currentSelectedCountAtom =
      Atom(name: '_HomeViewModelBase.currentSelectedCount');

  @override
  Map<int, int> get currentSelectedCount {
    _$currentSelectedCountAtom.reportRead();
    return super.currentSelectedCount;
  }

  @override
  set currentSelectedCount(Map<int, int> value) {
    _$currentSelectedCountAtom.reportWrite(value, super.currentSelectedCount,
        () {
      super.currentSelectedCount = value;
    });
  }

  final _$getSurveysAsyncAction = AsyncAction('_HomeViewModelBase.getSurveys');

  @override
  Future<void> getSurveys() {
    return _$getSurveysAsyncAction.run(() => super.getSurveys());
  }

  final _$_HomeViewModelBaseActionController =
      ActionController(name: '_HomeViewModelBase');

  @override
  int getSelectedAnswer(List<String> list) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.getSelectedAnswer');
    try {
      return super.getSelectedAnswer(list);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
surveyCount: ${surveyCount},
questionCount: ${questionCount},
surveyList: ${surveyList},
joinedSurveys: ${joinedSurveys},
isLoading: ${isLoading},
participantModel: ${participantModel},
currentSelectedCount: ${currentSelectedCount}
    ''';
  }
}
