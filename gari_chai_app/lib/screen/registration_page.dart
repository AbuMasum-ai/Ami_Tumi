
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gari_chai_app/brand_colors.dart';
import 'package:gari_chai_app/golbalvariable.dart';
import 'package:gari_chai_app/screen/vehicalinfo.dart';
import 'package:gari_chai_app/widgets/progress_dialog.dart';
import 'package:gari_chai_app/widgets/taxi_button.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'register';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void showSnackbar(String title){
    final snackbar = SnackBar(
      content: Text(title,textAlign: TextAlign.center,style: TextStyle(fontSize: 15)),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  var fullNameController = TextEditingController();

  var phoneController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  void registerUser() async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext Context)=> ProgressDialog(status: 'Register Done'),
    );
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password:passwordController.text.trim(),
    )).user;

    // if user register successfull
    if(user !=null){
      DatabaseReference newUserRef =FirebaseDatabase.instance.reference().child('drivers/${user.uid}');
      // Prepare data to saved on user model
      Map userMap ={
        'fullName': fullNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      };
      newUserRef.set(userMap);
      // Take the user to main page
      currentFirebaseUser = user;
      Navigator.pushNamed(context, VehicalInfoPage.id);
    }
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
                        controller: fullNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle: TextStyle(fontSize: 10,color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle: TextStyle(fontSize: 10,color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle: TextStyle(fontSize: 10,color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle: TextStyle(fontSize: 10,color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 40),
                      TaxiButton(
                        title: 'Register',
                        color: BrandColors.colorAccentPurple,
                        onPress: ()async{
                          var connectivityResult = await Connectivity().checkConnectivity();
                          if(connectivityResult !=ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
                            showSnackbar('No Internet Connection');
                            return;
                          }

                          if(fullNameController.text.length < 3){
                            showSnackbar('plz Provide Valid Name');
                            return;
                          }
                          if(phoneController.text.length < 11){
                            showSnackbar('plz Provide Valid Phone Number');
                            return;
                          }
                          if(!emailController.text.contains('@')){
                            showSnackbar('plz Provide Valid Email Address');
                            return;
                          }
                          if(passwordController.text.length < 6){
                            showSnackbar('Password Must be at least 6 Characters');
                            return;
                          }
                          registerUser();
                        },
                      ),
                    ],
                  ),
                ),

                FlatButton(
                  onPressed: (){
                    //Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
                  },
                  child: Text('Already Have a Driver Account, Login here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
