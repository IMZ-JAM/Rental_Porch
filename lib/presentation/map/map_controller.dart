import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rental_porch_app/utils/map_style.dart';

class MapController extends ChangeNotifier{

  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();

  final _markersController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markersController.stream;

  final initialCameraPosition = const CameraPosition(
    target: LatLng(25.763806395079992, -100.17077505359467),
    zoom: 15,
  );

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  }

  void onTap(LatLng position) {

    final id = _markers.length.toString();
    final markerId = MarkerId(id);
    final marker = Marker(
      markerId: markerId,
      position: position,
      draggable: true,
      icon: BitmapDescriptor.defaultMarkerWithHue(200),
      onTap: () {
        _markersController.sink.add(id);
        print(id);
      },
      onDragEnd: (newPosition) {
        print('new position $newPosition');
      }

    );
    _markers[markerId] = marker;
    notifyListeners();

  }

  @override
  void dispose() {
    _markersController.close();
    super.dispose();
  }

}