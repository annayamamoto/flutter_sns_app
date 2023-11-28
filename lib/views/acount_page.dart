import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_app/models/main_model.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key, required this.mainModel});

  final MainModel mainModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('アカウント'), backgroundColor: Colors.deepPurpleAccent),
      body: ListView(
        children: [
          ListTile(
            title: Text('ロウグアウト'),
            onTap: () async => mainModel.logout(context: context, ref: ref),
          )
        ],
      ),
    );
  }
}
