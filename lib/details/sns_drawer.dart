import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns_app/constants/routes.dart' as routes;
import 'package:flutter_sns_app/models/main_model.dart';
import 'package:flutter_sns_app/models/themes_model.dart';

class SNSDrawer extends StatelessWidget {
  const SNSDrawer(
      {super.key, required this.mainModel, required this.themesModel});

  final MainModel mainModel;
  final ThemesModel themesModel;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('アカウント'),
            onTap: () =>
                routes.toAccountPage(context: context, mainModel: mainModel),
          ),
          ListTile(
            title: Text('テーマ'),
            trailing: CupertinoSwitch(
              value: themesModel.isDarkTheme,
              onChanged: (bool value) {
                themesModel.setIsDarkTheme(value: value);
              },
            ),
          )
        ],
      ),
    );
  }
}
