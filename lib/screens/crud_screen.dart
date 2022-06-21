import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDPage extends StatefulWidget {
  const CRUDPage({Key? key}) : super(key: key);

  @override
  State<CRUDPage> createState() => _CRUDPageState();
}

class _CRUDPageState extends State<CRUDPage> {
  String? _SName, _SRollno, _SGender;
  double? _CGPA;

  GetCgpa(cgp) {
    this._CGPA = double.parse(cgp);
  }

  GetSname(sname) {
    this._SName = sname;
  }

  GetSRoll(sroll) {
    this._SRollno = sroll;
  }

  GetSGender(sgen) {
    this._SGender = sgen;
  }

  CreateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Userdata').doc(_SName);

    Map<String, dynamic> users = {
      "username": _SName,
      "userroll": _SRollno,
      "usergender": _SGender,
      "usercgpa": _CGPA
    };

    documentReference.set(users).whenComplete(() => {print("$_SName created")});
  }

  ReadData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Userdata').doc(_SName);

    documentReference.get().then((datasnapshot) => {
          // print(datasnapshot.data['username']);
          // print(datasnapshot.data["userroll"]);kalishkaka
          // print(datasnapshot.data["usergender"]);
          // print(datasnapshot.data["usercgpa"]);
        });
  }

  UpdateData() {
    print('updeted');

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Userdata').doc(_SName);

    Map<String, dynamic> users = {
      "username": _SName,
      "userroll": _SRollno,
      "usergender": _SGender,
      "usercgpa": _CGPA
    };

    documentReference.set(users).whenComplete(() => {print("$_SName updated")});
  }

  DeleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Userdata').doc(_SName);

    documentReference.delete().whenComplete(() => {print("$_SName deleted")});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CRUD Operation')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Enter Your Name',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String name) {
                  GetSname(name);
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Enter Your Roll No',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (String roll) {
                GetSRoll(roll);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Enter Your CGPA',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (String cgp) {
                GetCgpa(cgp);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Enter Your Gender',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (String gender) {
                GetSGender(gender);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  CreateData();
                },
                child: Text("CREATE"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ReadData();
                },
                child: Text("READ"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  UpdateData();
                },
                child: Text("UPDATE"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  DeleteData();
                },
                child: Text("DELETE"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ],
          ),


          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              textDirection: TextDirection.ltr,
              children:const [
                        Expanded(child: Text('Name',style:TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('Roll No',style:TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('Gender',style:TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text('CGPA',style:TextStyle(fontWeight: FontWeight.bold))),
             
            ],),
          ),

          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('Userdata').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Expanded(child: Text(documentSnapshot['username'])),
                        Expanded(child: Text(documentSnapshot['userroll'])),
                        Expanded(child: Text(documentSnapshot['usergender'])),
                        Expanded(
                            child: Text(documentSnapshot['usercgpa'].toString())),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
