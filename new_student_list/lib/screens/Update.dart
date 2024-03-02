import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStudent extends StatefulWidget {
  const UpdateStudent({Key? key}) : super(key: key);

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  final CollectionReference student =
      FirebaseFirestore.instance.collection('student');

  TextEditingController studentName = TextEditingController();
  TextEditingController studentAge = TextEditingController();
  TextEditingController studentClass = TextEditingController();
  TextEditingController studentDiv = TextEditingController();

  void updateStudent(docId) {
    final data = {
      'name': studentName.text,
      'age': studentAge.text,
      'class': studentClass.text,
      'div': studentDiv.text,
    };
    student.doc(docId).update(data);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    studentName.text = args['name'];
    studentAge.text = args['age'];
    studentClass.text = args['class'];
    studentDiv.text = args['div'];
    final docId = args['id'];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Update Student"),
          backgroundColor: const Color.fromARGB(255, 47, 7, 193),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                controller: studentName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Student Name",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: studentAge,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Age",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: studentClass,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Class",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: studentDiv,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Div",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  updateStudent(docId);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 47, 7, 193),
                  ),
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
