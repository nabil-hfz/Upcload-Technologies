import 'package:flutter/material.dart';
import 'package:upcload_technology/core/resources/edge_margin.dart';
import 'package:upcload_technology/core/resources/global_color.dart';
import 'package:upcload_technology/core/ui/base_shimmer.dart';
import 'package:upcload_technology/core/utils/width_height.dart';

class CardListShimmerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = globalSize.setWidthPercentage(100, context);
    double height = globalSize.setHeightPercentage(100, context) -
        AppBar().preferredSize.height -
        MediaQuery.of(context).viewPadding.top;
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: EdgeMargin.subSubMin),
      itemBuilder: (context, index) => Container(
        width: width * .8,
        height: height * .28,
        child: BaseShimmerWidget(
          child: Card(
            margin:
                const EdgeInsets.symmetric(horizontal: EdgeMargin.subSubMin),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            color: globalColor.globalWhite,
            child: Stack(
              children: [],
            ),
          ),
        ),
      ),
      itemCount: 10,
    );
  }
}
