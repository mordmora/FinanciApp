import 'package:finanzas/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Column(children: [
            Text(loginProvider.getEmmmail),
            Text(loginProvider.getPasssword),
          ])),
    );
  }
}
