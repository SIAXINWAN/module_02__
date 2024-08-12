import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02/models/driver.dart';
import 'package:mobile_wsmb2024_02/models/ride.dart';
import 'package:mobile_wsmb2024_02/models/vehicle.dart';
import 'package:mobile_wsmb2024_02/services/firestoreService.dart';
import 'package:mobile_wsmb2024_02/widgets/driverCard.dart';
import 'package:mobile_wsmb2024_02/widgets/rideCard.dart';
import 'package:mobile_wsmb2024_02/widgets/vehicleCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePageTab extends StatelessWidget {
  const ProfilePageTab(
      {super.key, required this.driver, required this.vehicle});
  final Driver driver;
  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => ProfilePage(
                  driver: driver,
                  vehicle: vehicle,
                ));
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.driver, required this.vehicle});
  final Driver driver;
  final Vehicle vehicle;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DriverCard(driver: widget.driver),
            SizedBox(
              height: 10,
            ),
            VehicleCard(vehicle: widget.vehicle)
          ],
        ),
      ),
    );
  }
}
