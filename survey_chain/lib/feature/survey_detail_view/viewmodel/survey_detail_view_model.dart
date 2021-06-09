import 'package:mobx/mobx.dart';
import 'package:survey_chain/feature/survey_detail_view/model/question_model.dart';

part 'survey_detail_view_model.g.dart';

class SurveyDataViewModel = _SurveyDataViewModelBase with _$SurveyDataViewModel;

abstract class _SurveyDataViewModelBase with Store {
  @observable
  List<QuestionModel> questions = [];

  int getSelectedAnswer(List<String> list) {
    int currentSelectedValue = 0;
    list.forEach((element) => element == '' ? null : currentSelectedValue++);
    return currentSelectedValue;
  }
}
