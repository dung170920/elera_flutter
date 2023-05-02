import 'package:elera/models/models.dart';
import 'package:elera/routes/routes.dart';
import 'package:elera/screens/home/home_screen.dart';
import 'package:elera/screens/let_in/bloc/bloc.dart';
import 'package:elera/screens/sign_in/bloc/bloc.dart';
import 'package:elera/screens/sign_up/bloc/bloc.dart';
import 'package:elera/screens/splash/bloc/splash_bloc.dart';
import 'package:elera/screens/welcome/bloc/bloc.dart';
import 'package:elera/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elera/screens/screens.dart';

class AppPages {
  static final RouteObserver<Route> observer = RouteObserver();
  static List<String> history = [];

  static List<RouteModel> Routes() {
    final AuthService _authService = AuthService();
    return [
      RouteModel(
        path: AppRoutes.SPLASH,
        page: SplashScreen(),
        bloc: BlocProvider(
          create: (_) => SplashBloc(authService: _authService),
        ),
      ),
      RouteModel(
        path: AppRoutes.WELCOME,
        page: WelcomeScreen(),
        bloc: BlocProvider(
          lazy: true,
          create: (_) => WelcomeBloc(),
        ),
      ),
      RouteModel(
        path: AppRoutes.LET_IN,
        page: LetInScreen(),
        bloc: BlocProvider(
          lazy: true,
          create: (_) => LetInBloc(),
        ),
      ),
      RouteModel(
        path: AppRoutes.SIGN_IN,
        page: SignInScreen(),
        bloc: BlocProvider(
          lazy: true,
          create: (_) => SignInBloc(),
        ),
      ),
      RouteModel(
        path: AppRoutes.SIGN_UP,
        page: SignUpScreen(),
        bloc: BlocProvider(
          lazy: true,
          create: (_) => SignUpBloc(),
        ),
      ),
      RouteModel(
        path: AppRoutes.HOME,
        page: HomeScreen(),
        bloc: BlocProvider(
          lazy: true,
          create: (_) => WelcomeBloc(),
        ),
      ),
    ];
  }

  static List<dynamic> BlocList(BuildContext context) {
    List<dynamic> list = [];
    for (var route in Routes()) {
      list.add(route.bloc);
    }
    return list;
  }

  static Route GenerateRouteSettings(RouteSettings settings) {
    var route = Routes().where((element) => element.path == settings.name);

    return MaterialPageRoute(
        builder: (_) => route.first.page, settings: settings);
  }
}
