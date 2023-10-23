import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/note_model.dart';
import '../../../data/utils/database_helper.dart';
import '../../home/view/home.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController subTitleTextEditingController = TextEditingController();

  DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      obscureText: false,
                      controller: titleTextEditingController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Title',
                          hintStyle: TextStyle(fontSize: 25, color: Colors.grey))),
                  Text(
                    DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: TextField(
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        obscureText: false,
                        controller: subTitleTextEditingController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'your notes',
                            hintStyle: TextStyle(color: Colors.grey))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ]),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              dbHelper
                  .insertData(Note(
                  title: titleTextEditingController.text.toString(),
                  subtitle: subTitleTextEditingController.text.toString(),
                  date: '${DateTime.now()}'))
                  .then(
                      (value) => {debugPrint("successfully added to database")})
                  .onError((error, stackTrace) =>
              {debugPrint("failed to add database")});
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (route) => false);
            },
            label: const Text('Save'),
            icon: const Icon(Icons.save)));
  }
}
