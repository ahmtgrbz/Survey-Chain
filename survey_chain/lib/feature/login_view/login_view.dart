import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:survey_chain/feature/home_view/service/ethereum_chain_service.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  static final RegExp nameRegexp = RegExp('[a-zA-Z]');
  static final RegExp numberRegexp = RegExp(r'\d');

  String _userName = '';
  late BigInt _userAge;

  @override
  void initState() {
    super.initState();
    String? infuraLink = DotEnv.env['INFURA'];
    EthereumChainService.instance.httpClient = Client();
    EthereumChainService.instance.ethClient = Web3Client(
      infuraLink!,
      EthereumChainService.instance.httpClient,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff221C43),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(
              flex: 3,
            ),
            Center(
              child: SvgPicture.asset(
                'assets/image/chain.svg',
                alignment: Alignment.center,
                height: 250,
                width: 250,
              ),
            ),
            Spacer(
              flex: 3,
            ),
            Text(
              "To discover surveys\nshare your informations\nwith us.",
              style: const TextStyle(
                  color: const Color(0xfffafafa),
                  fontWeight: FontWeight.w500,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 26.0),
              textAlign: TextAlign.center,
            ),
            Spacer(
              flex: 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 65.0),
              child: TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    'Name can not be empty';
                  } else {
                    _userName = value;
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
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 65.0),
              child: TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null &&
                      value.isNotEmpty &&
                      numberRegexp.hasMatch(value)) {
                    var val = int.parse(value);
                    _userAge = BigInt.from(val);
                  } else {
                    'Enter valid an age!';
                  }
                },
                decoration: InputDecoration(
                  labelText: "Age",
                  labelStyle: TextStyle(
                    color: Color(0xffE1B000),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide:
                        BorderSide(color: Color(0xffE1B000), width: 2.0),
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
            ),
            Spacer(
              flex: 3,
            ),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  EthereumChainService.instance
                      .createParticipant(_userName, _userAge);
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
            ),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
