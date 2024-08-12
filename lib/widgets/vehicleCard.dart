import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02/models/vehicle.dart';
import 'package:mobile_wsmb2024_02/pages/profile/editVehicle.dart';

class VehicleCard extends StatefulWidget {
  const VehicleCard({super.key,  required this.vehicle});
  final Vehicle vehicle;

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height*0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
      ),
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(child: Text('Vehicle',style: TextStyle(fontSize: 25),)),
            Row(
              children: [
                
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Car Model',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Text('Sitting Capacity',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Text('Special Features',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    
                  ],
                ),
                Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(': ${widget.vehicle.car_model}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                 Text(': ${widget.vehicle.capacity}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Text(': ${widget.vehicle.special_features}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                   
              ],
            ),
              ],
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditVehicle(vehicle: widget.vehicle,)));
            }, child: Icon(Icons.edit))
          ],
        ),
      )
    );
  }
}