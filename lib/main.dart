import 'package:finanzas/configurations/route_generator.dart';
import 'package:finanzas/providers/auth_provider.dart';
import 'package:finanzas/providers/budgets_provider.dart';
import 'package:finanzas/providers/register_provider.dart';
import 'package:finanzas/providers/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelGroupKey: "basic_group",
      channelKey: "basic_channel",
      channelName: "bacis notifications",
      channelDescription: "test notifications channel",
    )
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: "basic_group", channelGroupName: "group_1")
  ]);

  bool isAllowedToSendNotifications =
      await AwesomeNotifications().isNotificationAllowed();

  if (!isAllowedToSendNotifications) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

    return MultiProvider(
      builder: (context, _) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1),
            devicePixelRatio: 1,
          ),
          child: Theme(
            data: ThemeData(
              brightness: Brightness.dark,
              fontFamily: 'Poppins',
            ),
            child: MaterialApp(
              navigatorObservers: [routeObserver],
              theme: ThemeData(brightness: Brightness.light),
              title: 'Flutter Demo',
              initialRoute: '/',
              onGenerateRoute: RouteGenerator.generateRoute,
              debugShowCheckedModeBanner: false,
            ),
          ),
        );
      },
      providers: [
        ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<BudgetProvider>(
          create: (_) => BudgetProvider(),
        ),
        ChangeNotifierProvider<TransactionsProvider>(
          create: (_) => TransactionsProvider(),
        )
      ],
    );
  }
}
