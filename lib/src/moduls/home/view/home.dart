import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/src/data/constants/colors.dart';
import 'package:notes/src/data/utils/database_helper.dart';
import 'package:notes/src/moduls/add/view/add_task_screen.dart';
import 'package:notes/src/moduls/edit/view/edit.dart';

import '../../../data/models/note_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Note> data = [];
  List filteredData = [];
  DBHelper dbHelper = DBHelper();

  Color getRandomColor(){
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  @override
  void initState() {
    getData();
    dbHelper = DBHelper();
    super.initState();
  }

  void getData()async {
    data = await dbHelper.getCartData();
    // filteredData = data ;
    print(data.length);
  }

  // void onSearch(String searchText){
  //   setState(() {
  //     filteredData = data.where((note) => note.subtitle!.toLowerCase().contains(
  //         searchText.toLowerCase()) || note.title!.toLowerCase().contains(
  //         searchText.toLowerCase())).toList();
  //   });
  // }

  // void filterList(value) {
  //   setState(() {
  //     filteredData = data
  //         .where((text) => text.title!.toLowerCase().contains(value.toLowerCase())).toList();
  //   });}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Note",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {},
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800.withOpacity(.8),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.sort,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              // onChanged: (value){
              //   filterList(value);
              // },
              style: const TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  hintText: "Search notes ",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  fillColor: Colors.grey.shade800,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.transparent))),
            ),
            Expanded(
                child: FutureBuilder(
                  future: dbHelper.getCartData(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 30),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          //color: getRandomColor(),
                          margin: const EdgeInsets.only(bottom: 20),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListTile(
                              title: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => EditScreen()));
                                },
                                child: RichText(
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        text: "${data[index].title}\n",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            height: 1.8),
                                        children: [
                                          TextSpan(
                                              text: data[index].subtitle,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.5
                                              )
                                          )
                                        ]
                                    )),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'Edited: ${DateFormat.yMEd().add_jms().format(DateTime.parse(data[index].date))}',
                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey
                                  ),
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: ()  {
                                  setState((){
                                      dbHelper.delete(data[index].id);
                                    debugPrint(data.length.toString());
                                  });
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          ),
                        );
                      },
                    );

                  }
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskScreen()));
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
}
