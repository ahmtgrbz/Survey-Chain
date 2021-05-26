import 'package:http/http.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/web3dart.dart';

abstract class IEthereumChainService {
  final Web3Client ethClient;
  final Client httpClient;

  IEthereumChainService(this.ethClient, this.httpClient);

  Future<List?>? query(String functionName, List<dynamic> args);
  Future<DeployedContract?> loadContract();
  Future<BigInt?> getParticipantCount();
  Future<void> createParticipant(String name, BigInt age);
  Future<String?>? submit(String functionName, List<dynamic> args);
  Future<List?>? getSurvey(int id);
  Future<int>? getSurveyCount();
  Future<List?>? getQuestion(int id);
  Future<int>? getQuestionCount();
}
