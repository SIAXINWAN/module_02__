import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobile_wsmb2024_02/services/firestoreService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Driver {
  final String name;
  final String icno;
  final bool gender;
  final String phone;
  final String email;
  final String address;
  String?image;
  String?password;
  String?id;

  Driver({
    this.image,this.id,this.password,
    required this.name, required this.icno, required this.gender, required this.phone, required this.email, required this.address});

    static Future<Driver?>registerDriver(Driver driver, String password,File image)async{
      // if(await FirestoreService.isDriverDuplicated(driver)){
      //   return null;
      // }

      var byte = utf8.encode(password);
      var hashedPassword = sha256.convert(byte).toString();

      driver.password = hashedPassword;

      String fileName = 'Driver/${DateTime.now().millisecondsSinceEpoch}.jpg';
      UploadTask uploadTask = FirebaseStorage.instance.ref(fileName).putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      driver.image = downloadURL;

      var newDriver = await FirestoreService.addDriver(driver);
      if(newDriver == null){
        return null;
      }

      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('token', driver.id.toString());
      return newDriver;
    }

  static Future<Driver?> getDriverbyToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    if (token == null) {
      return null;
    }

    var driver = await FirestoreService.getDriver(token);
    return driver;
  }

    static Future<Driver?>loginDriver(String ic, String password)async{
       var byte = utf8.encode(password);
      var hashedPassword = sha256.convert(byte).toString();

      var newDriver = await FirestoreService.loginDriver(ic, hashedPassword);
      if(newDriver == null){
        return null;
      }
SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('token', newDriver.id.toString());
      return newDriver;

    }

    static Future<String>getToken()async{
       SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    if (token == null) {
      return '';
    }
    return token;
  }

    static Future<bool>signOut()async{
      SharedPreferences pref = await SharedPreferences.getInstance();
    var logout = pref.remove('token');
    return logout;
    }

    static Future<String>saveImage(File image)async{

      String fileName = 'Driver/${DateTime.now().millisecondsSinceEpoch}.jpg';
      UploadTask uploadTask = FirebaseStorage.instance.ref(fileName).putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    }

    factory Driver.fromJson(Map<String,dynamic>json, [String?id]){
      return Driver(
        name: json['name']??'',
         icno: json['icno']??'', 
         gender: json['gender']as bool, 
         phone: json['phone']??'', 
         email: json['email']??'',
          address: json['address']??'',
        image: json['image'],
        id:id);
    }

    toJson(){
      return{
        'name':name,
        'id':id,
        'gender':gender,
        'image':image,
        'password':password,
        'icno':icno,
        'address':address,
        'phone':phone,
        'email':email
      };
    }

    toSome(){
      return{
        'name':name,
        'gender':gender,
        'image':image,
        'password':password,
        'icno':icno,
        'address':address,
        'phone':phone,
        'email':email
      };
    }
}