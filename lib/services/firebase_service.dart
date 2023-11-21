import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/main_interface.dart';
import '../utils/user.dart';
import '../utils/user_porches.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

//Se usa para guardar en el mapa User.info los datos del usuario y en id su id en firebase
Future<void> getCurrentUserData() async {
  QuerySnapshot usersDataQS = await database.collection("users").where("email", isEqualTo: User.info['email']).get();
  var doc = usersDataQS.docs[0];
  User.id = usersDataQS.docs.first.id;
  User.info = doc.data() as Map<String, dynamic>; 
}

//Guarda los datos de los porches del rentador actual en UserPorches.porchesInfo
Future<void> getCurrentPorchesData() async{
  UserPorches.porchesId = User.info['porches'];
  UserPorches.porchesInfo = [];
  for(var porchesId in User.info['porches']){
    DocumentReference userRef = database.collection("porches").doc(porchesId);
    DocumentSnapshot snapshot = await userRef.get();
    UserPorches.porchesInfo.add(snapshot.data() as Map<String, dynamic>);
  }
}

Future<void> addPorch(String name, description, double price, area, GeoPoint location)async{
  //GeoPoint location = GeoPoint(1, 3);  asi se declara un punto geografico
  //location será la localizacion del porche
  DocumentReference porchRef = await FirebaseFirestore.instance.collection("porches").add({
    "name": name,
    "description": description,
    "rentPricePerDay": price,
    "area": area,
    "idOwner": User.id,
    "location": location,
  });

  DocumentReference documentReference = FirebaseFirestore.instance.collection("users").doc(User.id);
  await documentReference.update({
    "porches": FieldValue.arrayUnion([porchRef.id]),
  });
  
  await getCurrentUserData();
  await getCurrentPorchesData();

}

//Eliminar el porche del id
Future<void> deletePorch(String id)async{
   await FirebaseFirestore.instance.collection('porches').doc(id).delete();
   await FirebaseFirestore.instance.collection('users').doc(User.id).update({
      'porches': FieldValue.arrayRemove([id]),
    });
   await getCurrentUserData();
   await getCurrentPorchesData();
}

//Actualizar un porche
Future<void> updatePorch(String id, newName, newDescription,double newArea, newPrice, bool nameType, descriptionType, areaType, priceType)async{
  DocumentReference porchRef = database.collection("porches").doc(id);
  Map<String, dynamic> updatedData = {};
  if(nameType){
    updatedData['name'] = newName;
  }
  if(descriptionType){
    updatedData['description'] = newDescription;
  }
  if(areaType){
    updatedData['area'] = newName;
  }
  if(priceType){
    updatedData['price'] = newPrice;
  }
  if(priceType || areaType || descriptionType || nameType){
    await porchRef.update(updatedData);
    await getCurrentPorchesData();
  }

}

//verifica que el Nombre de los porches no se repita
Future<bool> isPorchNameUnrepeatable(String name) async{
  QuerySnapshot users = await database.collection("porches").get();
  bool correctName= true;
  
  if(users.docs.isNotEmpty) {
    for(var doc in users.docs) {
      Map<String, dynamic> porchData = doc.data() as Map<String, dynamic>;
      if(porchData.containsKey("name")){
        if(porchData['name'] == name && porchData['idOwner']==User.id){
          correctName = false;
        } 
      } 
    }
  }
  else{
    correctName = false;
  }
  return correctName;
}


//Funcion para ver si los datos de login son correctos
Future<List> getUsers(String email, password) async{

  late String label;
  late bool access;
  if(email.contains("@") && email.contains(".")){
    QuerySnapshot users = await database.collection("users").get();
    if(users.docs.isNotEmpty){
      access = false;
      for(var doc in users.docs){
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
        if (userData.containsKey("email") && userData.containsKey("password")) {
          if(userData['email'] == email && userData['password'] == password){
            User.info['email'] = email;
            access = true;
            label = "";
            await getCurrentUserData();
            await getCurrentPorchesData();
            break;
          }
        } 
      }
      if(!access){
        label = "No existe ningun usuario con este correo y contraseña";
      }
    }
  }
  else{
    access = false;
    label = "Ingrese un email correcto";
  }
  
  return [access, label];
}

//Funcion para agregar un nuevo usuario, tambien verifica si los datos dados son correctos
//Regresa una lista donde [¿Datos son correctos?, texto del mensaje]
Future<List> addUsers(String name, email, password, phoneNumber) async{
  List list = [];
  if(isStringNotEmpty(name) && isStringNotEmpty(email) && isStringNotEmpty(password)){
    if(await isEmailUnrepeatable(email)){
      if(email.contains("@") && email.contains(".") && isPhoneNumber(phoneNumber)){
      await database.collection("users").add({"name":name, "email":email, "password":password, "phoneNumber": phoneNumber});
      list.add(true);
      list.add("Registro existoso");
    }else{
      list.add(false);
      if(!isPhoneNumber(phoneNumber)){
        list.add("Ingrese un numero de telefono correcto");
      }
      else{
        list.add("Ingrese un email correcto");
      }
      
    }
  }
  else{
    list.add(false);
    list.add("El email ya esta enlazado a otra cuenta");
  }
    
  }else{
    list.add(false);
    list.add("Faltan datos de rgistro");
  }
  return list;
}

Future<bool> isEmailUnrepeatable(String email) async{
  QuerySnapshot users = await database.collection("users").get();
  bool correctEmail= true;
  
  if(users.docs.isNotEmpty) {
    for(var doc in users.docs) {
      Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
      if (userData.containsKey("email")){
        if(userData['email'] == email){
          correctEmail = false;
        } 
      } 
    }
  }
  else{
    correctEmail = false;
  }
  return correctEmail;
}

Future<void> updateUser(String newName, String newEmail, String newPassword, String newPhoneNumber) async {
  DocumentReference userRef = database.collection("users").doc(User.id);
  Map<String, dynamic> updatedData = {};
  if(isStringNotEmpty(newName)){
    updatedData['name'] = newName;
  }
  if(isStringNotEmpty(newEmail)){
    updatedData['email'] = newEmail;
  }
  if(isStringNotEmpty(newPassword)){
    updatedData['password'] = newPassword;
  }  
  if(isStringNotEmpty(newPhoneNumber)){
    updatedData['phoneNumber'] = newPhoneNumber;
  }
  if(updatedData.isNotEmpty){
    await userRef.update(updatedData);
    await getCurrentUserData();
  }
}

