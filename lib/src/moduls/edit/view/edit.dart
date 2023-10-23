import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/models/note_model.dart';
import '../../../data/utils/database_helper.dart';
import '../../home/view/home.dart';

class EditScreen extends StatefulWidget {
  final Note note;
  const EditScreen({super.key, required this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController subTitleTextEditingController = TextEditingController();
  DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    dbHelper = DBHelper();

    // print(widget.index);
    setData();
    super.initState();
  }


  void setData(){
    titleTextEditingController.text =  widget.note.title.toString();
    subTitleTextEditingController.text = widget.note.subtitle.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
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
               ' ${DateFormat.yMEd().add_jms().format(DateTime.now())}',
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
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          debugPrint(titleTextEditingController.text);
          dbHelper.updatedQuentity(Note(
              id:widget.note.id,
              title: titleTextEditingController.text,
              subtitle: subTitleTextEditingController.text,
              date: DateTime.now().toString()
          )).then((value) => {
            debugPrint("success"),
            debugPrint(widget.note.toString()),
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context)=> const HomeScreen()),
                    (route) => false)
          }).onError((error, stackTrace) => {
            debugPrint("failed")
          });
        },
        label: const Text('Update'),
        icon: const Icon(Icons.update),
      ),
    );
  }
}
