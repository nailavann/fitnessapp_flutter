import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp_flutter/screens/features/agepage.dart';
import 'package:flutter/material.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({Key? key}) : super(key: key);

  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  int genderValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/homephoto1.png'),
                  fit: BoxFit.cover),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 11, sigmaY: 11),
              child: Container(
                color: Colors.white.withOpacity(.123),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "What is your sex?",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => setState(() {
                                genderValue = 0;
                              }),
                              child: Container(
                                  height: 156,
                                  width: 156,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey[200]),
                                  child: Icon(
                                    Icons.male,
                                    size: 100,
                                    color: genderValue == 0
                                        ? Colors.blue
                                        : Colors.grey[400],
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Man",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => setState(() => genderValue = 1),
                              child: Container(
                                height: 156,
                                width: 156,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[200]),
                                child: Icon(
                                  Icons.female,
                                  size: 100,
                                  color: genderValue == 1
                                      ? Colors.red
                                      : Colors.grey[400],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Woman",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                            builder: (context) {
                              return const AgePage();
                            },
                          ), (route) => false);

                          await FirebaseFirestore.instance
                              .collection('Person')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            'gender': genderValue == 0 ? 'Erkek' : 'Kadın'
                          });
                        },
                        child: const Text(
                          "Next",
                          style: TextStyle(color: Colors.black),
                        ))),
              ),
            ],
          )
        ],
      ),
    );
  }
}
