// ignore_for_file: use_build_context_synchronously

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rental_porch_app/presentation/home_rentador.dart';
import 'package:rental_porch_app/services/firebase_service.dart';
import 'package:rental_porch_app/utils/main_interface.dart';

import '../classes/user.dart';

class AgregarPorcheScreen extends StatefulWidget {
  const AgregarPorcheScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AgregarPorcheScreenState createState() => _AgregarPorcheScreenState();
}

class _AgregarPorcheScreenState extends State<AgregarPorcheScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPosition = LatLng(User.currentPosition.latitude, User.currentPosition.longitude);
  }
  final _formKey = GlobalKey<FormState>();
  // final _initialCameraPosition = const CameraPosition(target: LatLng(0, 0),);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late GoogleMapController _controller;
  late LatLng _currentPosition;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Agregar Porche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, 
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre del Porche'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un nombre irrepetible';
                  }
                  return null;
                },
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción del Porche',
                ),
                maxLines: 3,
                
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Precio por Día (\$)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || !isNumber(value)) {
                    return 'Por favor, introduce un precio correcto';
                  }
                  return null;
                },
                
              ),
              TextFormField(
                controller: _areaController,
                decoration: const InputDecoration(labelText: 'Área (m²)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || !isNumber(value)) {
                    return 'Por favor, introduce una área correcta';
                  }
                  return null;
                },
              ),              
              const SizedBox(height: 10.0),
              SizedBox(
                height: 290,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                  target: LatLng(User.currentPosition.latitude, User.currentPosition.longitude),
                  zoom: 15,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
                onLongPress: (LatLng latLng) {
                  setState(() {
                    _currentPosition = latLng;
                  });
                  _controller.animateCamera(CameraUpdate.newLatLng(_currentPosition));
                },
                markers: {
                  Marker(
                    markerId: const MarkerId("currentLocation"),
                    position: _currentPosition,
                    infoWindow: InfoWindow(
                      title: "Ubicación Actual",
                      snippet: "Lat: ${_currentPosition.latitude}, Lng: ${_currentPosition.longitude}",
                    ),
                    icon: BitmapDescriptor.defaultMarker,
                    draggable: true,
                    onDragEnd: (LatLng newPosition) {
                      setState(() {
                        _currentPosition = newPosition;
                      });
                    },
                  ),
                },
              ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
                ),
                onPressed: () async{
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const HomeRentador()
                  ));  
                },
                child: const Text('Cancelar',style: TextStyle(color: Colors.black),),
              ),
                ElevatedButton(
                onPressed: () async{
                  bool isNameUnrepeatable = await isPorchNameUnrepeatable(_nameController.text);
                  if(_formKey.currentState!.validate() && isNameUnrepeatable) {
                    await addPorch(_nameController.text, _descriptionController.text, double.parse(_priceController.text), double.parse(_areaController.text), GeoPoint(_currentPosition.latitude, _currentPosition.longitude));
                    
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeRentador()));  
                    showMessage(context, "Patio agregado", const Color.fromARGB(210, 0, 255, 8));
                  }
                  else{
                    if(!isNameUnrepeatable){
                      showMessage(context, "Ya hay un patio con ese nombre", const Color.fromARGB(184, 255, 0, 0));
                    }else{
                      showMessage(context, "LLene todos los datos", const Color.fromARGB(184, 255, 0, 0));
                    }
                    
                  }
                },
                child: const Text('Agregar Porche'),
              ),
                
              
              ],)
              
            ],
          ),
        ),
      ),
    );
  }
}

