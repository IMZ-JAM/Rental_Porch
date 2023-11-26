import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:rental_porch_app/services/firebase_service.dart';

import '../presentation/home_rentador.dart';

//Mensaje que dura unos segundos
void showMessage(BuildContext context, String label, Color colorBackGround) {
  showToast(
    label,
    context: context,
    position: StyledToastPosition.top,
    duration: const Duration(seconds: 4),
    curve: Curves.easeIn,
    reverseCurve: Curves.easeOut,
    backgroundColor: colorBackGround,
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 0, 0,0)
    ),
    animation: StyledToastAnimation.fade,
    reverseAnimation: StyledToastAnimation.fade,
    animDuration: const Duration(seconds: 1),
    
    );
}

//Para ver si es un numero de telefono
bool isPhoneNumber(String phoneNumber) {
  return RegExp(r'^[0-9]+$').hasMatch(phoneNumber) && phoneNumber.length==10;
}

//Para ver si en algun textfield no hay nada o hay puros espacios vacios
bool isStringNotEmpty(String text) {
  // ignore: unnecessary_null_comparison
  if(text == null) {
    return false;
  }
  return text.trim().isNotEmpty;
}

//Cuadro de dialogo para informacion de cada patio de los rentadores
void showPorchInfoDialog(BuildContext context, String description, double area, double price, String title, String id, LatLng porchPosition){
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
              const Text("Area"),
              Text(
                "${area}m²",
                textAlign: TextAlign.left,
              ),
            ],
          ),
          const SizedBox(height: 12,),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
              const Text("Precio por día"),
              Text(
                "\$$price",
                textAlign: TextAlign.left,
              ),
            ],
          ),
          const SizedBox(height: 50,),
          //Punto del porche en el mapa
          SizedBox(
            width: 400,
            height: 350,
            child: 
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(porchPosition.latitude, porchPosition.longitude),
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("currentLocation"),
                  position: porchPosition,
                  infoWindow: InfoWindow(
                    title: "Ubicación Actual",
                    snippet: "Lat: ${porchPosition.latitude}, Lng: ${porchPosition.longitude}",
                  ),
                  icon: BitmapDescriptor.defaultMarker, // Puedes cambiar el icono aquí
                ),
              },
            ),

            
          ),
          
        ],
      ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cerrar",
                  style: TextStyle(color: Colors.black),
                  ),  
              ),
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
                ),
                onPressed: (){
                  showEditPorchDialog(context,id, porchPosition);
                }, 
                child: const Text(
                  "Editar",
                  style: TextStyle(color: Colors.black),
                  )
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
                ),
                onPressed: (){
                  showDeletePorchDialog(context, title, id);
                }, 
                child: const Text(
                  "Eliminar",
                  style: TextStyle(color: Colors.black),
                  )
              )
          ],)
          
        ],
      );
    },
  );
}

//Cuadro de dialogo para eliminar el patio
void showDeletePorchDialog(BuildContext context, String name, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('¿Estás seguro de eliminar este porche?',),
        content: 
          Text(
            name,
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.black),
                )
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red
              ),
              onPressed: () async{
                await deletePorch(id);
                // ignore: use_build_context_synchronously
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeRentador()));  
              },
              child: const Text(
                "Eliminar",
                style: TextStyle(color: Colors.black),
                ),
            )
          ],)
        ],
      );
    },
  );
}

//Cuadro de dialogo para editar el patio seleccionado
// ignore: must_be_immutable
class EditPorchDialog extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _EditPorchDialogState createState() => _EditPorchDialogState();
  EditPorchDialog({super.key, required this.id, required this.location});
  String id;
  LatLng location;
}

class _EditPorchDialogState extends State<EditPorchDialog> {
  bool areaType = false;
  bool descriptionType = false;
  bool priceType = false;
  bool nameType = false;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  late GoogleMapController _controller;
  late LatLng _newPorchPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newPorchPosition = LatLng(widget.location.latitude, widget.location.longitude);

  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar patio'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Text("Lo que este con x no se actualizará, solo quite la equis a lo que quiera cambiar"),
             Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               IconButton(
                 onPressed: () {
                   setState(() {
                     nameType = !nameType;
                   });
                 },
                 icon: nameType ? const Icon(Icons.done) : const Icon(Icons.cancel),
               ),
               Expanded(
                child: PorchInput(inputController: nameController, label: 'Nombre', lines: 1, enable: nameType)
               )
             ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      descriptionType = !descriptionType;
                    });
                  },
                  icon: descriptionType ? const Icon(Icons.done) : const Icon(Icons.cancel),
                ),
                Expanded(
                  child: PorchInput(inputController: descriptionController, label: 'Descripción', lines: 3, enable: descriptionType)
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      areaType = !areaType;
                    });
                  },
                  icon: areaType ? const Icon(Icons.done) : const Icon(Icons.cancel),
                ),
                Expanded(
                  child: PorchInput(inputController: areaController, label: 'Área', lines: 1, enable: areaType)
                )
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      priceType = !priceType;
                    });
                  },
                  icon: priceType ? const Icon(Icons.done) : const Icon(Icons.cancel),
                ),
                Expanded(
                  child:PorchInput(inputController: priceController, label: 'Precio', lines: 1, enable: priceType)
                )
              ],
            ),
            SizedBox(height: 10,),
            Text("Cambiar ubicación del mapa"),
            SizedBox(height: 10,),
            SizedBox(
              height: 500,
              child: 
              GoogleMap(
                   initialCameraPosition: CameraPosition(
                  target: LatLng(widget.location.latitude, widget.location.longitude),
                  zoom: 15,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
                onLongPress: (LatLng latLng) {
                  setState(() {
                    _newPorchPosition = latLng;
                  });
                  _controller.animateCamera(CameraUpdate.newLatLng(_newPorchPosition));
                },
                markers: {
                  Marker(
                    markerId: const MarkerId("currentLocation"),
                    position: _newPorchPosition,
                    infoWindow: InfoWindow(
                      title: "Ubicación Actual",
                      snippet: "Lat: ${_newPorchPosition.latitude}, Lng: ${_newPorchPosition.longitude}",
                    ),
                    icon: BitmapDescriptor.defaultMarker,
                    draggable: true, // Hace que el marcador sea arrastrable
                    onDragEnd: (LatLng newPosition) {
                      setState(() {
                        // Actualiza la posición del marcador cuando el usuario finaliza el arrastre
                        _newPorchPosition = newPosition;
                      });
                    },
                  ),
                },
              ),
            )
          ],
        ),
      ),
      
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                //showMapToEdit(context, widget.location);
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.black),
                ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () async {
                if(await isPorchNameUnrepeatable(nameController.text)){
                  double newArea, newPrice;
                  if(!areaType) {
                    newArea = 0;
                  } else{
                    newArea = double.parse(areaController.text);
                  }
                  if(!priceType) {
                    newPrice = 0;
                  } else{
                    newPrice = double.parse(priceController.text);
                  }
                  await updatePorch(widget.id, nameController.text, descriptionController.text,newArea,newPrice, nameType, descriptionType, areaType, priceType, _newPorchPosition);
                  // ignore: use_build_context_synchronously
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeRentador()));
                  // ignore: use_build_context_synchronously
                  showMessage(context, "Cambios guardados", const Color.fromARGB(127, 0, 255, 8));
                }
                else{
                  // ignore: use_build_context_synchronously
                  showMessage(context, "Ya hay un patio con ese nombre", const Color.fromARGB(184, 255, 0, 0));
                }
                
              },
              child: const Text(
                "Guardar cambios",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ],
    );
  }
}
void showEditPorchDialog(BuildContext context, String id, LatLng location) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return EditPorchDialog(id:id, location: location);
    },
  );
}

// ignore: must_be_immutable
class PorchInput extends StatelessWidget {
  PorchInput({super.key,required this.inputController, required this.label, required this.lines, required this.enable});
  TextEditingController inputController;
  String label;
  int lines;
  bool enable;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        
        enabled: enable,
        maxLines: lines,
        controller: inputController,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),     
          labelStyle: const TextStyle(
            fontSize: 14, 
            color: Colors.black87,
          ),
          labelText: label,
        ),
        
      ),
    );
  }
}

