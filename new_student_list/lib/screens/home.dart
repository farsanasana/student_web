import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference student =
      FirebaseFirestore.instance.collection('student');

  void deleteStudent(docId) {
    student.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Student List"),
          backgroundColor: const Color.fromARGB(255, 47, 7, 193),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add');
          },
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            size: 20,
            color: Color.fromARGB(255, 47, 7, 193),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        body: StreamBuilder(
          stream: student.orderBy('name').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot studentSnap =
                      snapshot.data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Display the image in the CircleAvatar
                            Container(
                              child: CircleAvatar(
                                // backgroundColor:
                                //     const Color.fromARGB(255, 47, 7, 193),

                                child: Image.asset(
                                  'asset/45678.png',
                                  // fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  studentSnap['name'],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  studentSnap['age'].toString(),
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/update',
                                        arguments: {
                                          'name': studentSnap['name'],
                                          'age': studentSnap['age'].toString(),
                                          'class':
                                              studentSnap['class'].toString(),
                                          'div': studentSnap['div'],
                                          'id': studentSnap.id
                                        });
                                  },
                                  icon: const Icon(Icons.edit),
                                  iconSize: 30,
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteStudent(studentSnap.id);
                                  },
                                  icon: const Icon(Icons.delete),
                                  iconSize: 30,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
