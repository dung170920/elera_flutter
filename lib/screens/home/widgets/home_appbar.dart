import 'package:elera/constants/constants.dart';
import 'package:elera/routes/routes.dart';
import 'package:elera/screens/notification/cubit/notification_cubit.dart';
import 'package:elera/screens/splash/cubit/splash_cubit.dart';
import 'package:elera/theme/theme.dart';
import 'package:elera/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magicon/magicon.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(24.w),
          child: AppBar(
            leadingWidth: 48.w,
            leading: CacheImage(
              image: state.user.avatar ?? logo,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back',
                  style: AppTextStyles.bodyLarge(
                      FontWeight.normal, AppColors.greyScaleColor[600]),
                ),
                Text(
                  context.read<SplashCubit>().state.user.name ?? '',
                  style: AppTextStyles.h5(),
                ),
              ],
            ),
            actions: [
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.NOTIFICATION),
                child: Stack(
                  children: [
                    Icon(
                      Magicon.bell,
                      size: 28.w,
                    ),
                    context
                            .watch<NotificationCubit>()
                            .state
                            .items
                            .any((element) => !element.isRead)
                        ? Positioned(
                            right: 3.w,
                            top: 1.w,
                            child: CircleAvatar(
                              backgroundColor: StatusType.ERROR.color,
                              radius: 4.w,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
