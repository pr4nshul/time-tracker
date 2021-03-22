import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker1/common_widgets/alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog(
      {@required String title, @required PlatformException exception})
      : super(
          title: title,
          content: _returnException(exception),
          actionText: "OK",
        );
}

String _returnException(PlatformException e){
  return _error[e.code] ??e.message;
}

Map <String,String> _error ={
   "email-already-in-use": "Given email is already in use",
   "invalid-email":"The entered email is invalid",
   "operation-not-allowed":"This operation is not allowed",
   "weak-password":"Please enter a stronger password",
   "user-disabled":"This user had been disabled!",
   "user-not-found":"User not found!",
   "wrong-password":"The entered password is not valid",
};