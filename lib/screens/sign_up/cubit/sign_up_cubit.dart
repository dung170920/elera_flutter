import 'package:bloc/bloc.dart';
import 'package:elera/services/services.dart';
import 'package:elera/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthService _authService;

  SignUpCubit(this._authService) : super(SignUpState.inital());

  void onNameChanged(String name) => emit(
        state.copyWith(
          name: TextInput.pure(value: name),
          status: FormzSubmissionStatus.initial,
        ),
      );

  void onEmailChanged(String email) => emit(
        state.copyWith(
          email: EmailInput.pure(email),
          status: FormzSubmissionStatus.initial,
        ),
      );

  void onPasswordChanged(String password) => emit(
        state.copyWith(
          password: PasswordInput.pure(password),
          status: FormzSubmissionStatus.initial,
        ),
      );

  void onRePasswordChanged(String rePassword) => emit(
        state.copyWith(
          rePassword: RePasswordInput.pure(
            state.password.value,
            rePassword,
          ),
          status: FormzSubmissionStatus.initial,
        ),
      );

  void signUpSubmitted() async {
    if (state.status == FormzSubmissionStatus.inProgress) return;

    final name = TextInput.dirty(value: state.name.value, max: 20);
    final email = EmailInput.dirty(state.email.value);
    final password = PasswordInput.dirty(state.password.value);
    final rePassword = RePasswordInput.dirty(
        password: password.value, value: state.rePassword.value);
    emit(
      state.copyWith(
        name: name,
        email: email,
        password: password,
        rePassword: rePassword,
      ),
    );

    print(Formz.validate([name, email, password, rePassword]));

    if (Formz.validate([name, email, password, rePassword])) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.inProgress,
        ),
      );
      try {
        await _authService.signUp({
          "email": email.value,
          "password": password.value,
          "name": name.value,
          "confirmPassword": rePassword.value
        });

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } on AppExceptions catch (e) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: e.message,
        ));
      } catch (_) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
        ));
      }
    }
  }
}
