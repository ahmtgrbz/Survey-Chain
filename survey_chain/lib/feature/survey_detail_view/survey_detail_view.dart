import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

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

final _surveyDetailViewModel = SurveyDataViewModel();

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
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

  ListView buildListViewBody() {
    return ListView.builder(
      itemCount: widget.surveyData[0].questions.length,
      itemBuilder: (context, index1) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.surveyData[1][index1].title,
              style: const TextStyle(
                  color: const Color(0xff221c43),
                  fontWeight: FontWeight.w500,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                itemCount: widget.surveyData[1][index1].answers.length,
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    title: Text(
                      widget.surveyData[1][index1].answers[index].toString(),
                    ),
                    value:
                        widget.surveyData[1][index1].answers[index].toString(),
                    groupValue: widget.surveyData[1][index1].selectedAnswer,
                    onChanged: (value) {
                      setState(
                        () {
                          widget.surveyData[1][index1].selectedAnswer =
                              value.toString();
                          print(widget.surveyData[1][index1].selectedAnswer);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
