import 'package:mobx/mobx.dart';

import 'package:survey_chain/feature/home_view/service/IEthereumChainService.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  IEthereumChainService service;

  @observable
  int surveyCount = 0;

  @observable
  int questionCount = 0;

  @observable
  Map<String, List> surveyMap = {};

  @observable
  Map<String, List<dynamic>> questionMap = {};

  @observable
  bool isLoading = true;

  _HomeViewModelBase({
    required this.service,
  }) {
    getSurveys();
  }

  @action
  Future<void> getSurveys() async {
    surveyCount = (await service.getSurveyCount())!;
    questionCount = (await service.getQuestionCount())!;

    for (var i = 0; i < surveyCount; i++) {
      var survey = (await service.getSurvey(i))!;
      surveyMap.putIfAbsent(survey[0], () => survey[1]);
    }

    for (var i = 0; i < questionCount; i++) {
      var question = (await service.getQuestion(i))!;
      questionMap.putIfAbsent(question[0], () => question[1]);
    }
    print(questionMap.toString());
    print(surveyMap.toString());

    isLoading = false;
  }
}
