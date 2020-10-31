import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/inheritannce/NotesInherited.dart';
import 'package:flutter_app/providers/NoteProvider.dart';
import 'package:flutter_app/views/Notes.dart';

class NoteList extends StatefulWidget
{
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  //List<Map<String, String>> get _note => NotesInherited.of(context).note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Notes'),
      ),
      body: FutureBuilder(
        future: NoteProvider.getNoteList(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            final note = snapshot.data;
          return ListView.builder(
          //to display widgets dynamically
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notes(NoteMode.edit, note[index]))
              );
                setState(() {});
              },
              child: new Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 8.0, right: 8.0),
                  child: Column( //column is a multi child widget: allows creating many widgets
                    // to align vertically: use crossaxisalignment
                    crossAxisAlignment: CrossAxisAlignment.center, // start brings the text to the left most corner
                    children: <Widget>[
                      NoteTitle(note[index]['title']),
                      Container(height: 12.0,),
                      NoteText(note[index]['text'])
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: note.length,
        );
        }
          return Center(child: CircularProgressIndicator());
      }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Notes(NoteMode.create, null),),
          );
          setState(() {});
        },
        child: Icon(Icons.create),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}

class NoteTitle extends StatelessWidget
{
  final String _title;
  NoteTitle(this._title);

  @override
  Widget build(BuildContext context)
  {
    return Text(
      _title,
      style: TextStyle(
        fontSize: 25,
      ),
    );
  }
}

class NoteText extends StatelessWidget
{
  final String _text;
  NoteText(this._text);

  @override
  Widget build(BuildContext context)
  {
    return Text(
      _text,
      style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade500 //for a darker shade of grey
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis, // to symbolise there's more inside
    );
  }
}