import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:http/http.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/web3dart.dart';

import 'IEthereumChainService.dart';

class EthereumChainService extends IEthereumChainService {
  static EthereumChainService? _instance;
  static EthereumChainService get instance =>
      _instance ??= EthereumChainService._init();
  EthereumChainService._init();

  late Web3Client ethClient;
  late Client httpClient;

  @override
  Future<List?>? query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract!.function(functionName);
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);
    return result;
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
  }

  @override
  Future<void> createParticipant(String name, BigInt age) async {
    var result = await submit('createParticipant', [name, age]);
    print(result);
  }

  @override
  Future<String?>? submit(String functionName, List<dynamic> args) async {
    String? metamaskPrivateKey = DotEnv.env['METAMASK'];
    EthPrivateKey credentials = EthPrivateKey.fromHex(metamaskPrivateKey!);
    DeployedContract? contract =
        await EthereumChainService.instance.loadContract();
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
}
