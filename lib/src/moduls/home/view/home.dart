import 'dart:math';
import 'package:flutter/material.dart';
import 'package:notes/src/data/constants/colors.dart';
import 'package:notes/src/data/utils/database_helper.dart';
import 'package:notes/src/moduls/add/view/add_task_screen.dart';
import 'package:notes/src/moduls/edit/view/edit.dart';
import 'package:notes/src/moduls/home/local_widget/header_part.dart';
import 'package:notes/src/moduls/home/local_widget/note_design.dart';
import 'package:notes/src/moduls/home/local_widget/seach_bar.dart';
import '../../../data/models/note_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> data = [];
  List <Note>filteredData = [];
  DBHelper dbHelper = DBHelper();
  bool sorted = false;

  Color getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  @override
  void initState() {
    getData();
    dbHelper = DBHelper();
    super.initState();
  }

  void getData() async {
    data = await dbHelper.getCartData();
    filteredData = data ;
    debugPrint(filteredData.length.toString());
    filteredData = sortedByModifiedTIme(filteredData);
  }

  void onSearch(String searchText){
    setState(() {
      filteredData = data.where((note) => note.subtitle!.toLowerCase().contains(
          searchText.toLowerCase()) || note.title!.toLowerCase().contains(
          searchText.toLowerCase())).toList();
    });
  }

  List<Note> sortedByModifiedTIme(List<Note> notes){
    setState(() {
      if(sorted){
        notes.sort((a, b) => a.date.compareTo(b.date));
      }else{
        notes.sort((a, b)=> b.date.compareTo(a.date));
      }
      sorted = !sorted;
    });
    return notes;
  }


  void deleteNote(int index) {
    setState(() {
      dbHelper.delete(filteredData[index].id);
      filteredData.removeAt(index);
      debugPrint(data.length.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              HeaderPart(
               sortIconTap: (){
                 sortedByModifiedTIme(filteredData);
               },
             ),
              const SizedBox(
                height: 20,
              ),
              SearchBarPart(
                  onChanged: (value){
                    onSearch(value);
                  }),
              Expanded(
                  child: FutureBuilder(
                      future: dbHelper.getCartData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child:CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 5,
                          ) ,);
                        } else {
                          return ListView.builder(
                              padding: const EdgeInsets.only(top: 30),
                              itemCount: filteredData.length,
                              itemBuilder: (context, index) {
                                if (filteredData.isEmpty) {
                                  return Container(
                                    height: 100,
                                      width: 100,
                                      color: Colors.white,
                                      child: const Text('no data here', style: TextStyle(color: Colors.white),));
                                }else {
                                  return NoteDesign(
                                      cardColor: getRandomColor(),
                                      cardOnTap: (){
                                        Note note = data[index];
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditScreen(
                                                      note: note,
                                                    )));
                                      },
                                      title: filteredData[index].title.toString(),
                                      subTitle: filteredData[index].subtitle.toString(),
                                      deleteWork: (){
                                        deleteNote(index);
                                      },
                                      dateAbdTime: filteredData[index].date
                                  );
                                }
                              });
                        }
                      })),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTaskScreen()));
        },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(
          Icons.add,
          size: 38,
        ),
      ),
    );
  }

  Future<dynamic> confirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            icon: const Icon(
              Icons.info,
              color: Colors.grey,
            ),
            title: const Text(
              "Are you sure you want to delete?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const SizedBox(
                      width: 60,
                      child: Text(
                        "Yes",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const SizedBox(
                      width: 60,
                      child: Text(
                        "no",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          );
        });
  }
}
