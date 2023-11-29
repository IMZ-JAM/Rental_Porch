// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rental_porch_app/presentation/login_screen.dart';
import 'package:rental_porch_app/presentation/user_page.dart';
import 'package:rental_porch_app/services/email_service.dart';
import 'package:rental_porch_app/classes/user_porches.dart';
import '../services/firebase_service.dart';
import '../utils/main_interface.dart';
import '../classes/reservations.dart';
import '../classes/user.dart';
import 'AgrPor.dart';
import 'dosopciones.dart';


class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});
  @override
  ReservationsScreenState createState() => ReservationsScreenState();
  
}

class ReservationsScreenState extends State<ReservationsScreen>{
  void updateScreen(){
    setState((){});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 188, 220, 246),
          child: Column(
            children: [
              const SizedBox(
                height: 37,
              ),
              Container(
                width: 110,
                height: 110,
                margin: const EdgeInsets.all(25),
                child: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/7429/7429878.png"),
              ),
              const Text("Menu",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              InkWell(
                onTap: ()async{ 
                   User.currentPosition = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high,
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AgregarPorcheScreen()));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 3),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ), 
                  child: const Text("Agregar Patio"),

                ),
              ),
              const SizedBox(height: 3,),
              InkWell(
                onTap: ()async{ 
                  await getCurrentReservationsData();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ReservationsScreen()));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 3),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ),
                  child: const Text("Lista de Reservas"),
                ),
              ),
              Expanded(child: Container()),              
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 125, 115, 115),
                  ),
                  Text(" Configuración",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                ],
              ),
              InkWell( 
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPage()));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 3),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ),
                  child: const Text("Perfil"),
                ),
              ),
              const SizedBox(height: 3),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TipoUsuarioScreen()));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 3),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ),
                  child: const Text("Elegir Tipo de Usuario"),
                ),
              ),
              const SizedBox(height: 60,),
              InkWell(
                onTap: () { 
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 2, top: 2),
                  width: double.infinity,
                  color: const Color.fromARGB(221, 67, 79, 77),
                  alignment: Alignment.center,
                  child: const Text("Cerrar Sesión",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Lista de reservaciones'),
      ),
      body: 
      Column(children: [
      const Text("Reservas por confirmar"),
       Expanded(
          child: ListView.builder(
            itemCount: Reservations.info.where((reservation) => !reservation['accepted']).length,
            itemBuilder: (context, index) {
              List<Map<String, dynamic>> filteredReservations =
                  Reservations.info.where((reservation) => !reservation['accepted']).toList();
              List<String> notAcceptedId = [];
              for(int i=0;i<Reservations.id.length;i++){
                if(!Reservations.info[i]['accepted']){
                  notAcceptedId.add(Reservations.id[i]);
                }
              }
              return Card(
                child: ListTile(
                  title: Text('Reserva a nombre de ${filteredReservations[index]['clientName']}'),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [const Text('Fecha'), Text((filteredReservations[index]['date'].toDate()).toString().substring(0,10))]
                  ),
                  onTap: () async {
                    await showReservationInfo(context, filteredReservations[index], notAcceptedId[index]);
                  },
                ),
              );
            },
          ),
        ),

        const Text("Reservas confimadas"),
        Expanded(
          child: ListView.builder(
            itemCount: Reservations.info.where((reservation) => reservation['accepted']).length,
            itemBuilder: (context, index) {
              // Filtra solo las reservas donde 'accepted' es false
              List<Map<String, dynamic>> filteredReservations =
                  Reservations.info.where((reservation) => reservation['accepted']).toList();
              List<String> acceptedId = [];
              for(int i=0;i<Reservations.id.length;i++){
                if(Reservations.info[i]['accepted']){
                  acceptedId.add(Reservations.id[i]);
                }
              }
              return Card(
                child: ListTile(
                  title: Text('Reserva a nombre de ${filteredReservations[index]['clientName']}'),
                   subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [const Text('Fecha'), Text((filteredReservations[index]['date'].toDate()).toString().substring(0,10))]
                  ),
                  onTap: () async {
                    await showReservationInfo(context, filteredReservations[index], acceptedId[index]);
                  },
                ),
              );
            },
          ),
        ),
      ],)
      
    );
  }
Future<void> showReservationInfo(BuildContext context,Map<String, dynamic> info, String id) async {
  Map<String, dynamic> clientInfo =await getSpecificDataUser(info['clientId']);
  int porchIndex = UserPorches.porchesId.indexOf(info['porcheId']);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Informacion de reservación'),
        content: 
        SizedBox(
          height: 400,
          child: Column(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children:[ const Text("Fecha de reservación: "), Text((info['date'].toDate()).toString().substring(0,10))]),
            Column(children:[ const Text("Nombre del cliente: "), Text(info['clientName'])]),
            Column(children:[ const Text("Telefono del cliente "), Text(clientInfo['phoneNumber'])]),
            Column(children:[ const Text("Email del cliente: "), Text(clientInfo['email'])]),
            Column(children:[ const Text("Nombre del porche: "), Text(UserPorches.porchesInfo[porchIndex]['name'])]),
            Column(children:[ const Text("Área: "), Text('${(UserPorches.porchesInfo[porchIndex]['area'].toString())}m²')]),
            Column(children:[ const Text("Precio: "), Text('\$${UserPorches.porchesInfo[porchIndex]['rentPricePerDay'].toString()}')]),
          ],
        ),),
        
        actions: <Widget>[
          info['accepted'] ?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            IconButton(
              onPressed: ()async{
                await deleteReservation(id);  
                updateScreen();
                String message = 'Su reservación ha sido cancelada por el rentador o ya ocurrió\nFecha de reservación: ${(info['date'].toDate()).toString().substring(0,10)}\nNombre del porche: ${UserPorches.porchesInfo[porchIndex]['name']}\nNombre del rentador: ${User.info['name']}';
                await sendEmailToAcceptOrDicline(name: clientInfo['name'], toEmail: clientInfo['email'], replyToEmail: User.info['email'], message: message, rentadorName: User.info['name']);
                Navigator.of(context).pop();
                showMessage(context, 'Reservacion cancelada', const Color.fromARGB(210, 255, 0, 0));
              },
              icon: const Icon(Icons.delete)
            ),
            ElevatedButton(
              onPressed: ()async{                
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cerrar",
                style: TextStyle(color: Colors.black),
                ),  
            )
          ],)
          :
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
              onPressed: ()async{
                await acceptReservation(id);  
                updateScreen();
                String message = 'Su reservación ha sido aceptada\nFecha de reservación: ${(info['date'].toDate()).toString().substring(0,10)}\nNombre del porche: ${UserPorches.porchesInfo[porchIndex]['name']}\nNombre del rentador: ${User.info['name']}';
                await sendEmailToAcceptOrDicline(name: clientInfo['name'], toEmail: clientInfo['email'], replyToEmail: User.info['email'], message: message, rentadorName: User.info['name']);
                Navigator.of(context).pop();
                showMessage(context, 'Reservacion aceptada', const Color.fromARGB(210, 0, 255, 8));
              },
              icon: const Icon(Icons.done),
            ),  
            IconButton(
              onPressed: ()async{
                await declineReservation(id);  
                updateScreen();
                String message = 'Su reservación ha sido rechazada\nFecha de reservación: ${(info['date'].toDate()).toString().substring(0,10)}\nNombre del porche: ${UserPorches.porchesInfo[porchIndex]['name']}\nNombre del rentador: ${User.info['name']}';
                await sendEmailToAcceptOrDicline(name: clientInfo['name'], toEmail: clientInfo['email'], replyToEmail: User.info['email'], message: message, rentadorName: User.info['name']);
                Navigator.of(context).pop();
                showMessage(context, 'Reservacion rechazada', const Color.fromARGB(210, 255, 0, 0));
              },
              icon: const Icon(Icons.cancel)
            ),  
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cerrar",
                style: TextStyle(color: Colors.black),
                ),  
            )
          ],)
        ],
      );
    },
  );
  }

}