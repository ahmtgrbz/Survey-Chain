import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:http/http.dart';
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

class SurveyDetailView extends StatefulWidget {
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
            onPressed: () {
              _homeViewModel.service.getQuestion(0);
            },
            icon: Icon(Icons.data_saver_off),
          ),
        ],
        centerTitle: true,
        backgroundColor: Color(0xff221c43),
        title: Text("Facebook Business Survey",
            style: const TextStyle(
                color: const Color(0xfffafafa),
                fontWeight: FontWeight.w700,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 20.0),
            textAlign: TextAlign.center),
      ),
      body: _homeViewModel.isLoading
          ? CircularProgressIndicator()
          : buildListViewBody(),
    );
  }

  ListView buildListViewBody() {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => Column(
        children: [
          Text(
            _homeViewModel.questionMap.keys.toList()[index],
            style: const TextStyle(
                color: const Color(0xff221c43),
                fontWeight: FontWeight.w500,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 20.0),
            textAlign: TextAlign.left,
          ),
          Container(
            height: 150,
          ),
        ],
      ),
    );
  }
}
