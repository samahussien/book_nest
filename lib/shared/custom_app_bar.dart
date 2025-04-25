  import 'package:book_nest/utils/assets.dart';
import 'package:book_nest/utils/colors.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(double width) {
    return AppBar(
        elevation: 0,
      
        surfaceTintColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: AppColors.primary,
            height: 1.0,
          ),
        ),
        title: SizedBox(
          height: kToolbarHeight * 0.6,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.primaryLogo,
                fit: BoxFit.contain,
              ),
              SizedBox(
                width: width * 0.03,
              ),
              Image.asset(
                AppAssets.primaryBookNest,
                fit: BoxFit.contain,
                width: width * 0.4,
              ),
            ],
          ),
        ),
      );
  }
  