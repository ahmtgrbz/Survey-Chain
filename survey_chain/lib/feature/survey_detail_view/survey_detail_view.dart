import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:survey_chain/core/navigation/navigation_service.dart';
import 'package:survey_chain/feature/survey_detail_view/viewmodel/survey_detail_view_model.dart';
import 'package:web3dart/web3dart.dart';

import '../home_view/service/ethereum_chain_service.dart';
import '../home_view/viewmodel/home_view_model.dart';

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
    for (var i = 0; i < widget.surveyData[0].questions.length; i++) {
      selectedAnswers.add('');
    }
  }

  var fToast = FToast();
  @override
  void initState() {
    answersDefaulter(selectedAnswers);
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

  void buildShowToastJoinedSurveyError(FToast fToast, BuildContext context) {
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
          'Fill all questions.',
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
        actions: [
          IconButton(
            onPressed: () {
              print(selectedAnswers);
            },
            icon: Icon(Icons.data_saver_off),
          ),
        ],
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
                        (50.0 * widget.surveyData[1][index1].answers.length),
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
                _homeViewModel.joinedSurveys
                    .add(BigInt.from(widget.surveyData[2]));
              } else {
                print('Please fill all qustions!');
                buildShowToastJoinedSurveyError(fToast, context);
              }
              NavigationService.instance.navigateToPop();
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
