

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_wsmb2024_02/models/driver.dart';
import 'package:mobile_wsmb2024_02/models/ride.dart';
import 'package:mobile_wsmb2024_02/models/vehicle.dart';


class FirestoreService {
  static final firestore = FirebaseFirestore.instance;

  static Future<bool> isDriverDuplicated(Driver driver) async {
    final queries = [
      firestore
          .collection('drivers')
          .where('name', isEqualTo: driver.name)
          .get(),
      firestore
          .collection('drivers')
          .where('icno', isEqualTo: driver.icno)
          .get(),
      firestore
          .collection('drivers')
          .where('password', isEqualTo: driver.password)
          .get(),
    ];

    final querySnapshot = await Future.wait(queries);
    final exists =
        querySnapshot.any((querySnapshot) => querySnapshot.docs.isNotEmpty);
    return exists;
  }



  static Future<Driver?> addDriver(Driver driver) async {
    try {
      var collection = await firestore.collection('drivers').get();
      driver.id = 'D${collection.size + 1}';

      var doc = firestore.collection('drivers').doc(driver.id);
      doc.set(driver.toJson());

      var driverDoc =
          await firestore.collection('drivers').doc(driver.id).get();
      Map<String, dynamic> data = driverDoc.data() as Map<String, dynamic>;
      Driver newDriver = Driver.fromJson(data);
      return newDriver;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> addVehicle(Vehicle vehicle) async {
    try {
      vehicle.id =
          'V${DateTime.now().microsecondsSinceEpoch}-${vehicle.driver_id}';

      var doc = firestore.collection('vehicles').doc(vehicle.id);
      doc.set(vehicle.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addRide(Ride ride) async {
    try {
      ride.id = 'R${DateTime.now().microsecondsSinceEpoch}-${ride.driver_id}';

      var doc = firestore.collection('rides').doc(ride.id);
      doc.set(ride.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }


  static Future<Driver?> loginDriver(String ic, String password) async {
    try {
      var collection = await firestore
          .collectionGroup('drivers')
          .where('icno', isEqualTo: ic)
          .where('password', isEqualTo: password)
          .get();

      if (collection.docs.isEmpty) {
        return null;
      }

      var doc = collection.docs.first;

      var driver = Driver.fromJson(doc.data());
      driver.id = doc.id;
      return driver;
    } catch (e) {
      return null;
    }
  }


  static Future<Driver?> getDriver(String id) async {
    try {
      var doc = await firestore.collection('drivers').doc(id).get();
      if (doc.exists) {
        return Driver.fromJson(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<Vehicle?> getShortVehicle(String id) async {
    try {
      var doc = await firestore.collection('vehicles').doc(id).get();

      if (doc.exists) {
        return Vehicle.fromJson(doc.data()!, doc.id);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Vehicle>> getVehicle() async {
    try {
      var collection = await firestore.collection('vehicles').get();

      if (collection.docs.isEmpty) {
        return [];
      }

      var list =
          collection.docs.map((e) => Vehicle.fromJson(e.data(), e.id)).toList();
      return list;
    } catch (e) {
      return [];
    }
  }

  static Future<List<Ride>> getRide() async {
    try {
      var collection = await firestore.collection('rides').get();

      if (collection.docs.isEmpty) {
        return [];
      }

      var list =
          collection.docs.map((e) => Ride.fromJson(e.data(), e.id)).toList();
      return list;
    } catch (e) {
      return [];
    }
  }



  static Future<bool> updateDriver(Driver driver, String id) async {
    try {
      await firestore.collection('drivers').doc(id).update(driver.toSome());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateVehicle(Vehicle vehicle, String id) async {
    try {
      await firestore.collection('vehicle').doc(id).update(vehicle.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateRide(Ride ride, String id) async {
    try {
      await firestore.collection('rides').doc(id).update(ride.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }



  static Future<bool> deleteVehicle(String vehicle_id) async {
    try {
      await firestore.collection('vehicles').doc(vehicle_id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteRide(String ride_id) async {
    try {
      await firestore.collection('rides').doc(ride_id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }


}
