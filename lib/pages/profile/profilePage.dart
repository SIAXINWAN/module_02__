import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02/models/driver.dart';
import 'package:mobile_wsmb2024_02/models/ride.dart';
import 'package:mobile_wsmb2024_02/models/vehicle.dart';
import 'package:mobile_wsmb2024_02/services/firestoreService.dart';
import 'package:mobile_wsmb2024_02/widgets/driverCard.dart';
import 'package:mobile_wsmb2024_02/widgets/rideCard.dart';
import 'package:mobile_wsmb2024_02/widgets/vehicleCard.dart';

class ProfilePageTab extends StatelessWidget {
  const ProfilePageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
       return MaterialPageRoute(builder: (context)=>ProfilePage()) ;
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});



  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

Driver? driver;
Vehicle?vehicle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDriver();
   getVehicle();
  }

  void getDriver()async{
    driver = await Driver.getDriverbyToken();
  setState(() {
    
  });
  }

   void getVehicle()async{
   vehicle = await Vehicle.getVehicleByToken();
    
  }

 
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
         children: [
          if(driver!=null)
         DriverCard(driver: driver!),
         if(vehicle!=null)
        VehicleCard(vehicle: vehicle!)
          
         ],
        ),
      ),
    );
  }
}