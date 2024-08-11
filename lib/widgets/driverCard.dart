import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02/models/driver.dart';
import 'package:mobile_wsmb2024_02/pages/profile/editDriver.dart';

class DriverCard extends StatefulWidget {
  const DriverCard({super.key, required this.driver});
  final Driver driver;

  @override
  State<DriverCard> createState() => _DriverCardState();
}

class _DriverCardState extends State<DriverCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height*0.35,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
      ),
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(child: Text('Driver',style: TextStyle(fontSize: 16),)),
            Row(
              children: [
                
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Text('IC',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Text('Gender',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Text('Phone',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Text('Email',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Text('Address',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ],
                ),
                Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(': ${widget.driver.name}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                 Text(': ${widget.driver.icno}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Text(': ${widget.driver.gender?'male':'female'}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                   Text(': ${widget.driver.phone}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Text(': ${widget.driver.email}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                     Text(': ${widget.driver.address}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                
              ],
            ),
              ],
            ),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditDriver(driver: widget.driver,)));
            }, child: Icon(Icons.edit))
          ],
        ),
      )
    );
  }
}