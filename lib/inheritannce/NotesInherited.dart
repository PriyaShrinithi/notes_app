import 'package:flutter/cupertino.dart';

class NotesInherited extends InheritedWidget
{
  final note = [
    {
      'title':'ABC',
      'text': 'DEF'
    },
    {
      'title':'GHI',
      'text': 'JKL'
    },
    {
      'title':'MNO',
      'text': 'PQR?'
    }
  ];

  NotesInherited(Widget child) : super(child: child); //what is this?

  static NotesInherited of(BuildContext context) => context.dependOnInheritedWidgetOfExactType();
  //what is this?

  @override
  bool updateShouldNotify(NotesInherited oldWidget) => oldWidget.note != note;
  //notiies true only if old and new notes are different
}