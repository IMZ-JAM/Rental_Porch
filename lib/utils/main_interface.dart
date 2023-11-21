
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
void showPorchInfoDialog(BuildContext context, String description, double area, double price, String title, String id) {
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
          const SizedBox(height: 12,),
          //Punto del porche en el mapa
          const Image(
            image: AssetImage('assets/images/map_point.png'),
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
                child: const Text("Cerrar"),
              ),
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
                ),
                onPressed: (){
                  showEditPorchDialog(context,id);
                }, 
                child: const Text("Editar")
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
                ),
                onPressed: (){
                  showDeletePorchDialog(context, title, id);
                }, 
                child: const Text("Eliminar")
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
              child: const Text("Cancelar")
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
              child: const Text("Eliminar"),
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
  EditPorchDialog({super.key, required this.id});
  String id;
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar patio'),
      content: SizedBox(
        height: 340,
        child: Column(
          children: [
            const Text("Lo que este con equis no se actualizará, solo quite la equis a lo que quiera cambiar"),
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
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
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
                    newArea =double.parse(areaController.text);
                  }
                  if(!priceType) {
                    newPrice = 0;
                  } else{
                    newPrice =double.parse(priceController.text);
                  }
                  await updatePorch(widget.id, nameController.text, descriptionController.text,newArea,newPrice, nameType, descriptionType, areaType, priceType);
                  // ignore: use_build_context_synchronously
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeRentador()));
                  // ignore: use_build_context_synchronously
                  showMessage(context, "Cambios  guardados", const Color.fromARGB(127, 0, 255, 8));
                }
                else{
                  // ignore: use_build_context_synchronously
                  showMessage(context, "Ya hay un patio con ese nombre", const Color.fromARGB(184, 255, 0, 0));
                }
                
              },
              child: const Text("Guardar cambios"),
            )
          ],
        ),
      ],
    );
  }
}
void showEditPorchDialog(BuildContext context, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return EditPorchDialog(id:id);
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

