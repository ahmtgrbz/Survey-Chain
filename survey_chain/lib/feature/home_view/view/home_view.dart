import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart';
import 'package:survey_chain/core/constants/navigation_constants.dart';
import 'package:survey_chain/core/navigation/navigation_service.dart';
import 'package:survey_chain/feature/home_view/viewmodel/home_view_model.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import '../service/ethereum_chain_service.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.create),
            ),
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
        body: Observer(builder: (_) {
          return _homeViewModel.isLoading
              ? buildCircularProgressIndicator()
              : buildListViewBody();
        }));
  }

  Center buildCircularProgressIndicator() =>
      Center(child: CircularProgressIndicator());

  ListView buildListViewBody() {
    return ListView.builder(
      itemCount: _homeViewModel.surveyMap.length,
      itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          child: InkWell(
            onTap: () {
              NavigationService.instance
                  .navigateToPage(path: NavigationConstants.SURVEY_DETAIL);
            },
            child: Card(
              child: ListTile(
                leading: FlutterLogo(),
                title: Text(_homeViewModel.surveyMap.keys.toList()[index]),
                subtitle: Text('Question Count: ' +
                    _homeViewModel.surveyMap.values
                        .toList()[index]
                        .length
                        .toString()),
              ),
            ),
          )),
    );
  }
}
