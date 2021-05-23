import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Web3Client ethClient;
  late Client httpClient;
  var metamaskAddress = '0x07DcFf621b8D5d1fD69b9328fB1cb7504Bc98901';

  @override
  void initState() {
    super.initState();
    httpClient = Client();
    ethClient = Web3Client('HTTP://127.0.0.1:7545', httpClient);
  }

  Future<DeployedContract?> loadContract() async {
    var abiJson = await rootBundle.loadString('assets/json/survey_list.json');
    var contractAddress = '0x24589F2e9732afa472FAdC16477cBE32813c278B';

    final contract = DeployedContract(
      ContractAbi.fromJson(abiJson, 'Survey'),
      EthereumAddress.fromHex(contractAddress),
    );

    return contract;
  }

  Future<List?>? query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract!.function(functionName);
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
                width: 325,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x26000000),
                          offset: Offset(0, 4),
                          blurRadius: 20,
                          spreadRadius: 0)
                    ],
                    color: const Color(0xffffffff))),
          ),
        ),
      ),
    );
  }
}
