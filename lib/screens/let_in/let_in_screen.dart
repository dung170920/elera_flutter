import 'package:elera/routes/routes.dart';
import 'package:elera/screens/let_in/cubit/let_in_cubit.dart';
import 'package:elera/screens/sign_in/cubit/sign_in_cubit.dart';
import 'package:elera/theme/theme.dart';
import 'package:elera/constants/constants.dart';
import 'package:elera/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LetInScreen extends StatefulWidget {
  const LetInScreen({super.key});

  @override
  State<LetInScreen> createState() => _LetInScreenState();
}

class _LetInScreenState extends State<LetInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: 200.w,
                  width: double.maxFinite,
                  child: Image.asset(letIn),
                ),
              ),
              Text(
                "Let’s you in",
                style: AppTextStyles.h1(),
              ),
              SizedBox(
                height: 4.w,
              ),
              Column(
                children: Data.getThirdSignInList()
                    .map(
                      (e) => BlocBuilder<SignInCubit, SignInState>(
                        builder: (context, state) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 16.w),
                            child: AppOutlinedButton.primary(
                              onPressed: () async {
                                switch (e.img) {
                                  case google:
                                    context
                                        .read<LetInCubit>()
                                        .signInWithGoogle();
                                    break;
                                  default:
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    e.img!,
                                    height: 24.w,
                                    width: 24.w,
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Text(
                                    e.title!,
                                    style: AppTextStyles.bodyLarge(
                                        FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'or',
                      style: AppTextStyles.bodyXLarge(
                          FontWeight.w600, AppColors.greyScaleColor[700]),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(
                height: 8.w,
              ),
              AppElevatedButton.primary(
                color: AppColors.primaryColor,
                radius: 100,
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.SIGN_IN,
                ),
                child: Center(
                  child: Text(
                    'Sign in with password',
                    style: AppTextStyles.bodyLarge(
                        FontWeight.bold, AppColors.lightColor),
                  ),
                ),
              ),
              SizedBox(
                height: 16.w,
              ),
              TextWithLink(
                text: 'Don’t have an account?',
                linkText: 'Sign up',
                linkAction: () => Navigator.pushNamed(
                  context,
                  AppRoutes.SIGN_UP,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
