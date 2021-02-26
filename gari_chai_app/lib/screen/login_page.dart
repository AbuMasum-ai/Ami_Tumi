
import 'package:flutter/material.dart';
import 'package:gari_chai_app/brand_colors.dart';
import 'package:gari_chai_app/screen/mainpage.dart';
import 'package:gari_chai_app/screen/registration_page.dart';
import 'package:gari_chai_app/widgets/progress_dialog.dart';
import 'package:gari_chai_app/widgets/taxi_button.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackbar(String title){
    final snackbar = SnackBar(
      content: Text(title,textAlign: TextAlign.center,style: TextStyle(fontSize: 15)),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  void loginUser() async{
    // Show Dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)=> ProgressDialog(status: 'Loggin you in'),
    );
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password:passwordController.text.trim(),
    )).user;
    Navigator.pop(context);
    // if user register successfull
    if(user !=null){
      DatabaseReference userRef =FirebaseDatabase.instance.reference().child('drivers/${user.uid}');
      // Prepare data to saved on user model
      userRef.once().then((DataSnapshot snapshot){
        if(snapshot.value !=null){
          Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
        }
      });
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
                SizedBox(height: 40),
                Text('Sign In as Driver',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25,fontFamily: 'Brand-Bold'),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
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
                        title: 'Login',
                        color: BrandColors.colorGreen,
                        onPress: ()async{
                          //Check Network Avaibility
                          var connectivityResult = await Connectivity().checkConnectivity();
                          if(connectivityResult !=ConnectivityResult.mobile && connectivityResult !=ConnectivityResult.wifi){
                            showSnackbar('No Internet Connection');
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
                          loginUser();
                        },

                      ),
                    ],
                  ),

                ),

                FlatButton(
                  onPressed: (){
                    Navigator.pushNamedAndRemoveUntil(context, RegistrationPage.id, (route) => false);
                  },
                  child: Text('Dont Have an Account, signup here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


