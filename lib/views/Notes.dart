import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/inheritannce/NotesInherited.dart';
import 'package:flutter_app/providers/NoteProvider.dart';
import 'packageflutter_app/views/NoteList.dart';

enum NoteMode
{
  //two modes of notes => create or edit
  create,
  edit
}

class Notes extends StatefulWidget
{
  final NoteMode mode;
  final Map<String, dynamic> _note;

  Notes(this.mode, this._note);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes>
{

  final titleControl = TextEditingController();
  final textControl = TextEditingController();

  //List<Map<String, String>> get _note => NotesInherited.of(context).note;

  @override
  void didChangeDependencies() //Called when a dependency of this State object changes
  {
    if(widget.mode == NoteMode.edit)
      {
        titleControl.text = widget._note['title'];
        textControl.text = widget._note['text'];
      }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
            widget.mode == NoteMode.create ? 'Add Note' : 'Edit Note'
        ),
        backgroundColor: Colors.purple,
      ),

      body: Padding(
        padding: const EdgeInsets.all(32.0),
          child: Column( //column is a multi child widget: allows creating many widgets
            children: <Widget>[
              TextField(
                controller: titleControl,
                decoration: InputDecoration(
                  hintText: 'Note Title...',
                ),
              ),
              Container(height: 8.0,),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: textControl,
                decoration: InputDecoration(hintText: 'Note Text...',

                ),
              ),
              Container(height: 80.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NoteButton('Save', Colors.indigo, (){

                     final title = titleControl.text;
                     final text = textControl.text;

                      if(widget?.mode == NoteMode.create)
                      {
                          NoteProvider.insertNote({
                            'title': title,
                            'text':text
                          });
                      }

                      else if(widget?.mode == NoteMode.edit)
                      {
                        NoteProvider.editNote({
                          'id': widget._note['id'],
                          'title': title,
                          'text': text
                        });
                      }
                      Navigator.pop(context);
                    }),

                  NoteButton('Discard', Colors.blueGrey, () {
                    Navigator.pop(context);
                  }),

                  if (widget.mode == NoteMode.edit)
                    NoteButton('Delete', Colors.red.shade700, () async {
                     await NoteProvider.deleteNote(widget._note['id']);
                      Navigator.pop(context);
                    }),
                ],
              ),
            ],
          ),
        ),
      );
  }
}

// ignore: must_be_immutable
class NoteButton extends StatelessWidget
{
  var color;

  var text;

  var _onPressed;

  NoteButton(this.text, this.color, this._onPressed);

  @override
  Widget build(BuildContext context) {

    return MaterialButton(
      onPressed: _onPressed,
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white
        ),
      ),
      color: color,
    );
  }
}