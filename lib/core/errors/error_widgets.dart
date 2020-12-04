
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upcload_technology/core/localization/translations.dart';
import 'package:upcload_technology/core/resources/global_color.dart';
import 'package:upcload_technology/core/resources/text_style.dart';

class ConnectionErrorWidget extends StatelessWidget {
  final VoidCallback callback;

  const ConnectionErrorWidget({
    Key key,
    @required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            Translations.of(context).translate('err_connection'),
            style: textStyle.smallTSBasic.copyWith(color: globalColor.accentColor),
          ),
          RaisedButton(
            onPressed: callback,
            child: Text(
              Translations.of(context).translate('retry'),
              style: textStyle.smallTSBasic
                  .copyWith(color: globalColor.globalWhite),
            ),
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}

class UnexpectedErrorWidget extends StatelessWidget {
  final VoidCallback callback;

  const UnexpectedErrorWidget({
    Key key,
    @required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            Translations.of(context).translate('err_unexpected'),
            style:
                textStyle.smallTSBasic.copyWith(color: globalColor.accentColor),
          ),
          RaisedButton(
            onPressed: callback,
            child: Text(
              Translations.of(context).translate('retry'),
              style: textStyle.smallTSBasic
                  .copyWith(color: globalColor.globalWhite),
            ),
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}

class InternalServerErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Translations.of(context).translate('err_server'),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ForbiddenErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Translations.of(context).translate('err_forbidden'),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class BadRequestErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Translations.of(context).translate('err_bad_request'),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class NotFoundErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Translations.of(context).translate('err_not_found'),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class UnauthorizedErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Translations.of(context).translate('err_unauthorized'),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CustomErrorWidget extends StatelessWidget {
  final String message;

  const CustomErrorWidget({
    Key key,
    @required this.message,
  })  : assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

abstract class ErrorViewer {
  static void showConnectionError(BuildContext context, VoidCallback callback,
      {ScaffoldState scaffoldState}) {
    final snackbar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            Translations.of(context).translate('err_connection'),
            style:
                textStyle.smallTSBasic.copyWith(color: globalColor.globalWhite),
          ),
          FlatButton(
            onPressed: () {
              print("callback ");
              if (callback != null) callback();
            },
            child: Text(
              Translations.of(context).translate('retry'),
              style: textStyle.smallTSBasic
                  .copyWith(color: globalColor.globalWhite),
            ),
            textColor: globalColor.globalWhite,
          )
        ],
      ),
      duration: Duration(seconds: 3),
    );
    if (scaffoldState != null)
    {
      scaffoldState.hideCurrentSnackBar();
      scaffoldState.showSnackBar(snackbar);
    }    else
      Scaffold.of(context).showSnackBar(snackbar);
  }

  static void showCustomErrorWithButtonCallBack(
      BuildContext context, String msg, VoidCallback callback,
      {ScaffoldState scaffoldState}) {
    final snackbar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            msg,
            style:
                textStyle.smallTSBasic.copyWith(color: globalColor.globalWhite),
          ),
          FlatButton(
            onPressed: () {
              print("callback ");
              callback();
            },
            child: Text(
              Translations.of(context).translate('retry'),
              style: textStyle.smallTSBasic
                  .copyWith(color: globalColor.globalWhite),
            ),
            textColor: globalColor.globalWhite,
          )
        ],
      ),
      duration: Duration(seconds: 3),
    );
    if (scaffoldState != null)
    {
      scaffoldState.hideCurrentSnackBar();
      scaffoldState.showSnackBar(snackbar);
    }    else
      Scaffold.of(context).showSnackBar(snackbar);
  }

  static void showCustomError(BuildContext context, String message,
      {ScaffoldState scaffoldState}) {
    final snackbar = SnackBar(
      duration: Duration(seconds: 2),
      content: Text(
        message,
        style: textStyle.smallTSBasic.copyWith(color: globalColor.globalWhite),
      ),
    );
    if (scaffoldState != null) {
      scaffoldState.hideCurrentSnackBar();
      scaffoldState.showSnackBar(snackbar);
    } else
      Scaffold.of(context).showSnackBar(snackbar);
  }

  static void showUnexpectedError(BuildContext context,
      {ScaffoldState scaffoldState}) {
    final snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      content: Text(
        Translations.of(context).translate('err_unexpected'),
        style: textStyle.smallTSBasic.copyWith(color: globalColor.globalWhite),
      ),
    );
    if (scaffoldState != null)
    {
      scaffoldState.hideCurrentSnackBar();
      scaffoldState.showSnackBar(snackbar);
    }    else
      Scaffold.of(context).showSnackBar(snackbar);
  }
}
