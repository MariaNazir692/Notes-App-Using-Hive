import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/boxes/boxes.dart';
import 'package:notes_app/model/add_note.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:notes_app/repository/hive_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            itemCount: box.length,
            reverse: true,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 100,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              data[index].title.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  HiveServices().Delete(data[index]);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                            IconButton(
                                onPressed: () {
                                  _showEditDialog(
                                      data[index],
                                      data[index].title,
                                      data[index].description);
                                },
                                icon: const Icon(Icons.edit))
                          ],
                        ),
                        Text(data[index].description.toString()),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        //the listenable will listen all the changes occur in object either it is updating or deleting
        valueListenable: Boxes.getData().listenable(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNotes()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(
      NotesModel notesModel, String title, String description) {
    titleController.text = title;
    descController.text = description;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit notes'),
          content: SingleChildScrollView(
              child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter Title"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Description of note"),
              ),
            ],
          )),
          actions:[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                HiveServices().EditNote(
                    notesModel: notesModel,
                    title: titleController.text.toString(),
                    desc: descController.text.toString());
                descController.clear();
                titleController.clear();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
