import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gari_chai_app/brand_colors.dart';
import 'package:gari_chai_app/golbalvariable.dart';
import 'package:gari_chai_app/widgets/taxi_button.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  Position currentPosition;

  DatabaseReference tripRequestRef;
  var geolocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.bestForNavigation,distanceFilter: 4);

  void getCurrentPosition()async{
    Position position = await
    Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;

    LatLng pos = LatLng(position.latitude, position.longitude);
    mapController.animateCamera(CameraUpdate.newLatLng(pos));

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          padding: EdgeInsets.only(top: 135),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: googlePlex,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
            mapController = controller;

            getCurrentPosition();
          },
        ),
        Container(
          height: 135,
          width: double.infinity,
          color: BrandColors.colorPrimary,
        ),
        Positioned(
          top: 60,left: 0,right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TaxiButton(
                title: 'Go Online',
                color: BrandColors.colorOrange,
                onPress: (){
                  GoOnline();
                  getLocationUpdates();
                },
              ),
            ],
          ),
        ),
      ],
    );


  }

  void GoOnline(){
    Geofire.initialize('driversAvailable');
    Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude, currentPosition.longitude);
    
    tripRequestRef = FirebaseDatabase.instance.reference().child('drivers/${currentFirebaseUser.uid}/newTrip');
    tripRequestRef.set('Waiting');

    tripRequestRef.onValue.listen((event) { });
  }

  void getLocationUpdates(){
    homeTabPositionStream = geolocator.getPositionStream(locationOptions).listen((Position position) {
      currentPosition = position;
      Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude, currentPosition.longitude);
      LatLng pos = LatLng(position.latitude, position.longitude);
      mapController.animateCamera(CameraUpdate.newLatLng(pos));
    });
  }
}
