import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_note/model/note.dart';
import 'package:simple_note/services/database_service.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({
    super.key,
    this.note,
  });
  final Note? note;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final DatabaseService dbService = DatabaseService();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descController = TextEditingController();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descController.text = widget.note!.description;
    }
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
      appBar: AppBar(
        title: Text(
          widget.note != null ? "Edit Note" : "Add New Note",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Judul harap diisi";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: 'Masukkan Judul',
                    hintStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                TextFormField(
                  maxLines: 100,
                  controller: _descController,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Deskripsi harap diisi";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Tulis Note Anda Disini',
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_formkey.currentState!.validate()) {
            Note tempNote = Note(
              _titleController.text,
              _descController.text,
              DateTime.now(),
            );
            if (widget.note != null) {
              await dbService.editNote(widget.note!.key, tempNote);
            } else {
              await dbService.addNote(tempNote);
            }
            if (!mounted) return;
            GoRouter.of(context).pop();
          }
        },
        label: const Text("Simpan"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
