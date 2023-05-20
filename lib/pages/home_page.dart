import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_note/extension/format_date.dart';
import 'package:simple_note/models/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await GoRouter.of(context).pushNamed('add-note');
          setState(() {});
        },
        child: Icon(Icons.note_add),
      ),
      appBar: AppBar(
        title: const Text("Note Urang"),
        elevation: 0,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('notesBox').listenable(),
        builder: (context, box, child) {
          if (box.values.isEmpty) {
            return Center(
              child: Text("Eweuh Catatan"),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 5,
                );
              },
              itemCount: box.length,
              itemBuilder: (context, index) {
                Note currentNote = box.getAt(index);
                return NoteCard(note: currentNote);
              },
            );
          }
        },
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final Note note;
  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(note.desc),
        trailing: Text(
          'dijien ayeuna :\n${note.createdAt.formatDate()}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
