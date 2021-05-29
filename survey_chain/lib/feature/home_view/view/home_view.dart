import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../../core/constants/navigation_constants.dart';
import '../../../core/navigation/navigation_service.dart';
import '../service/ethereum_chain_service.dart';
import '../viewmodel/home_view_model.dart';

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

class HomeView extends StatelessWidget {
  final participantModel;

  const HomeView({Key? key, this.participantModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              print(participantModel.name);
            },
            icon: Icon(Icons.account_box_outlined),
          )
        ],
        elevation: 0,
        backgroundColor: Color(0xff221C43),
        title: Text("Today’s Surveys",
            style: const TextStyle(
                color: const Color(0xfffafafa),
                fontWeight: FontWeight.w700,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 24.0),
            textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) {
          return _homeViewModel.isLoading
              ? buildCircularProgressIndicator()
              : buildListViewBody();
        },
      ),
    );
  }

  Center buildCircularProgressIndicator() =>
      Center(child: CircularProgressIndicator());

  ListView buildListViewBody() {
    return ListView.builder(
      itemCount: _homeViewModel.surveyList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: InkWell(
          onTap: () async {
            var data = await _homeViewModel
                .surveyToQuestions(_homeViewModel.surveyList[index]);
            print(data);
            await NavigationService.instance.navigateToPage(
                path: NavigationConstants.SURVEY_DETAIL,
                data: [_homeViewModel.surveyList[index], data, index]);
          },
          child: Card(
            child: ListTile(
              leading: FlutterLogo(
                curve: Curves.bounceInOut,
              ),
              title: Text(_homeViewModel.surveyList[index].name.toString()),
              subtitle: Text('Question Count: ' +
                  _homeViewModel.surveyList[index].questions!.length
                      .toString()),
            ),
          ),
        ),
      ),
    );
  }
}
