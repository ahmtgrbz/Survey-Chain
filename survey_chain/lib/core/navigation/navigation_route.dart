import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:survey_chain/core/constants/navigation_constants.dart';
import 'package:survey_chain/feature/home_view/view/home_view.dart';
import 'package:survey_chain/feature/login_view/login_view.dart';
import 'package:survey_chain/feature/on_board_view/on_board_view.dart';
import 'package:survey_chain/feature/survey_detail_view/survey_detail_view.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.ONBOARD_VIEW:
        return normalNavigate(OnboardView());
      case NavigationConstants.LOGIN_VIEW:
        return normalNavigate(LoginView());
      case NavigationConstants.HOME_VIEW:
        return normalNavigate(HomeView());
      case NavigationConstants.SURVEY_DETAIL:
        return normalNavigate(SurveyDetailView());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('PAGE NOT FOUND!'),
            ),
          ),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }
}
