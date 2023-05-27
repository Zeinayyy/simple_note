import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_note/db/database_services.dart';
import 'package:simple_note/extension/format_date.dart';
import 'package:simple_note/models/note.dart';
import 'package:simple_note/utils/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService dbService = DatabaseService();

  final GlobalKey<ScaffoldState> _sKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sKey,
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
                return Dismissible(
                  key: Key(currentNote.key.toString()),
                  onDismissed: (_) async {
                    dbService.deleteNote(currentNote).then((value) {
                      ScaffoldMessenger.of(_sKey.currentContext!).showSnackBar(
                          const SnackBar(content: Text("Catatan Dihapus")));
                    });
                  },
                  child: NoteCard(note: currentNote),
                );
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
        onTap: () {
          GoRouter.of(context).pushNamed(
            AppRoutes.editNote,
            extra: note,
          );
        },
        title: Text(
          note.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          note.desc,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          'dijien ayeuna :\n${note.createdAt.formatDate()}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
