import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          GoRouter.of(context).pop();
        },
        label: Text("Simp"),
        icon: const Icon(Icons.save),
      ),
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Judul Notna",
                    hintStyle:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                maxLines: 150,
                controller: _descController,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Deskripsina",
                    hintStyle: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
