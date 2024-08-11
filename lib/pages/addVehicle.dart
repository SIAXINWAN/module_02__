import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_wsmb2024_02/models/vehicle.dart';
import 'package:mobile_wsmb2024_02/pages/loginPage.dart';
import 'package:mobile_wsmb2024_02/widgets/bottomSheet.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
   
  final modelController = TextEditingController();
  final capacityController = TextEditingController();
  final featureController = TextEditingController();
  final formKey = GlobalKey<FormState>();

   File? image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    featureController.text = 'None';
   
  }

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

  void submitForm() async {
    if(image==null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please upload your vehicle photo first')));
      return;
    }

    if (formKey.currentState!.validate()) {
      var res = await Vehicle.register(modelController.text,
          int.parse(capacityController.text), featureController.text, image);
      if (res) {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Success'),
                  content: Text('Your vehicle is added successfully'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'))
                  ],
                ));
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
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

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.greenAccent,
        automaticallyImplyLeading: false,
        title: Text('KONGSI KERETA'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text('Vehicle Information',style: TextStyle(fontSize: 36),),
                SizedBox(height: 20,),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      (image==null)?TextButton(
                        onPressed: (){
                          takePhoto(context);
                        },
                        child: Text('Please Take Photo')):CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(image!),),
                      SizedBox(height: 30,),
                      TextFormField(
                        controller: modelController,
                        decoration: InputDecoration(
                            hintText: 'Enter your car model',
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
                            return 'Please enter your car model';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: capacityController,
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
                            return 'Please enter your car capacity';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: featureController,
                        decoration: InputDecoration(
                            hintText: 'Enter your car special features',
                            suffixIcon: featureController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      featureController.clear();
                                    },
                                    icon: Icon(Icons.clear))
                                : null,
                            label: Center(
                              child: Text('Special Features'),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your car special features';
                          }
                          return null;
                        },
                      ),
                      ])),
                      SizedBox(
                        height: 50,

                      ),
                      ElevatedButton(onPressed: (){
                    submitForm();
                  }, child: Text('Submit'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}