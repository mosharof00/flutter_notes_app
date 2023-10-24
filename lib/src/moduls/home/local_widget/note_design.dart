import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/src/moduls/edit/view/edit.dart';

class NoteDesign extends StatelessWidget {
  final Color cardColor;
  final dynamic cardOnTap, deleteWork ;
  final String title, subTitle, dateAbdTime;
  const NoteDesign({
    super.key,
    required this.cardColor,
    required this.cardOnTap,
    required this.title,
    required this.subTitle,
    required this.deleteWork,
    required this.dateAbdTime

  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          title: InkWell(
            onTap: cardOnTap,
            child: RichText(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: "${title}\n",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.8),
                    children: [
                      TextSpan(
                          text: subTitle,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal,
                              height: 1.5))
                    ])),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Edited: ${DateFormat.yMEd()
                  .add_jms()
                  .format(DateTime.parse(
                  dateAbdTime))}',
              style: const TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey),
            ),
          ),
          trailing: IconButton(
            onPressed: deleteWork,
            icon: const Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
