
import 'package:flutter/material.dart';
import 'package:gari_chai_app/brand_colors.dart';
import 'package:gari_chai_app/screen/mainpage.dart';
import 'package:gari_chai_app/widgets/taxi_button.dart';

class VehicalInfoPage extends StatelessWidget {
  static const String id = 'vehicalinfo';

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void showSnackbar(String title){
    final snackbar = SnackBar(
      content: Text(title,textAlign: TextAlign.center,style: TextStyle(fontSize: 15)),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  var carModelController = TextEditingController();

  var carColorController = TextEditingController();

  var emailController = TextEditingController();

  var vehicalNumberController = TextEditingController();

  void updateProfile(context){
    String id = currentFirebaseUser.uid;
    DatabaseReference driverRef =FirebaseDatabase.instance.reference().child('drivers/$id/vehical_details');
    Map map ={
      'car_model': carModelController.text.trim(),
      'car_color': carColorController.text.trim(),
      'vehical_number': vehicalNumberController.text.trim(),
    };
    driverRef.set(map);
    Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 70),
                Image(
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  image: AssetImage('images/logo.png'),
                ),
                SizedBox(height: 20),
                Text('Create a Driver Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25,fontFamily: 'Brand-Bold'),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: carModelController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Car Model',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle: TextStyle(fontSize: 10,color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: carColorController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Car Color',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle: TextStyle(fontSize: 10,color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: vehicalNumberController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Vehical Number',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle: TextStyle(fontSize: 10,color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),
                      TaxiButton(
                        title: 'Proceed',
                        color: BrandColors.colorAccentPurple,
                        onPress: ()async{
                          if(carModelController.text.length < 3){
                            showSnackbar('plz Provide Valid Car Model');
                            return;
                          }
                          if(carColorController.text.length < 3){
                            showSnackbar('plz Provide Valid Car Color');
                            return;
                          }
                          if(vehicalNumberController.text.length < 3){
                            showSnackbar('plz Provide Valid Vehical Number');
                            return;
                          }
                          updateProfile(context);
                        },
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
