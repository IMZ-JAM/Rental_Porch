import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rental_porch_app/presentation/map/request_permission/request_permission_controller.dart';
import 'package:rental_porch_app/presentation/map/routes/routes.dart';

class RequestPermissionPage extends StatefulWidget {
  const RequestPermissionPage({super.key});

  @override
  State<RequestPermissionPage> createState() => _Rrequest_permissionState();
}

class _Rrequest_permissionState extends State<RequestPermissionPage> {

  final _controller = RequestPermissionController(Permission.locationWhenInUse);
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _controller.onStatusChanged.listen((status) { 
      if (status == PermissionStatus.granted) {
        Navigator.pushReplacementNamed(context, Routes.MAP);
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: ElevatedButton(
            child: Text('Allow'), 
            onPressed: () {
              _controller.request();
            },
          ),
        )
      ),
    );
  }
}