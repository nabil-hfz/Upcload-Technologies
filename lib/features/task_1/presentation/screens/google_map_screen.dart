import 'dart:async';
import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:upcload_technology/core/errors/connection_error.dart';
import 'package:upcload_technology/core/errors/custom_error.dart';
import 'package:upcload_technology/core/errors/error_widgets.dart';
import 'package:upcload_technology/core/localization/translations.dart';
import 'package:upcload_technology/core/resources/edge_margin.dart';
import 'package:upcload_technology/core/resources/global_color.dart';
import 'package:upcload_technology/core/resources/text_style.dart';
import 'package:upcload_technology/core/utils/width_height.dart';
import 'package:upcload_technology/features/task_1/domain/entities/google_data_map_entity.dart';
import 'package:upcload_technology/features/task_1/presentation/blocs/google_map_bloc.dart';
import 'package:upcload_technology/features/task_1/presentation/widgets/card_list_item_widget.dart';
import 'package:upcload_technology/features/task_1/presentation/widgets/list_shimmer_widget.dart';

class GoogleMapScreen extends StatefulWidget {
  static const routeName = 'screens/google_map_screen';

  const GoogleMapScreen();

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final _cancelToken = CancelToken();
  final _bloc = GoogleMapBloc();
  bool isInit = false;
  Completer<GoogleMapController> _controller = Completer();
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();

    _bloc.add(GoogleMapEvent(cancelToken: _cancelToken));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      ScreenUtil.init(context, designSize: Size(480, 853));
      isInit = true;
    }
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: globalColor.primary,
      title: Text(
        Translations.of(context).translate('google_map'),
        style: textStyle.subBigTSBasic.copyWith(
          color: globalColor.globalWhite,
        ),
      ),
      centerTitle: true,
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: globalColor.globalWhite,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = buildAppBar();
    double widthS = globalSize.setWidthPercentage(100, context);
    double heightS = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Container(
          width: widthS,
          height: heightS,
          color: Colors.grey.shade300,
          child: BlocListener<GoogleMapBloc, GoogleMapState>(
            bloc: _bloc,
            listener: (context, state) async {
              if (state is GoogleMapDoneState) {
                print(Translations.of(context).translate('added_successfully'));
              }
              if (state is GoogleMapFailureState) {
                final error = state.error;
                if (error is ConnectionError) {
                  ErrorViewer.showConnectionError(context, null);
                } else if (error is CustomError) {
                  ErrorViewer.showCustomError(context, error.message);
                } else {
                  print(error);
                  ErrorViewer.showUnexpectedError(context);
                }
              }
            },
            child: BlocBuilder<GoogleMapBloc, GoogleMapState>(
              bloc: _bloc,
              builder: (context, state) {
                return Stack(
                  children: [
                    GoogleMap(
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      compassEnabled: true,
                      markers: getAllMarkers(state, widthS),
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(44.434172, 26.104319),
                        zoom: 9.4746,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: heightS * .34,
                        width: widthS,
                        margin: EdgeInsets.only(bottom: EdgeMargin.normal),
                        child: buildListOfCards(
                          height: heightS,
                          state: state,
                          width: widthS,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Set<Marker> getAllMarkers(GoogleMapState state, double width) {
    final markerList = LinkedHashSet<Marker>();
    if (state is GoogleMapDoneState) {
      state?.list?.forEach(
        (element) {
          markerList.add(
            Marker(
              onTap: () {
                itemScrollController.scrollTo(
                    index: element.index,
                    duration: Duration(milliseconds: 750),
                    curve: Curves.easeInOutCubic);
              },
              markerId: MarkerId(element.id),
              position: LatLng(
                element.lat,
                element.lan,
              ),
              draggable: true,
              infoWindow: InfoWindow(title: element.name),
            ),
          );
        },
      );
    }
    return markerList;
  }

  Future<void> _goToTheLake(GoogleMapDataEntity entity) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(entity.lat, entity.lan),
          zoom: 9.49,
        ),
      ),
    );
  }

  buildListOfCards({GoogleMapState state, double width, double height}) {
    if (state is GoogleMapDoneState) {
      return ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: EdgeMargin.subSubMin),
        itemBuilder: (context, index) {
          GoogleMapDataEntity entity = state?.list?.elementAt(index);
          return CardListItemWidget(
            onTap: () {
              _goToTheLake(entity);
            },
            entity: entity,
          );
        },
        itemCount: state?.list?.length,
      );
    }
    return CardListShimmerWidget();
  }
}
