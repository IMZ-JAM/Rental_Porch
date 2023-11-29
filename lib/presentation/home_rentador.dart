// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rental_porch_app/presentation/AgrPor.dart';
import 'package:rental_porch_app/presentation/dosopciones.dart';
import 'package:rental_porch_app/presentation/login_screen.dart';
import 'package:rental_porch_app/presentation/reservations_screen.dart';
import 'package:rental_porch_app/presentation/user_page.dart';
import '../utils/main_interface.dart';
import '../classes/user_porches.dart';
import '../classes/user.dart';
import '../services/firebase_service.dart';


class HomeRentador extends StatefulWidget {
  const HomeRentador({super.key});
  @override
  HomeRentadorState createState() => HomeRentadorState();
  
}

class HomeRentadorState extends State<HomeRentador>{
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
              const Text("Menú",
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
        title: const Text('Bienvenido a Rental-Porch'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: UserPorches.porchesId.length, 
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                title: Text('${UserPorches.porchesInfo[index]["name"]}'),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text('Precio por día'), Text('\$${UserPorches.porchesInfo[index]['rentPricePerDay']}')]
                ),
                onTap: ()async{
                  showPorchInfoDialog(context, UserPorches.porchesInfo[index]['description'],UserPorches.porchesInfo[index]['area'].toDouble(), UserPorches.porchesInfo[index]['rentPricePerDay'].toDouble(), UserPorches.porchesInfo[index]['name'], UserPorches.porchesId[index], LatLng(UserPorches.porchesInfo[index]['location'].latitude, UserPorches.porchesInfo[index]['location'].longitude));
                },
              ),
            );
          },
        ),
      ),
    );
  }
    
}


