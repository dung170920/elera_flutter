import 'package:elera/constants/constants.dart';
import 'package:elera/theme/theme.dart';
import 'package:elera/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magicon/magicon.dart';

class MentorButtons extends StatelessWidget {
  const MentorButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          Expanded(
            child: AppElevatedButton.primary(
              radius: 100,
              onPressed: () {},
              size: ButtonSize.medium,
              child: Row(
                children: [
                  Icon(
                    Magicon.solidCommentDots,
                    color: AppColors.lightColor,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    'Message',
                    style: AppTextStyles.bodyXLarge(
                        FontWeight.bold, AppColors.lightColor),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          Expanded(
            child: AppOutlinedButton.primary(
              radius: 100,
              onPressed: () {},
              color: AppColors.primaryColor,
              size: ButtonSize.medium,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Magicon.solidUserPlus,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    'Follow',
                    style: AppTextStyles.bodyXLarge(
                        FontWeight.bold, AppColors.primaryColor),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
