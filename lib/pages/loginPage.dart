import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02/models/driver.dart';
import 'package:mobile_wsmb2024_02/models/ride.dart';
import 'package:mobile_wsmb2024_02/models/vehicle.dart';
import 'package:mobile_wsmb2024_02/pages/homePage.dart';
import 'package:mobile_wsmb2024_02/pages/registerPage.dart';
import 'package:mobile_wsmb2024_02/services/firestoreService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage> {

  final icnoController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

 
 
  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      var driver =
          await Driver.loginDriver(icnoController.text, passwordController.text);
      if (driver == null) {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Warning'),
                  content: Text('Invalid Login'),
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
                  content: Text('Login Successfully'),
                  actions: [
                    TextButton(
                        onPressed: () async{
                          Driver? driver = await Driver.getDriverbyToken();
                          List<Ride>rideList  = await FirestoreService.getRide();
                          Vehicle ? vehicle = await Vehicle.getVehicleByToken();
                          
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage(
                                rideList: rideList,
                                driver: driver!,
                                vehicle:vehicle!

                               
                              )));
                        },
                        child: Text('OK'))
                  ],
                ));}}}
      

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        automaticallyImplyLeading: false,
        title: Center(child: Text('KONGSI KERETA',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold))),
      ),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Login',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                Form(
                  key: formKey,
                  child: Column(
                  children: [
                    TextFormField(
                      controller: icnoController,
                      keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter your IC',
                      suffixIcon: icnoController.text.isNotEmpty?IconButton(onPressed: (){
                        icnoController.clear();
                      }, icon: Icon(Icons.clear)):null,
                      label: Center(child: Text('IC'),
                      )
                    ),
                      validator: (value){
                        if(value==null||value.isEmpty){
                          return 'Please enter your ic';
                        }else if(value.length !=12){
                          return 'Please enter a valid ic ';
                        }
                        return null;
                      },
                    ),
                     TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                      hintText: 'Enter your password',
                      suffixIcon: passwordController.text.isNotEmpty?IconButton(onPressed: (){
                        passwordController.clear();
                      }, icon: Icon(Icons.clear)):null,
                      label: Center(child: Text('Password'),
                      )
                    ),
                      validator: (value){
                        if(value==null||value.isEmpty){
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
                SizedBox(height: 60,),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegisterPage()),
                    );
                  },
                  child: Text('Do not have account yet?\nRegister Now!',textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 22,color: Colors.blue,decoration: TextDecoration.underline,
            decorationColor: Colors.blue,
                  ),),
                ),
            SizedBox(height: 150,),
                ElevatedButton(onPressed: (){
                  login();
                }, child: Text('Login',style: TextStyle(fontSize: 24),))
            
              ],
            ),
          ),
        ),
      )),
    );
  }
}