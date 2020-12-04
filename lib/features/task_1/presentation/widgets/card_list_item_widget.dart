import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upcload_technology/core/resources/edge_margin.dart';
import 'package:upcload_technology/core/resources/global_color.dart';
import 'package:upcload_technology/core/resources/text_size.dart';
import 'package:upcload_technology/core/resources/text_style.dart';
import 'package:upcload_technology/core/utils/width_height.dart';
import 'package:upcload_technology/features/task_1/domain/entities/google_data_map_entity.dart';

import 'basic_avatar.dart';

class CardListItemWidget extends StatelessWidget {
  final Function onTap;
  final GoogleMapDataEntity entity;

  CardListItemWidget({this.onTap, this.entity});

  @override
  Widget build(BuildContext context) {
    double width = globalSize.setWidthPercentage(100, context);
    double height = globalSize.setHeightPercentage(100, context) -
        AppBar().preferredSize.height -
        MediaQuery.of(context).viewPadding.top;
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              margin: const EdgeInsets.symmetric(
                horizontal: EdgeMargin.subSubMin,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              color: globalColor.globalWhite.withOpacity(0.9),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: EdgeMargin.subSubMin,
                  vertical: EdgeMargin.subSubMin,
                ),
                width: width * .8,
                height: height * .28,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          (entity?.index + 1).toString(),
                          style: textStyle.middleTSBasic.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: textSize.subBig,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '~',
                          style: textStyle.middleTSBasic.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: textSize.subBig,
                              color: Colors.lightBlue),
                        ),
                        Text(
                          "${entity?.distance.toString()}km" ?? ' 0 ',
                          style: textStyle.middleTSBasic.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: textSize.subBig,
                              color: Colors.lightBlue),
                        ),
                        Text(
                          '~',
                          style: textStyle.middleTSBasic.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: textSize.subBig,
                              color: Colors.lightBlue),
                        ),
                        SizedBox(width: 10.w),
                        InkWell(
                          focusColor: globalColor.primary,
                          //highlightColor: globalColor.globalGrey,
                          //splashColor: globalColor.globalGrey,
                          onTap: () {
                            Fluttertoast.showToast(msg: 'Save button Clicked');
                          },
                          child: Icon(
                            entity.isSaved ? Entypo.save : Feather.save,
                            size: 28,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.w),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 20.w),
                            Container(
                              constraints: BoxConstraints(maxWidth: width * .8),
                              child: Text(
                                entity.name,
                                style: textStyle.middleTSBasic.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: textSize.subBig,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14.w),
                        Row(
                          children: [
                            SizedBox(width: 20.w),
                            Container(
                              constraints: BoxConstraints(maxWidth: width * .7),
                              child: Text(
                                entity.clinic,
                                style: textStyle.middleTSBasic.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: textSize.normal,
                                ),
                              ),
                            ),
                            Container(
                              height: 20.w,
                              width: 2,
                              color: globalColor.black,
                              margin: const EdgeInsets.symmetric(
                                horizontal: EdgeMargin.subSubMin,
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(maxWidth: width * .2),
                              child: Text(
                                entity?.rate?.toString() ?? '0.0',
                                style: textStyle.middleTSBasic.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: textSize.normal,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            InkWell(
                              focusColor: globalColor.primary,
                              //highlightColor: globalColor.globalGrey,
                              //splashColor: globalColor.globalGrey,
                              onTap: () {
                                Fluttertoast.showToast(
                                    msg: 'Like button Clicked');
                              },
                              child: Icon(
                                entity.isLiked
                                    ? AntDesign.like1
                                    : AntDesign.like2,
                                size: 22,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14.w),
                        Row(
                          children: [
                            SizedBox(width: 20.w),
                            Container(
                              constraints: BoxConstraints(maxWidth: width * .7),
                              child: Text(
                                entity.profession,
                                style: textStyle.middleTSBasic.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: textSize.normal,
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    //    SizedBox(height: 14.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(icon: Icon(Entypo.chat), onPressed: () {}),
                        IconButton(
                            icon: Icon(FontAwesome.video_camera),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(Foundation.telephone), onPressed: () {}),
                        InkWell(
                          focusColor: globalColor.globalGrey,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: Text(
                                "\$${entity?.price?.toString()}",
                                style: textStyle.middleTSBasic.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: textSize.normal,
                                  color: Colors.lightGreen,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 34,
            top: 0,
            child: BasicAvatar(
              imageUrl: entity.imageUrl,
              radius: 50,
            ),
          ),
        ],
      ),
    );
  }
}
