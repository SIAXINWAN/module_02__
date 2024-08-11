import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02/pages/loginPage.dart';
import 'package:overflow_text_animated/overflow_text_animated.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 200,
        title: const Column(
          children: [
            
            SizedBox(height: 30,),
            Center(child: Icon(Icons.car_rental,size: 150,)),
          ],
        ),
        
    ),
    body: SafeArea(child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: [
             Container(
              decoration: const BoxDecoration(
                color:Colors.lightGreenAccent
              ),
              child: const OverflowTextAnimated(
                  text: 'Save money and energy  reduces carbon footprint, empowers to take action against climate change and expands social circle',
                  style: TextStyle(fontSize: 24),
                  animation: OverFlowTextAnimations.infiniteLoop,
                  loopSpace: 30,
                ),
            ),
            SizedBox(height: 20,),
            const Text('Welcome to \nKONGSI KERETA',textAlign: TextAlign.center,style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
           
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
              onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LoginPage()));
            }, 
            child: const Text('Get Started',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    )),);
  }
}