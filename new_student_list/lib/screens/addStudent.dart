import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CollectionReference student =
      FirebaseFirestore.instance.collection('student');

  TextEditingController studentName = TextEditingController();
  TextEditingController studentAge = TextEditingController();
  TextEditingController studentClass = TextEditingController();
  TextEditingController studentDiv = TextEditingController();
  PickedFile? _pickedImage;

  void addStudent() {
    final data = {
      'name': studentName.text,
      'age': studentAge.text,
      'class': studentClass.text,
      'div': studentDiv.text,
      'image_url': imageUrl,
    };
    student.add(data);
  }

  String imageUrl = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Students"),
          backgroundColor: const Color.fromARGB(255, 47, 7, 193),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: studentName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Student Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: studentAge,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Age",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an age';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: studentClass,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Class",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a class';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: studentDiv,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Div",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a division';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please upload an image')));

                      return;
                    }

                    if (_formKey.currentState?.validate() ?? false) {
                      // Form is valid, perform the action
                      addStudent();
                      Navigator.pop(context);
                    }
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 47, 7, 193),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
