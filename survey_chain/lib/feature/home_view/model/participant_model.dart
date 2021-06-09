import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:web3dart/credentials.dart';

part 'participant_model.g.dart';

final metamaskAddress = DotEnv.env['METAMASK'];
EthPrivateKey credentials = EthPrivateKey.fromHex(metamaskAddress!);

@JsonSerializable()
class ParticipantModel {
  String? address = credentials.address.toString();
  String? name;
  BigInt? age;
  bool? isParticipant = true;

  ParticipantModel({
    this.name,
    this.age,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return _$ParticipantModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ParticipantModelToJson(this);
  }
}
