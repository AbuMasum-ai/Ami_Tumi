import 'package:flutter/material.dart';
import 'package:gari_chai_app/brand_colors.dart';

class ProgressDialog extends StatelessWidget {
  final String status;
  ProgressDialog({this.status});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              SizedBox(width: 5),
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(BrandColors.colorAccent)),
              SizedBox(width: 25),
              Text(status,style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
