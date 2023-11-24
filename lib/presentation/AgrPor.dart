import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rental_porch_app/presentation/home_rentador.dart';
import 'package:rental_porch_app/services/firebase_service.dart';
import 'package:rental_porch_app/utils/main_interface.dart';

class AgregarPorcheScreen extends StatefulWidget {
  @override
  _AgregarPorcheScreenState createState() => _AgregarPorcheScreenState();
}

class _AgregarPorcheScreenState extends State<AgregarPorcheScreen> {
  final _formKey = GlobalKey<FormState>();
  // final _initialCameraPosition = const CameraPosition(target: LatLng(0, 0),);
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  TextEditingController _areaController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un precio';
                  }
                  return null;
                },
                
              ),
              TextFormField(
                controller: _areaController,
                decoration: const InputDecoration(labelText: 'Área (m²)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce una área';
                  }
                  return null;
                },
              ),              
              const SizedBox(height: 10.0),
              Container(
                height: 400,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(0, 0),
                    zoom: 15,
                  ),
                ), 
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                ElevatedButton(
                onPressed: () async{
                  if(_formKey.currentState!.validate() && await isPorchNameUnrepeatable(_nameController.text)) {
                    await addPorch(_nameController.text, _descriptionController.text, double.parse(_priceController.text), double.parse(_areaController.text), const GeoPoint(3, 3));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeRentador()));  
                    showMessage(context, "Patio agregado", const Color.fromARGB(127, 0, 255, 8));
                  }
                  else{
                    showMessage(context, "Ya hay un patio con ese nombre", const Color.fromARGB(184, 255, 0, 0));
                  }
                },
                child: const Text('Agregar Porche'),
              ),
                ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
                ),
                onPressed: () async{
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const HomeRentador()
                  ));  
                },
                child: const Text('Cancelar'),
              ),
              
              ],)
              
            ],
          ),
        ),
      ),
    );
  }
}

