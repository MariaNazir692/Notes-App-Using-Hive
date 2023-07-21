import 'package:flutter/material.dart';
import 'package:notes_app/boxes/boxes.dart';
import 'package:notes_app/model/notes_model.dart';

class AddNotes extends StatelessWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController=TextEditingController();
    TextEditingController descController=TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
      ),
      body:Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Title"
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Description of note"
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              final data=NotesModel(title: titleController.text, description: descController.text);
              final box=Boxes.getData();
              box.add(data);
              data.save();
              titleController.clear();
              descController.clear();
              Navigator.pop(context);

            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: Colors.black,
              fixedSize: const Size(300, 40)
            ), child: const Text("Add Note",style: TextStyle(
              color: Colors.white
            ),),)

          ],
        ),
      ),
    );
  }
}
