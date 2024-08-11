import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02/models/ride.dart';

class RideDetails extends StatefulWidget {
  const RideDetails({super.key, required this.ride});
  final Ride ride;

  @override
  State<RideDetails> createState() => _RideDetailsState();
}

class _RideDetailsState extends State<RideDetails> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
         
      ),
      body: Center(
        child: Column(
          children: [
            Text('Ride Details',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
            SizedBox(height: 40,),
            Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Origin',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Text('Destination',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Text('Fare',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Text('Date Time',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                       
                      ],
                    ),
                  ),
                  Padding(
                   padding: const EdgeInsets.only(left: 10.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(': ${widget.ride.origin}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                           Text(': ${widget.ride.destination}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            Text(': RM${widget.ride.fare}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                             Text(': ${widget.ride.date.toString().replaceRange(16, null, '')}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              
                          
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 150,),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('Return'))
          ],
        
        ),
      ),
    );
  }
}