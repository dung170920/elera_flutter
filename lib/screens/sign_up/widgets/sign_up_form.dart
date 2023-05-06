import 'package:elera/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:elera/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _focusNodes = List.generate(4, (index) => FocusNode()).toList();

  @override
  void initState() {
    super.initState();
    _focusNodes
        .forEach((element) => element.addListener(() => setState(() {})));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                label: 'Full name',
                hintText: 'Full name',
                textFieldType: TextInputType.name,
                prefix: Icon(MyIcons.solidUser),
                focus: _focusNodes[0],
                nextFocus: _focusNodes[1],
                onChanged: (value) {
                  context.read<SignUpCubit>().onNameChanged(value);
                },
              ),
              SizedBox(
                height: 20.w,
              ),
              AppTextField(
                label: 'Email',
                hintText: 'Email',
                textFieldType: TextInputType.emailAddress,
                prefix: Icon(MyIcons.solidEnvelope),
                focus: _focusNodes[1],
                nextFocus: _focusNodes[2],
                onChanged: (value) {
                  context.read<SignUpCubit>().onEmailChanged(value);
                },
              ),
              SizedBox(
                height: 20.w,
              ),
              AppTextField(
                label: 'Password',
                hintText: 'Password',
                textFieldType: TextInputType.text,
                isPassword: true,
                prefix: Icon(MyIcons.solidLock),
                focus: _focusNodes[2],
                nextFocus: _focusNodes[3],
                onChanged: (value) {
                  context.read<SignUpCubit>().onPasswordChanged(value);
                },
              ),
              SizedBox(
                height: 20.w,
              ),
              AppTextField(
                label: 'Confirm Password',
                hintText: 'Confirm Password',
                textFieldType: TextInputType.text,
                isPassword: true,
                prefix: Icon(MyIcons.solidLock),
                focus: _focusNodes[3],
                onChanged: (value) {
                  context.read<SignUpCubit>().onRePasswordChanged(value);
                },
              ),
              SizedBox(
                height: 20.w,
              ),
              AppElevatedButton.primary(
                color: AppColors.primaryColor,
                radius: 100,
                onPressed: state.status == FormzSubmissionStatus.inProgress
                    ? null
                    : () => context.read<SignUpCubit>().signUpSubmitted(),
                child: Text(
                  'Sign up',
                  style: AppTextStyle.bodyLarge(
                    FontWeight.bold,
                    AppColors.lightColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}