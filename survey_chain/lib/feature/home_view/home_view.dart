import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import 'service/ethereum_chain_service.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var metamaskAddress = '0x07DcFf621b8D5d1fD69b9328fB1cb7504Bc98901';

  @override
  void initState() {
    super.initState();
    EthereumChainService.instance.httpClient = Client();
    EthereumChainService.instance.ethClient = Web3Client(
      'https://ropsten.infura.io/v3/48a0bdb48ab24a9c859fa60e8068b8de',
      EthereumChainService.instance.httpClient,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //EthereumChainService.instance.getParticipantCount();
              EthereumChainService.instance
                  .createParticipant('Alican', BigInt.from(21));
            },
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
