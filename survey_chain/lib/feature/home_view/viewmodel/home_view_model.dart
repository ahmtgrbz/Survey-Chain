import 'package:mobx/mobx.dart';

import 'package:survey_chain/feature/home_view/service/IEthereumChainService.dart';
import 'package:survey_chain/feature/survey_detail_view/model/question_model.dart';
import 'package:survey_chain/feature/survey_detail_view/model/survey_model.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  IEthereumChainService service;

  @observable
  int surveyCount = 0;

  @observable
  int questionCount = 0;

  @observable
  List<SurveyModel> surveyList = [];

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
      surveyList.add(survey);
    }

    isLoading = false;
  }

  Future<List<QuestionModel>> surveyToQuestions(SurveyModel surveyModel) async {
    List<QuestionModel> list = [];
    for (var item in surveyModel.questions!) {
      var question = await service.getQuestion(item.toInt());
      if (question != null) {
        list.add(question);
      } else {
        print('Question Null Geldi');
      }
    }
    return list;
  }
}
