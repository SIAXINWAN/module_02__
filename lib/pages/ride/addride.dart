import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02/models/ride.dart';
import 'package:mobile_wsmb2024_02/models/vehicle.dart';
import 'package:mobile_wsmb2024_02/services/firestoreService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRide extends StatefulWidget {
  const AddRide({super.key});

  @override
  State<AddRide> createState() => _AddRideState();
}

class _AddRideState extends State<AddRide> {
  final originController = TextEditingController();
  final destController = TextEditingController();
  final fareController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Vehicle?vehicle;

  void getVehicle()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = await pref.getString('token');
   vehicle = await FirestoreService.getVehicle(token!);
    
  }


 @override
 void initState() {
   super.initState();
   getVehicle();
 }
  DateTime? dateTime;

  void submitForm() async {
    if (dateTime == null || dateTime!.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid date time')));
      return;
    }

    if (formKey.currentState!.validate()) {
      var res = await Ride.registerRide(
          dateTime.toString(),
          int.parse(fareController.text),
          originController.text,
          destController.text,vehicle?.id??'',
          );
      if (res) {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Success'),
                  content: Text('Your ride is added successfully'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'))
                  ],
                ));
        Navigator.of(context).pop();
      } else {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Warning'),
                  content: Text('Something went wrong'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'))
                  ],
                ));
      }
    }
  }

  void takeDateTime() async {
    var tempDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 30)));
    if (tempDate == null) {
      return;
    }

    var tempTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: DateTime.now().hour, minute: DateTime.now().minute));
    if (tempTime == null) {
      return;
    }

    dateTime = DateTime(tempDate.year, tempDate.month, tempDate.day,
        tempTime.hour, tempTime.minute);

    if (dateTime!.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid time')));
      return;
    }
    setState(() {});
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              Text(
                  'Date Time now : ${DateTime.now().toString().replaceRange(16, null, '')}',style: TextStyle(fontSize: 18)),
              SizedBox(
                height: 10,
              ),
              (dateTime == null)
                  ? TextButton(
                      onPressed: takeDateTime,
                      child: Text('Click me select the date and time',style: TextStyle(fontSize: 16),))
                  : Container(
                      child: Text('Your selected date and time :' +
                          dateTime.toString().replaceRange(16, null, '')),
                    ),
              if (dateTime != null)
                ElevatedButton(
                    onPressed: () {
                      takeDateTime();
                    },
                    child: Text('Change date time')),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: originController,
                          decoration: InputDecoration(
                              hintText: 'Enter your origin',
                              suffixIcon: originController.text.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        originController.clear();
                                      },
                                      icon: Icon(Icons.clear))
                                  : null,
                              label: Center(
                                child: Text('Origin'),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your origin';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: destController,
                          decoration: InputDecoration(
                              hintText: 'Enter your destination',
                              suffixIcon: destController.text.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        destController.clear();
                                      },
                                      icon: Icon(Icons.clear))
                                  : null,
                              label: Center(
                                child: Text('Destination'),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your destination';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: fareController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Enter your fare',
                              suffixIcon: fareController.text.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        fareController.clear();
                                      },
                                      icon: Icon(Icons.clear))
                                  : null,
                              label: Center(
                                child: Text('Fare'),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Fare';
                            } else if (double.tryParse(value) == null) {
                              return 'Please enter a valid fare';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Return')),
                              ElevatedButton(
                                  onPressed: () {
                                    submitForm();
                                  },
                                  child: Text('Save')),
                            ],
                          ),
                        )
                      ],
                    )),
              )
            ],
          )),
        ),
      ),
    );
  }
}
