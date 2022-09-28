import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Future<bool> requestPermission(Permission setting) async {
    // setting.request() will return the status ALWAYS
    // if setting is already requested, it will return the status
    final _result = await setting.request();
    switch (_result) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        return false;
    }
  }
@override
  void initState() {
    // TODO: implement initState
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("24db7545-e277-4a02-b7ea-434f620618a9");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Notification Permissions'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                child: Text("Ask for notification status".toUpperCase()),
                onPressed: () async {

                  // show the dialog/open settings screen
                  await OneSignal.shared
                      .promptUserForPushNotificationPermission();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
