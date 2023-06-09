import 'package:elera/constants/constants.dart';
import 'package:elera/models/models.dart';
import 'package:elera/routes/routes.dart';
import 'package:elera/screens/course_detail/cubit/course_detail_cubit.dart';
import 'package:elera/screens/profile/cubit/profile_cubit.dart';
import 'package:elera/theme/theme.dart';
import 'package:elera/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magicon/magicon.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CourseDetailCubit>().getCourse(course.id);
        Navigator.pushNamed(context, AppRoutes.COURSE_DETAIL);
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: context.read<ProfileCubit>().state.theme == AppTheme.lightTheme
              ? AppColors.lightColor
              : AppColors.darkColor[2],
          borderRadius: radiusCircular(AppStyles.DEFAULT_LARGE_RADIUS),
          boxShadow: AppStyles.cardShadow[2]!,
        ),
        width: double.maxFinite,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: radiusCircular(20),
              child: Image.network(
                course.imageUrl ?? '',
                width: 120.w,
                height: 120.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTag.inverted(
                          status: StatusType.INFO, text: course.type!.name),
                      InkWell(
                        child: Icon(
                          Magicon.bookmark,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.w,
                  ),
                  Text(
                    course.title ?? '',
                    style: AppTextStyle.h6(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 12.w,
                  ),
                  Text(
                    formatCurrency(price: course.price!, symbol: '\$'),
                    style: AppTextStyle.h6(AppColors.primaryColor),
                  ),
                  // course.salePrice != null
                  //     ? Row(
                  //         children: [
                  //           Text(
                  //             formatCurrency(
                  //                 price: course.salePrice!, symbol: '\$'),
                  //             style: AppTextStyle.h6(AppColors.primaryColor),
                  //           ),
                  //           SizedBox(
                  //             width: 8.w,
                  //           ),
                  //           Text(
                  //             formatCurrency(
                  //                 price: course.price!, symbol: '\$'),
                  //             style: AppTextStyle.bodySmall(
                  //               FontWeight.w500,
                  //               AppColors.greyScaleColor[700],
                  //             ).copyWith(
                  //                 decoration: TextDecoration.lineThrough),
                  //           ),
                  //         ],
                  //       )
                  //     : Text(
                  //         formatCurrency(price: course.price!, symbol: '\$'),
                  //         style: AppTextStyle.h6(AppColors.primaryColor),
                  //       ),
                  SizedBox(
                    height: 12.w,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Magicon.solidStarHalf,
                        size: 20,
                        color: StatusType.WARNING.color,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        course.rate!.toString(),
                        style: AppTextStyle.bodySmall(
                          FontWeight.w500,
                          AppColors.greyScaleColor[700],
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        '|',
                        style: AppTextStyle.bodySmall(
                          FontWeight.w500,
                          AppColors.greyScaleColor[700],
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          '${formatCurrency(price: double.parse(course.studentsCount!.toString()))} students',
                          style: AppTextStyle.bodySmall(
                            FontWeight.w500,
                            AppColors.greyScaleColor[700],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
