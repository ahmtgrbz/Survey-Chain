import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../core/constants/navigation_constants.dart';
import '../../core/navigation/navigation_service.dart';
import '../home_view/service/ethereum_chain_service.dart';
import '../home_view/viewmodel/home_view_model.dart';
import 'viewmodel/survey_detail_view_model.dart';

var httpClt = Client();
var infura = DotEnv.env["INFURA"];

final _homeViewModel = HomeViewModel(
  service: EthereumChainService(
    Web3Client(
      infura!,
      httpClt,
    ),
    httpClt,
  ),
);

final _surveyViewModel = SurveyDataViewModel();

class SurveyDetailView extends StatefulWidget {
  final surveyData;

  const SurveyDetailView({
    Key? key,
    required this.surveyData,
  }) : super(key: key);

  @override
  _SurveyDetailViewState createState() => _SurveyDetailViewState();
}

class _SurveyDetailViewState extends State<SurveyDetailView> {
  List<String> selectedAnswers = [];

  void answersDefaulter(List<String> list) {
    list.clear();
    for (var i = 0; i < widget.surveyData[0].questions.length; i++) {
      selectedAnswers.add('');
    }
  }

  var fToast = FToast();
  @override
  void initState() {
    if (selectedAnswers.length == 0) {
      answersDefaulter(selectedAnswers);
    }
    super.initState();
    fToast.init(context);
  }

  void buildShowToastJoinedSurveySuccess(FToast fToast, BuildContext context) {
    return fToast.showToast(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Survey joined succesfully.',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  void buildShowToastJoinedSurveyFillError(
      FToast fToast, BuildContext context) {
    return fToast.showToast(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Please fill all the questions.',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  void buildShowToastJoinedSurveyDuplicateError(
      FToast fToast, BuildContext context) {
    return fToast.showToast(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'You already joined the survey!',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _homeViewModel.currentSelectedCount[widget.surveyData[2]] =
                  _homeViewModel.getSelectedAnswer(selectedAnswers);
              print(_homeViewModel.currentSelectedCount.toString());
              NavigationService.instance
                  .navigateToPage(path: NavigationConstants.HOME_VIEW);
            },
            icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        backgroundColor: Color(0xff221c43),
        title: Text(widget.surveyData[0].name,
            style: const TextStyle(
                color: const Color(0xfffafafa),
                fontWeight: FontWeight.w700,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 20.0),
            textAlign: TextAlign.center),
      ),
      body: buildListViewBody(),
    );
  }

  Stack buildListViewBody() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: ListView.builder(
            itemCount: widget.surveyData[0].questions.length,
            itemBuilder: (context, index1) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Text(
                      widget.surveyData[1][index1].title,
                      style: const TextStyle(
                          color: const Color(0xff221c43),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 20.0),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height:
                        (55.0 * widget.surveyData[1][index1].answers.length),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x40000000),
                            offset: Offset(0, 4),
                            blurRadius: 20,
                            spreadRadius: 0)
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: ListView.builder(
                        itemCount: widget.surveyData[1][index1].answers.length,
                        itemBuilder: (context, index) {
                          return RadioListTile<String>(
                            activeColor: Color(0xffe1b000),
                            title: Text(
                              widget.surveyData[1][index1].answers[index]
                                  .toString(),
                              style: TextStyle(
                                  color: const Color(0xff221c43),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Roboto",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 20.0),
                            ),
                            value: widget.surveyData[1][index1].answers[index]
                                .toString(),
                            groupValue:
                                widget.surveyData[1][index1].selectedAnswer,
                            onChanged: (value) {
                              setState(
                                () {
                                  widget.surveyData[1][index1].selectedAnswer =
                                      value.toString();
                                  selectedAnswers[index1] = value.toString();
                                  print(value);
                                  print(selectedAnswers);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Positioned(
          left: (MediaQuery.of(context).size.width - 260) / 2,
          bottom: (MediaQuery.of(context).size.height - 56) / 20,
          child: InkWell(
            onTap: () async {
              if (!selectedAnswers.contains('')) {
                await _homeViewModel.service.joinTheSurvey(
                    BigInt.from(widget.surveyData[2]), selectedAnswers);
                buildShowToastJoinedSurveySuccess(fToast, context);
              } else {
                buildShowToastJoinedSurveyFillError(fToast, context);
              }
              /*try {
                if (!selectedAnswers.contains('')) {
                  await _homeViewModel.service.joinTheSurvey(
                      BigInt.from(widget.surveyData[2]), selectedAnswers);
                  buildShowToastJoinedSurveySuccess(fToast, context);
                  NavigationService.instance.navigateToPop();
                } else {
                  buildShowToastJoinedSurveyFillError(fToast, context);
                }
              } catch (e) {
                //buildShowToastJoinedSurveySuccess(fToast, context);
                buildShowToastJoinedSurveyDuplicateError(fToast, context);
              }*/
            },
            child: Container(
                child: Center(
                  child: Text("Submit",
                      style: const TextStyle(
                          color: const Color(0xff221c43),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 20.0),
                      textAlign: TextAlign.center),
                ),
                width: 260,
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: const Color(0xffe1b000))),
          ),
        )
      ],
    );
  }
}
