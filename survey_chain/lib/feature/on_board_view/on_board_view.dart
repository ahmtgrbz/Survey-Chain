import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardView extends StatefulWidget {
  @override
  _OnboardViewState createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff221C43),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          SvgPicture.asset(
            'assets/image/Checklist-pana.svg',
            height: 370,
            width: 370,
          ),
          Spacer(),
          Text(
            "Hello!\nLet’s help us to some\nquick questions...",
            style: const TextStyle(
                color: const Color(0xfffafafa),
                fontWeight: FontWeight.w500,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 26.0),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Text(
            "Help us with a couple of questions\nand earn tokens!",
            style: const TextStyle(
                color: const Color(0xccfafafa),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          InkWell(
            onTap: () => {},
            child: Container(
              child: Center(
                child: Text("Let’s Start",
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
          Spacer(),
        ],
      ),
    );
  }
}
