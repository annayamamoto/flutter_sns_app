import 'package:flutter/material.dart';
import 'package:flutter_sns_app/constants/routes.dart' as routes;
import 'package:flutter_sns_app/models/main_model.dart';

class SNSDrawer extends StatelessWidget {
  const SNSDrawer({super.key, required this.mainModel});

  final MainModel mainModel;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('アカウント'),
            onTap: () =>
                routes.toAccountPage(context: context, mainModel: mainModel),
          )
        ],
      ),
    );
  }
}
