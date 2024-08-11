import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02/models/driver.dart';
import 'package:mobile_wsmb2024_02/models/ride.dart';
import 'package:mobile_wsmb2024_02/models/vehicle.dart';
import 'package:mobile_wsmb2024_02/pages/ride/addride.dart';
import 'package:mobile_wsmb2024_02/services/firestoreService.dart';
import 'package:mobile_wsmb2024_02/widgets/rideCard.dart';


class RideListTab extends StatelessWidget {
  const RideListTab({super.key, required this.rideList});
  final List<Ride> rideList;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context)=>RideList(rideList: rideList,));
      },
    );
  }
}

class RideList extends StatefulWidget {
  const RideList({super.key, required this.rideList});
  final List<Ride>rideList;

  @override
  State<RideList> createState() => _RideListState();
}

class _RideListState extends State<RideList> {
  
String keyword = '';
final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var filterList = widget.rideList
        .where((e) =>
            e.origin.toLowerCase().contains(keyword.toLowerCase()) ||
            e.destination.toLowerCase().contains(keyword.toLowerCase())||e.fare.toString().toLowerCase().contains(keyword.toLowerCase())||e.date.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
    

    

    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex:3,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      
                      label: Text('Search'),
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: searchController.text.isNotEmpty?IconButton(onPressed: (){
                        searchController.clear();
                      }, icon: Icon(Icons.clear)):null
                    ),
                    onChanged: (value){
                     setState(() {
                        keyword = value.trim();
                     });
                    },
                  )),
                Expanded(
                  flex:2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                    onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddRide()));
                  }, child: Icon(Icons.add_outlined),),
                )
              ],
            ),
            SizedBox(height: 40,),
            Expanded(child: ListView.builder(
              itemCount: filterList.length,
              itemBuilder: (context,index){
                return RideCard(ride: filterList[index]);
              }))
          ],
        ),
      )
    );
  }
}