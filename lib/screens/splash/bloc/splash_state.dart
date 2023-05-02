part of 'splash_bloc.dart';

class SplashState extends Equatable {
  final AuthStatus status;
  final UserModel user;

  const SplashState._({
    required this.status,
    this.user = UserModel.empty,
  });

  const SplashState.authenicated(UserModel user)
      : this._(
          status: AuthStatus.authenticated,
          user: user,
        );

  const SplashState.unAuthenticated()
      : this._(
          status: AuthStatus.unAuthenticated,
        );

  @override
  List<Object> get props => [status, user];
}
