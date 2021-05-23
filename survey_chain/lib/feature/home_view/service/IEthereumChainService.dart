import 'package:web3dart/contracts.dart';

abstract class IEthereumChainService {
  Future<List?>? query(String functionName, List<dynamic> args);
  Future<DeployedContract?> loadContract();
  Future<BigInt?> getParticipantCount();
  Future<void> createParticipant(String name, BigInt age);
  Future<String?>? submit(String functionName, List<dynamic> args);
}
