import 'package:flutter/material.dart';

import 'package:mobile_wsmb2024_02/models/ride.dart';
import 'package:mobile_wsmb2024_02/pages/ride/rideDetails.dart';
import 'package:mobile_wsmb2024_02/services/firestoreService.dart';

class RideCard extends StatefulWidget {
  const RideCard({super.key, required this.ride});
  final Ride ride;

  @override
  State<RideCard> createState() => _RideCardState();
}

class _RideCardState extends State<RideCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.275,
        width: MediaQuery.sizeOf(context).width * 0.5,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 227, 184, 235),
          border: Border.all(width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Origin',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Destination',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Fare',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Date Time',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ': ${widget.ride.origin}',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ': ${widget.ride.destination}',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ': RM${widget.ride.fare}',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ': ${widget.ride.date.toString().replaceRange(16, null, '')}',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
      
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                      child: MaterialButton(
                          onPressed: () async {
                            await FirestoreService.deleteRide(widget.ride.id ?? '');
                          },
                          child: Text('Cancle')),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    RideDetails(ride: widget.ride)));
                          },
                          child: Text("Details")),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
