import 'package:flutter/material.dart';

class MyNavObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute?.settings.name == '/home') {
      
      
    }
    super.didPush(route, previousRoute);
    print("New route pushed: ${route.settings.name}");
  }
}
