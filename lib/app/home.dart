import 'package:flutter/material.dart';
import 'package:note_app_with_php/app/constant/linkapi.dart';
import 'package:note_app_with_php/app/model/note_model.dart';
import 'package:note_app_with_php/app/notes/editnote.dart';
import 'package:note_app_with_php/main.dart';

import 'component/crud.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HoemState();
}

class _HoemState extends State<Home> {
  Crud crud = Crud();
  ModelNote model = ModelNote();

  getNotes() async {
    var respons =
        await crud.postReques(linkViewNote, {"id": sharedpref.getString('id')});
    return respons;
  }

  Stream<List<dynamic>> getNotesStream() async* {
    while (true) {
      var respons = await crud
          .postReques(linkViewNote, {"id": sharedpref.getString('id')});
      yield [respons]; // Wrap the response in a list
      await Future.delayed(
          const Duration(seconds: 1)); // Delay before fetching data again
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                sharedpref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: ListView(
        children: [
          // FutureBuilder(
          //   future: getNotes(),
          //   builder: (context, AsyncSnapshot snapshot) {
          //     if (snapshot.hasData) {
          //       if (snapshot.data['status'] == "failed") {
          //         return const Center(
          //           child: Text("there is no data"),
          //         );
          //       }
          //       return ListView.builder(
          //           shrinkWrap: true,
          //           physics: const NeverScrollableScrollPhysics(),
          //           itemCount: snapshot.data['data'].length,
          //           itemBuilder: (context, index) {
          //             model = ModelNote.fromJson(snapshot.data['data'][index]);
          //             return InkWell(
          //               onTap: () {
          //                 Navigator.of(context).push(MaterialPageRoute(
          //                     builder: (context) => EditNote(
          //                           note: snapshot.data['data'][index],
          //                         )));
          //               },
          //               child: Card(
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   children: [
          //                     Expanded(
          //                         flex: 1,
          //                         child: Image.network(
          //                           "$linkImageRoot/${model.noteImage}",
          //                           width: 100,
          //                           height: 100,
          //                           fit: BoxFit.cover,
          //                         )),
          //                     Expanded(
          //                       flex: 2,
          //                       child: ListTile(
          //                         trailing: IconButton(
          //                             onPressed: () async {
          //                               try {
          //                                 var respos = await crud
          //                                     .postReques(linkDeleteNote, {
          //                                   "noteId": snapshot.data['data']
          //                                           [index]['noteId']
          //                                       .toString(),
          //                                 });
          //                                 if (respos['status'] == "success") {
          //                                   Navigator.of(context)
          //                                       .pushReplacementNamed("home");
          //                                 }
          //                               } catch (e) {}
          //                             },
          //                             icon: const Icon(Icons.delete)),
          //                         title: Text(model.noteTitle!),
          //                         subtitle: Text(model.noteContent!),
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //               ),
          //             );
          //           });
          //     }
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }

          //     return const Center(
          //       child: Text("loading ....."),
          //     );
          //   },
          // )
          StreamBuilder<List<dynamic>>(
            stream: getNotesStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data![0]['status'] == "failed") {
                  return const Center(
                    child: Text("there is no data"),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data![0]['data'].length,
                  itemBuilder: (context, index) {
                    model =
                        ModelNote.fromJson(snapshot.data![0]['data'][index]);
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditNote(
                            note: snapshot.data![0]['data'][index],
                          ),
                        ));
                      },
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.network(
                                "$linkImageRoot/${model.noteImage}",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: ListTile(
                                trailing: IconButton(
                                  onPressed: () async {
                                    try {
                                      var respos = await crud
                                          .postReques(linkDeleteNote, {
                                        "noteId": snapshot.data![0]['data']
                                                [index]['noteId']
                                            .toString(),
                                        "imageName": snapshot.data![0]['data']
                                                [index]['noteImage']
                                            .toString(),
                                      });
                                      if (respos['status'] == "success") {
                                        Navigator.of(context)
                                            .pushReplacementNamed("home");
                                      }
                                    } catch (e) {}
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                                title: Text(model.noteTitle!),
                                subtitle: Text(model.noteContent!),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return const Center(
                child: Text("loading ....."),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addNote");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
