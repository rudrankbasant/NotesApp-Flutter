import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/providers/notes_provider.dart';
import 'package:provider/provider.dart';

import 'add_new_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   String searchQuery = "";

  @override
  Widget build(BuildContext context) {
  NotesProvider notesProvider = Provider.of<NotesProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
      ),
      body: (notesProvider.isLoading == false) ? SafeArea(
        child:(notesProvider.notes.isNotEmpty) ? ListView(
          children: [
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            (notesProvider.getFilteredNotes(searchQuery).isNotEmpty) ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: notesProvider.getFilteredNotes(searchQuery).length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => AddNewNote(isUpdate: true, note: notesProvider.getFilteredNotes(searchQuery)[index],)));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D1E33) ,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(notesProvider.getFilteredNotes(searchQuery)[index].title.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(notesProvider.getFilteredNotes(searchQuery)[index].content.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                            ),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
            }) : const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(child: Text('No Notes Found')),
            ),
          ],
        ) : const Center(child: Text('No Notes Found')),
      ) : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: true,
                builder: (context) => const AddNewNote(isUpdate: false,)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}