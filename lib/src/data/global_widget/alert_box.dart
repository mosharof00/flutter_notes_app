// import 'package:flutter/material.dart';
//
// class AlertBox extends StatelessWidget {
//   const AlertBox({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//       return showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               backgroundColor: Colors.grey.shade900,
//               icon: const Icon(
//                 Icons.info,
//                 color: Colors.grey,
//               ),
//               title: const Text(
//                 "Are you sure you want to delete?",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.white),
//               ),
//               content: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ElevatedButton(
//                     onPressed: (){
//                       deleteNote(index);
//                       Navigator.pop(context);
//                     },
//                     style:
//                     ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                     child: const SizedBox(
//                         width: 60,
//                         child: Text(
//                           "Yes",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: Colors.white),
//                         )),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context, false);
//                     },
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                     child: const SizedBox(
//                         width: 60,
//                         child: Text(
//                           "no",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: Colors.white),
//                         )),
//                   )
//                 ],
//               ),
//             );
//           });
//     }
//   }
// }
