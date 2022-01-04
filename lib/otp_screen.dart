import 'package:flutter/material.dart';
// import 'package:numen_health/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:numen_health/home_screen.dart';
import 'background.dart';

// class OTPScreenn extends StatefulWidget {
//   const OTPScreenn({Key? key}) : super(key: key);

//   @override
//   _OTPScreennState createState() => _OTPScreennState();
// }

// class _OTPScreennState extends State<OTPScreenn> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.red,
//     );
//   }
// }

class OTPScreenn extends StatefulWidget {
  final String phoneNumber;
  const OTPScreenn({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  _OTPScreennState createState() => _OTPScreennState();
}

class _OTPScreennState extends State<OTPScreenn> {
  TextEditingController _otpController = TextEditingController();

  // FirebaseUser? _firebaseUser;
  String? _status;

  // AuthCredential? _phoneAuthCredential;
  String? _verificationId;
  int? _code;

  @override
  void initState() {
    print(widget.phoneNumber);
    super.initState();
    // _getFirebaseUser();
  }

  // Future<void> _getFirebaseUser() async {
  //   this._firebaseUser = await FirebaseAuth.instance.currentUser();
  //   setState(() {
  //     _status =
  //         (_firebaseUser == null) ? 'Not Logged In\n' : 'Already LoggedIn\n';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                "ENTER OTP",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA),
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            // Container(
            //   alignment: Alignment.center,
            //   margin: const EdgeInsets.symmetric(horizontal: 40),
            //   child: const TextField(
            //     decoration: InputDecoration(labelText: "Username"),
            //   ),
            // ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _otpController,
                decoration: const InputDecoration(labelText: "Enter OTP"),
                obscureText: true,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: const Text(
                "Resend-OTP",
                style: TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () {
                  print('pressed Submit button');
                  if (_otpController.text == "12345") {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (Route<dynamic> route) => false);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Enter valid OTP",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black54,
                        textColor: Colors.grey[50],
                        fontSize: 14.0);
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    "SUBMIT",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () => {},
                child: Text(
                  "${widget.phoneNumber} Not Your Number ?",
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
