import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_wsmb2024_02/models/driver.dart';
import 'package:mobile_wsmb2024_02/pages/addVehicle.dart';
import 'package:mobile_wsmb2024_02/pages/loginPage.dart';
import 'package:mobile_wsmb2024_02/widgets/bottomSheet.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  final nameController = TextEditingController();
  final icnoController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final aaddressController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String gender = 'male';

  void genderChanged(String? value) {
    setState(() {
      gender = value!;
    });
  }



  void submitForm(BuildContext context) async {
    if (image == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Warning'),
                content: Text('Please upload your image'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'))
                ],
              ));
      return;
    }
    if (formKey.currentState!.validate()) {
      Driver tempHuman = Driver(
        phone: phoneController.text,
        email: emailController.text,
        address: aaddressController.text,
        icno: icnoController.text,
        name: nameController.text,
        gender: gender == 'male',
      );

      var driver = await Driver.registerDriver(
          tempHuman, passwordController.text, image!);

      if (driver == null) {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('warning'),
                  content: Text('Something went wrong'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'))
                  ],
                ));
      } else {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Success'),
                  content: Text('Your submit is successful\nNow register your vehicle',style: TextStyle(fontSize: 16),),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddVehiclePage()));
                        },
                        child: Text('OK'))
                  ],
                ));
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
         backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              Text('Driver Information',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 20,
              ),
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
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: 'Enter your name',
                            suffixIcon: nameController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      nameController.clear();
                                    },
                                    icon: Icon(Icons.clear))
                                : null,
                            label: Center(
                              child: Text('Name'),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: icnoController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Enter your ic',
                            suffixIcon: icnoController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      icnoController.clear();
                                    },
                                    icon: Icon(Icons.clear))
                                : null,
                            label: Center(
                              child: Text('IC'),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your IC';
                          } else if (value.length != 12) {
                            return 'Please enter a valid ic';
                          }
                          return null;
                        },
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Gender'),
                            Radio(value: 'male',
                             groupValue: gender,
                              onChanged: genderChanged)
                            ,Text('Male'),
                            SizedBox(width: 8,),
                            Radio(value: 'female',
                             groupValue: gender,
                              onChanged: genderChanged)
                            ,Text('Female'),
                          ],
                        ),
                      ),
                       TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Enter your phone number',
                            suffixIcon: phoneController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      phoneController.clear();
                                    },
                                    icon: Icon(Icons.clear))
                                : null,
                            label: Center(
                              child: Text('Phone Number'),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (int.tryParse(value)==null) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                       TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: 'Enter your email',
                            suffixIcon: emailController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      emailController.clear();
                                    },
                                    icon: Icon(Icons.clear))
                                : null,
                            label: Center(
                              child: Text('Email'),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                       TextFormField(
                        controller: aaddressController,
                        decoration: InputDecoration(
                            hintText: 'Enter your address',
                            suffixIcon: aaddressController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      aaddressController.clear();
                                    },
                                    icon: Icon(Icons.clear))
                                : null,
                            label: Center(
                              child: Text('Address'),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          } 
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Enter your password',
                            suffixIcon: passwordController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      passwordController.clear();
                                    },
                                    icon: Icon(Icons.clear))
                                : null,
                            label: Center(
                              child: Text('Password'),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length<6) {
                            return 'Please enter a strong password';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
                  SizedBox(height: 8,),
                  ElevatedButton(onPressed: (){
                    submitForm(context);
                  }, child: Text('Next'))
            ],
          )),
        ),
      ),
    );
  }
}
