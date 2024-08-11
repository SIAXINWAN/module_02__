// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mobile_wsmb2024_02/models/driver.dart';
// import 'package:mobile_wsmb2024_02/models/vehicle.dart';
// import 'package:mobile_wsmb2024_02/services/firestoreService.dart';
// import 'package:mobile_wsmb2024_02/widgets/bottomSheet.dart';

// class EditVehicle extends StatefulWidget {
//   const EditVehicle({super.key, required this.vehicle});
//   final Vehicle vehicle;

//   @override
//   State<EditVehicle> createState() => _EditVehicleState();
// }

// class _EditVehicleState extends State<EditVehicle> {
  
//       File? image;

//   Future<void> takePhoto(BuildContext context) async {
//     ImageSource? source = await showModalBottomSheet(
//         context: context, builder: (context) => bottomSheet(context));

//     if (source == null) {
//       return;
//     }

//     ImagePicker picker = ImagePicker();
//     var file = await picker.pickImage(source: source);
//     if (file == null) {
//       return;
//     }

//     image = File(file.path);
//     setState(() {});
//   }

//   Widget displayImage() {
//     if (image != null) {
//       return Image.file(
//         image!,
//         fit: BoxFit.cover,
//         height: 100,
//         width: double.infinity,
//       );
//     } else if (widget.vehicle.image != null) {
//       return Image.network(
//         widget.vehicle.image!,
//         fit: BoxFit.cover,
//         height: 100,
//         width: double.infinity,
//       );
//     } else {
//       return Container(
//         height: 100,
//         width: double.infinity,
//         color: Colors.grey,
//         child: Icon(Icons.person),
//       );
//     }
//   }

//   final modelController = TextEditingController();
//   final featuresController = TextEditingController();
//   final capacityController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
  
  

//   void submitForm() async {
//     if (image != null) {
//       widget.vehicle.image = await Driver.saveImage(image!);
//     }
//     if (formKey.currentState!.validate()) {
//       Vehicle vehicle =Vehicle(car_model: modelController.text, capacity: capacityController.text, special_features: featuresController.text, );
        
//       var res = await FirestoreService.updateDriver(vehicle, widget.driver.id!);

//       if (res) {
//         await showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//                   title: Text('Success'),
//                   content: Text('Your profile is updated successfully'),
//                   actions: [
//                     TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Text('Ok'))
//                   ],
//                 ));
//         Navigator.of(context).pop();
//       } else {
//         await showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//                   title: Text('Warning'),
//                   content: Text('Something went wrong'),
//                   actions: [
//                     TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Text('Ok'))
//                   ],
//                 ));
//       }
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     passwordController.text = widget.driver.password!;
//     nameController.text = widget.driver.name;
//     icnoController.text = widget.driver.icno;
//     gender = widget.driver.gender ? 'male' : 'female';
//     addressController.text = widget.driver.address;
//     phoneController.text = widget.driver.phone;
//     emailController.text = widget.driver.email;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Edit Profile'),
//         ),
//         body: SingleChildScrollView(
//             child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: 20,
//                       ),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 50,
//                               child: ClipOval(
//                                 child: displayImage(),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Center(
//                         child: OutlinedButton(
//                             onPressed: () {
//                               takePhoto(context);
//                             },
//                             child: Text('Take Photo')),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                      Form(
//                       key: formKey,
//                        child: Column(
//                          children: [
//                            TextFormField(
//                               controller: nameController,
//                               decoration: InputDecoration(
//                                   hintText: 'Enter your name',
//                                   suffixIcon: nameController.text.isNotEmpty
//                                       ? IconButton(
//                                           onPressed: () {
//                                             nameController.clear();
//                                           },
//                                           icon: Icon(Icons.clear))
//                                       : null,
//                                   label: Center(
//                                     child: Text('Name'),
//                                   )),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your name';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             TextFormField(
//                         controller: icnoController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                             hintText: 'Enter your ic',
//                             suffixIcon: icnoController.text.isNotEmpty
//                                 ? IconButton(
//                                     onPressed: () {
//                                       icnoController.clear();
//                                     },
//                                     icon: Icon(Icons.clear))
//                                 : null,
//                             label: Center(
//                               child: Text('IC'),
//                             )),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your IC';
//                           } else if (value.length != 12) {
//                             return 'Please enter a valid ic';
//                           }
//                           return null;
//                         },
//                       ),
//                       Center(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text('Gender'),
//                             Radio(value: 'male',
//                              groupValue: gender,
//                               onChanged: genderChanged)
//                             ,Text('Male'),
//                             SizedBox(width: 8,),
//                             Radio(value: 'female',
//                              groupValue: gender,
//                               onChanged: genderChanged)
//                             ,Text('Female'),
//                           ],
//                         ),
//                       ),
//                        TextFormField(
//                         controller: phoneController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                             hintText: 'Enter your phone number',
//                             suffixIcon: phoneController.text.isNotEmpty
//                                 ? IconButton(
//                                     onPressed: () {
//                                       phoneController.clear();
//                                     },
//                                     icon: Icon(Icons.clear))
//                                 : null,
//                             label: Center(
//                               child: Text('Phone Number'),
//                             )),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your phone number';
//                           } else if (int.tryParse(value)==null) {
//                             return 'Please enter a valid phone number';
//                           }
//                           return null;
//                         },
//                       ),
//                        TextFormField(
//                         controller: emailController,
//                         decoration: InputDecoration(
//                             hintText: 'Enter your email',
//                             suffixIcon: emailController.text.isNotEmpty
//                                 ? IconButton(
//                                     onPressed: () {
//                                       emailController.clear();
//                                     },
//                                     icon: Icon(Icons.clear))
//                                 : null,
//                             label: Center(
//                               child: Text('Email'),
//                             )),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           } else if (!value.contains('@')) {
//                             return 'Please enter a valid email';
//                           }
//                           return null;
//                         },
//                       ),
//                        TextFormField(
//                         controller: addressController,
//                         decoration: InputDecoration(
//                             hintText: 'Enter your address',
//                             suffixIcon: addressController.text.isNotEmpty
//                                 ? IconButton(
//                                     onPressed: () {
//                                       addressController.clear();
//                                     },
//                                     icon: Icon(Icons.clear))
//                                 : null,
//                             label: Center(
//                               child: Text('Address'),
//                             )),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your address';
//                           } 
//                           return null;
//                         },
//                       ),
//                       TextFormField(
//                         controller: passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                             hintText: 'Enter your password',
//                             suffixIcon: passwordController.text.isNotEmpty
//                                 ? IconButton(
//                                     onPressed: () {
//                                       passwordController.clear();
//                                     },
//                                     icon: Icon(Icons.clear))
//                                 : null,
//                             label: Center(
//                               child: Text('Password'),
//                             )),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your password';
//                           } else if (value.length<6) {
//                             return 'Please enter a strong password';
//                           }
//                           return null;
//                         },
//                       ),
                    
                  
//                          ],
//                        ),
//                      ),
                      
//                       SizedBox(
//                         height: 16,
//                       ),
//                       ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(3))),
//                           onPressed: () {
//                             submitForm();
//                           },
//                           child: Text("Update Data"))
//                   ]))));
//   }
// }
  
