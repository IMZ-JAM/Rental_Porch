import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rental_porch_app/presentation/map/map_controller.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapController>(
      create: (_) {
        final controller = MapController();
        controller.onMarkerTap.listen((String id) {
          print('got to $id');
        });
        return controller;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<MapController>(
          builder: (_, controller, __) => GoogleMap(
            onMapCreated: controller.onMapCreated,
            initialCameraPosition: controller.initialCameraPosition,
            myLocationButtonEnabled: false,
            markers: controller.markers,
            onTap: controller.onTap,
          ), 
        ),
      ),
    );
  }
}