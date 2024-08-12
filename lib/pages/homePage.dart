import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02/models/driver.dart';
import 'package:mobile_wsmb2024_02/models/ride.dart';
import 'package:mobile_wsmb2024_02/models/vehicle.dart';
import 'package:mobile_wsmb2024_02/pages/profile/profilePage.dart';
import 'package:mobile_wsmb2024_02/pages/ride/rideList.dart';
import 'package:mobile_wsmb2024_02/pages/startPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.driver, required this.rideList, required this.vehicle, });
  final Driver driver;
  final List<Ride>rideList;
  final Vehicle vehicle;
 

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
late List<Widget>tabs = [];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabs= [
      
      RideListTab(rideList: widget.rideList,),
      ProfilePageTab(driver:widget.driver,vehicle:widget.vehicle)

    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
           backgroundColor: Colors.greenAccent,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('KONGSI KERETA'),
              GestureDetector(
                onTap: ()async{
                  await showDialog(context: context, builder: (context)=>AlertDialog(
                    title: Center(child: Text('Log Out?')),
                    content: Text('Do you want to log out?'),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: Text('No')),
                      TextButton(onPressed: ()async{
                        await Driver.signOut();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StartPage()));
                      }, child: Text('Yes')),
                    ],
                  ));
                },
                child: CircleAvatar(backgroundImage: NetworkImage(widget.driver.image!),))
            ],
          ),
        ),
        body: IndexedStack(
          children: tabs,
          index: currentIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.car_rental), label: 'Ride'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.edit), label: 'Edit Profile'),
            ]),
      ),
    );
  }
}
