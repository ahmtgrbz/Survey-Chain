import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../core/constants/navigation_constants.dart';
import '../../core/navigation/navigation_service.dart';
import '../home_view/model/participant_model.dart';
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

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  static final RegExp numberRegexp = RegExp(r'\d');
  var fToast = FToast();
  String? metamaskPrivateKey = DotEnv.env['METAMASK'];

  ParticipantModel participantModel =
      ParticipantModel(name: '', age: BigInt.from(0));

  @override
  void initState() {
    super.initState();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff221C43),
      body: buildFormBody(context),
    );
  }

  Form buildFormBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: buildColumnBody(context),
    );
  }

  Column buildColumnBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(
          flex: 3,
        ),
        buildCenterImage(),
        Spacer(
          flex: 3,
        ),
        buildTextInTheMiddle(),
        Spacer(
          flex: 3,
        ),
        buildNameTextField(),
        Spacer(
          flex: 1,
        ),
        buildAgeTextField(),
        Spacer(
          flex: 3,
        ),
        buildInkWellLoginButton(context),
        Spacer(
          flex: 3,
        ),
      ],
    );
  }

  Center buildCenterImage() {
    return Center(
      child: SvgPicture.asset(
        'assets/image/chain.svg',
        alignment: Alignment.center,
        height: 250,
        width: 250,
      ),
    );
  }

  Text buildTextInTheMiddle() {
    return Text(
      "To discover surveys\nshare your informations\nwith us.",
      style: const TextStyle(
          color: const Color(0xfffafafa),
          fontWeight: FontWeight.w500,
          fontFamily: "Roboto",
          fontStyle: FontStyle.normal,
          fontSize: 26.0),
      textAlign: TextAlign.center,
    );
  }

  Padding buildNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 65.0),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: _nameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Name can not be empty';
          } else {
            participantModel.name = value;
            print(participantModel.name);
          }
        },
        decoration: InputDecoration(
          labelText: "Name",
          labelStyle: TextStyle(
            color: Color(0xffE1B000),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Color(0xffE1B000),
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Color(0xffE1B000),
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  Padding buildAgeTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 65.0),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: _ageController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value != null &&
              value.isNotEmpty &&
              numberRegexp.hasMatch(value)) {
            var val = int.parse(value);
            participantModel.age = BigInt.from(val);
            print(participantModel.age);
          } else {
            return 'Enter valid an age!';
          }
        },
        decoration: InputDecoration(
          labelText: "Age",
          labelStyle: TextStyle(
            color: Color(0xffE1B000),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Color(0xffE1B000), width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Color(0xffE1B000),
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  InkWell buildInkWellLoginButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        EthPrivateKey credentials = EthPrivateKey.fromHex(metamaskPrivateKey!);
        var data =
            await _homeViewModel.service.getParticipant(credentials.address);
        if (_formKey.currentState!.validate()) {
          if (data!.name == '') {
            print('BURDA');
            await _homeViewModel.service.createParticipant(
                participantModel.name!, participantModel.age!);

            buildShowToastSuccessRegister(fToast, context);

            await NavigationService.instance.navigateToPage(
              path: NavigationConstants.HOME_VIEW,
              data: participantModel,
            );
          } else {
            if (participantModel.name == data.name &&
                participantModel.age == data.age) {
              buildShowToastSuccessLogin(fToast, context);
              await NavigationService.instance.navigateToPage(
                path: NavigationConstants.HOME_VIEW,
                data: participantModel,
              );
            } else {
              buildShowToastErrorLogin(fToast, context);
            }
          }
        }
      },
      child: Container(
        child: Center(
          child: Text("Discover Surveys",
              style: const TextStyle(
                  color: const Color(0xff221c43),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0),
              textAlign: TextAlign.center),
        ),
        width: 260,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: const Color(0xffe1b000),
        ),
      ),
    );
  }

  void buildShowToastSuccessRegister(FToast fToast, BuildContext context) {
    return fToast.showToast(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Success Register',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  void buildShowToastSuccessLogin(FToast fToast, BuildContext context) {
    return fToast.showToast(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Success Login',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  void buildShowToastErrorLogin(FToast fToast, BuildContext context) {
    return fToast.showToast(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Name or Age is different!',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
