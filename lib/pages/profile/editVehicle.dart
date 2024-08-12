import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_wsmb2024_02/models/driver.dart';
import 'package:mobile_wsmb2024_02/models/vehicle.dart';
import 'package:mobile_wsmb2024_02/services/firestoreService.dart';
import 'package:mobile_wsmb2024_02/widgets/bottomSheet.dart';

class EditVehicle extends StatefulWidget {
  const EditVehicle({super.key, required this.vehicle});
  final Vehicle vehicle;

  @override
  State<EditVehicle> createState() => _EditVehicleState();
}

class _EditVehicleState extends State<EditVehicle> {
  
      File? image;

  Future<void> takePhoto(BuildContext context) async {
    ImageSource? source = await showModalBottomSheet(
        context: context, builder: (context) => bottomSheet(context));

    if (source == null) {
      return;
    }

    ImagePicker picker = ImagePicker();
    var file = await picker.pickImage(source: source);
    if (file == null) {
      return;
    }

    image = File(file.path);
    setState(() {});
  }

  Widget displayImage() {
    if (image != null) {
      return Image.file(
        image!,
        fit: BoxFit.cover,
        height: 100,
        width: double.infinity,
      );
    } else if (widget.vehicle.image != null) {
      return Image.network(
        widget.vehicle.image!,
        fit: BoxFit.cover,
        height: 100,
        width: double.infinity,
      );
    } else {
      return Container(
        height: 100,
        width: double.infinity,
        color: Colors.grey,
        child: Icon(Icons.person),
      );
    }
  }

  final modelController = TextEditingController();
  final featuresController = TextEditingController();
  final capacityController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  

  void submitForm() async {
    if (image != null) {
      widget.vehicle.image = await Vehicle.saveImage(image!);
    }
    if (formKey.currentState!.validate()) {
      Vehicle vehicle =Vehicle(car_model: modelController.text, capacity: int.parse(capacityController.text), special_features: featuresController.text,image: image.toString() );
        
      var res = await FirestoreService.updateVehicle(vehicle, widget.vehicle.id!);

      if (res) {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Success'),
                  content: Text('Your profile is updated successfully'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok'))
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
                        child: Text('Ok'))
                  ],
                ));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    modelController.text = widget.vehicle.car_model;
    capacityController.text = widget.vehicle.capacity.toString();
    featuresController.text = widget.vehicle.special_features;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              child: ClipOval(
                                child: displayImage(),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: OutlinedButton(
                            onPressed: () {
                              takePhoto(context);
                            },
                            child: Text('Take Photo')),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                     Form(
                      key: formKey,
                       child: Column(
                         children: [
                           TextFormField(
                              controller: modelController,
                              decoration: InputDecoration(
                                  hintText: 'Enter your car_model',
                                  suffixIcon: modelController.text.isNotEmpty
                                      ? IconButton(
                                          onPressed: () {
                                            modelController.clear();
                                          },
                                          icon: Icon(Icons.clear))
                                      : null,
                                  label: Center(
                                    child: Text('Car Model'),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your model';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                        controller: capacityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Enter your car capacity',
                            suffixIcon: capacityController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      capacityController.clear();
                                    },
                                    icon: Icon(Icons.clear))
                                : null,
                            label: Center(
                              child: Text('Capacity'),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your capacity';
                          } else if(int.tryParse(value)==null){
                            return 'Please enter a valid car capacity';
                          }
                          return null;
                        },
                      ),
                      
                       TextFormField(
                        controller: featuresController,
                        decoration: InputDecoration(
                            hintText: 'Enter your car special features',
                            suffixIcon: featuresController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      featuresController.clear();
                                    },
                                    icon: Icon(Icons.clear))
                                : null,
                            label: Center(
                              child: Text('Features'),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your special features';
                          } 
                          return null;
                        },
                      ),
                       
                      
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3))),
                          onPressed: () {
                            submitForm();
                          },
                          child: Text("Update Data"))
                  ]))]))));
  }
}
  
