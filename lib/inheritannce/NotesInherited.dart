import 'package:flutter/cupertino.dart';

class NotesInherited extends InheritedWidget
{
  final _note = [];

  NotesInherited(Widget child) : super(child: child); //what is this?

  static NotesInherited of(BuildContext context) => context.dependOnInheritedWidgetOfExactType();
  //what is this?

  @override
  bool updateShouldNotify(NotesInherited oldWidget) => oldWidget._note != _note;
  //notiies true only if old and new notes are different
}