import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:http/http.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/web3dart.dart';

import 'IEthereumChainService.dart';

class EthereumChainService extends IEthereumChainService {
  EthereumChainService(Web3Client ethClient, Client httpClient)
      : super(ethClient, httpClient);

  @override
  Future<List?>? query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract!.function(functionName);
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);
    return result;
  }

  @override
  Future<String?>? submit(String functionName, List<dynamic> args) async {
    String? metamaskPrivateKey = DotEnv.env['METAMASK'];
    EthPrivateKey credentials = EthPrivateKey.fromHex(metamaskPrivateKey!);
    DeployedContract? contract = await loadContract();
    if (contract != null) {
      final ethFunction = contract.function(functionName);
      final result = await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract, function: ethFunction, parameters: args),
        chainId: 3,
        //fetchChainIdFromNetworkId: true,
      );
      return result;
    } else {
      throw Exception();
    }
  }

  @override
  Future<DeployedContract?> loadContract() async {
    var abiJson = await rootBundle.loadString('assets/json/survey_list.json');
    var contractAddress = DotEnv.env['CONTRACT_ADDRESS'];

    final contract = DeployedContract(
      ContractAbi.fromJson(abiJson, 'Survey'),
      EthereumAddress.fromHex(contractAddress!),
    );

    return contract;
  }

  Future<BigInt?> getParticipantCount() async {
    var result = await query('getParticipantCount', []);
    if (result is List) {
      return result[0];
    }
    throw Exception(); // ERROR
  }

  @override
  Future<void> createParticipant(String name, BigInt age) async {
    var result = await submit('createParticipant', [name, age]);
    print(result);
  }

  @override
  Future<List?>? getSurvey(int id) async {
    var result = await query('getSurvey', [BigInt.from(id)]);

    if (result != null) {
      return result;
    }
    throw Exception();
  }

  @override
  Future<List<dynamic>?>? getQuestion(int id) async {
    var result = await query('getQuestion', [BigInt.from(id)]);

    if (result != null) {
      return result;
    }
    throw Exception();
  }

  @override
  Future<int>? getSurveyCount() async {
    var result = await query('getSurveyCount', []);
    if (result is List) {
      var bigIntData = result[0];
      return bigIntData.toInt();
    }
    throw Exception(); // ERROR
  }

  @override
  Future<int>? getQuestionCount() async {
    var result = await query('getQuestionCount', []);
    if (result is List) {
      var bigIntData = result[0];
      return bigIntData.toInt();
    }
    throw Exception(); // ERROR
  }
}
