import 'package:flutter/material.dart';

import '../boxes/boxes.dart';
import '../model/notes_model.dart';

class HiveServices{

  Future<void> AddNote(String title, String description)async {
    final data=NotesModel(title: title, description: description);
    final box=Boxes.getData();
    box.add(data);
    data.save();
  }

  void EditNote({required NotesModel notesModel, required String title, required String desc }){
    notesModel.title=title;
    notesModel.description=desc;
    notesModel.save();
  }
  void Delete(NotesModel notesModel) {
    notesModel.delete();
  }
}