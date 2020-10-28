import 'package:flutter/material.dart';
import 'package:flutter_app/inheritannce/NotesInherited.dart';
import 'package:flutter_app/views/NoteList.dart';
import 'package:flutter_app/views/Notes.dart';

void main() => runApp(App());

class App extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return NotesInherited(
       MaterialApp(
         //to maintain state
          debugShowCheckedModeBanner: false,
          title: 'Notes',
          home: NoteList(),
        ),
    );
  }
}

