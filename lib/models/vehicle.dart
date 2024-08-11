import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobile_wsmb2024_02/models/driver.dart';
import 'package:mobile_wsmb2024_02/services/firestoreService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Vehicle {
  final String car_model;
  final int capacity;
  final String special_features;
  String?id;
  final String driver_id;
  String?image;

  Vehicle({
    this.id,this.image,
    required this.car_model, required this.capacity, required this.special_features, required this.driver_id});
    
    static Future<bool> register(
      String model, int capacity, String feature, File? image) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    if (token == null) {
      return false;
    }
    String imageLink = '';
    if (image != null) {
      String fileName = 'Vehicle/${DateTime.now().microsecondsSinceEpoch}.jpg';
      UploadTask uploadTask =
          FirebaseStorage.instance.ref(fileName).putFile(image);

      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      imageLink = downloadURL;
    }

    Vehicle vehicle = Vehicle(
        car_model: model,
        capacity: capacity,
        special_features: feature,
        driver_id: token,
        image: imageLink);

    var res = await FirestoreService.addVehicle(vehicle);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('vehicle_token', vehicle.id!);
    return res;
  }

  Future<Driver?> getDriver() async {
    
    var driver = await FirestoreService.getDriver(driver_id);
    return driver;
  }

   static Future<Vehicle?>getVehicleByToken()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('vehicle_token');
    if (token == null) {
      return null;
    }

    var vehicle = await FirestoreService.getShortVehicle(token);
    return vehicle;
  }


    factory Vehicle.fromJson(Map<String,dynamic>json,[String?id]){
      return Vehicle(
        id:id,
        car_model: json['car_model']??'', 
        capacity: json['capacity']??0, 
        special_features: json['special_features']??'',
        image:json['image'],
         driver_id: json['driver_id']??'');
    }

    toJson(){
      return{
        'car_model':car_model,
        'capacity':capacity,
        'special_features':special_features,
        'id':id,
        'image':image,
        'driver_id':driver_id
      };
    }
}