import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app_with_php/app/component/custometext.dart';
import 'package:note_app_with_php/app/constant/linkapi.dart';

import '../component/crud.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key, this.note});
  final note;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> with Crud {
  File? file;
  TextEditingController noteTitle = TextEditingController();
  TextEditingController noteContent = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  EditNotes() async {
    try {
      var respons;
      if (formKey.currentState!.validate()) {
        if (file != null) {
          respons = await postRequestWithFile(linkEditNote, file!, {
            "noteTitle": noteTitle.text,
            "noteContent": noteContent.text,
            "noteId": widget.note['noteId'].toString(),
            "noteImage": widget.note['noteImage'].toString(),
          });
        } else {
          respons = await postReques(linkEditNote, {
            "noteTitle": noteTitle.text,
            "noteContent": noteContent.text,
            "noteId": widget.note['noteId'].toString(),
            "noteImage": widget.note['noteImage'].toString(),
          });
        }
        if (respons['status'] == "success") {
          Navigator.of(context).pushReplacementNamed("home");
          print(respons['status']);
        } else {
          print('there is problem');
        }
      } else {
        print('inter data');
      }
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    noteTitle.text = widget.note['noteTitle'];
    noteContent.text = widget.note['noteContent'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit notes"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              CustomInput(
                controller: noteTitle,
                label: '',
                hint: 'Note Title',
                valdate: (val) {
                  if (val!.isEmpty) {
                    return "please add note title ";
                  }
                  return null;
                },
              ),
              CustomInput(
                  controller: noteContent,
                  label: '',
                  hint: 'Note Content',
                  valdate: (val) {
                    if (val!.isEmpty) {
                      return "please add Content title ";
                    }
                    return null;
                  }),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('chose type of Image'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        XFile? xfile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera);
                                        file = File(xfile!.path);
                                      },
                                      child: const Icon(
                                          Icons.camera_alt_outlined)),
                                  ElevatedButton(
                                      onPressed: () async {
                                        XFile? xfile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        file = File(xfile!.path);
                                      },
                                      child: const Icon(Icons.image)),
                                ],
                              ),
                            ));
                  },
                  color: Colors.blueAccent,
                  child: const Text("upload Image "),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  await EditNotes();
                },
                color: Colors.blueAccent,
                child: const Text("Edit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
