import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        GoRouter.of(context).pushNamed('add-note');
      }, child: Icon(Icons.note_add),),
      appBar: AppBar(
        title: const Text("Note Urang"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NoteCard(),
          ],
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text("Judul aonnya"),
        subtitle: Text("Deskripsi"),
        trailing: Text("dijien ayeuna : 01-02-1778"),
      ),
    );
  }
}