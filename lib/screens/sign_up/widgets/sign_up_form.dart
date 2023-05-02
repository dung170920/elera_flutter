import 'package:elera/screens/sign_up/bloc/bloc.dart';
import 'package:elera/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _focusNodes = List.generate(4, (index) => FocusNode()).toList();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _rePassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _focusNodes
        .forEach((element) => element.addListener(() => setState(() {})));
  }

  Future<void> _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        final state = context.read<SignUpBloc>().state;
        String fullName = state.fullName;
        String email = state.email;
        String password = state.password;
        String rePassword = state.rePassword;
        final auth = FirebaseAuth.instance;

        if (password.compareTo(rePassword) != 0) {}

        final credential = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        if (credential.user == null) {
          return;
        }

        if (!credential.user!.emailVerified) {
          credential.user!.sendEmailVerification();
          AppSnackbar.show(context: context, title: 'verify');
          return;
        }

        AppSnackbar.show(context: context, title: 'Login successfully');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AppSnackbar.show(
              context: context, title: 'No user found with this email');
          return;
        }
        if (e.code == 'wrong-password') {
          AppSnackbar.show(context: context, title: 'Password is wrong');
          return;
        }
        if (e.code == 'invalid-email') {
          AppSnackbar.show(context: context, title: 'Email format is wrong');
          return;
        }
        if (e.code == 'too-many-requests') {
          AppSnackbar.show(
              context: context,
              title: 'Account block because password is wrong many time');
          return;
        }
        print(e.code);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            label: 'Full name',
            hintText: 'Full name',
            textFieldType: TextInputType.name,
            prefix: Icon(MyIcons.solidUser),
            focus: _focusNodes[0],
            controller: _nameController,
            nextFocus: _focusNodes[1],
            onChanged: (value) {
              context.read<SignUpBloc>().add(EmailEvent(value));
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
            controller: _emailController,
            nextFocus: _focusNodes[2],
            onChanged: (value) {
              context.read<SignUpBloc>().add(EmailEvent(value));
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
            controller: _passController,
            onChanged: (value) {
              context.read<SignUpBloc>().add(PasswordEvent(value));
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
            controller: _rePassController,
            onChanged: (value) {
              context.read<SignUpBloc>().add(PasswordEvent(value));
            },
          ),
          SizedBox(
            height: 20.w,
          ),
          AppElevatedButton.primary(
            color: AppColors.primaryColor,
            radius: 100,
            onPressed: () {
              _handleSignUp();
            },
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
  }
}
