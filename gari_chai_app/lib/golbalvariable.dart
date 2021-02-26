import 'dart:async';

import 'package:flutter/material.dart';

FirebaseUser currentFirebaseUser;
String mapKey = 'AIzaSyCGDOgE33dc-6UHtIAptXSAVZRogFvV8Hs';

final CameraPosition googlePlex = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);

StreamSubscription<Position> homeTabPositionStream;