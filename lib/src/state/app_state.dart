import "package:doodlebob_client/src/utilities/debounce.dart";
import "package:english_words/english_words.dart";
import "package:flutter/material.dart";

import "../entities/label_data.dart";
import "../schemata/notes.dart";
import "../schemata/users.dart";

List<LabelData> generateDummyLabels() {
  return const [
    LabelData(id: 1, name: "App idea"),
    LabelData(id: 2, name: "Birthday"),
    LabelData(id: 3, name: "Cat"),
    LabelData(id: 4, name: "Dog"),
    LabelData(id: 5, name: "Gift"),
    LabelData(id: 6, name: "Memory"),
    LabelData(id: 7, name: "Mom"),
    LabelData(id: 8, name: "Music"),
    LabelData(id: 9, name: "Names"),
    LabelData(id: 10, name: "Song"),
    LabelData(id: 11, name: "TODO"),
    LabelData(id: 12, name: "Writing"),
    LabelData(id: 13, name: "Thoughts"),
    LabelData(id: 14, name: "Band name"),
    LabelData(id: 15, name: "Aliens"),
    LabelData(id: 16, name: "Medicine"),
    LabelData(id: 17, name: "Build"),
  ];
}

List<NoteResource> generateDummyNotes() {
  return const [
    (
      id: "e8521a7c-32f3-4340-9fbb-769a0713f620",
      type: "notes",
      attributes: (
        title: "",
        body: "feed cat",
        createdAt: "2023-06-02T16:55:59.365Z",
        updatedAt: "2023-06-02T17:50:10.098Z"
      ),
      relationships: null,
    ),
    (
      id: "cc300e2b-3b7c-4353-a851-f59accf59a8e",
      type: "notes",
      attributes: (
        title: "",
        body: "clothes for cat",
        createdAt: "2023-05-24T19:43:25.293Z",
        updatedAt: "2023-05-24T19:43:25.293Z"
      ),
      relationships: null,
    ),
    (
      id: "350d2332-5311-48e8-b341-5b595ccfa834",
      type: "notes",
      attributes: (
        title: "stuck in my head",
        body: "up your butt and around the corner...",
        createdAt: "2023-05-20T15:08:11.558Z",
        updatedAt: "2023-05-22T02:01:56.003Z"
      ),
      relationships: null,
    ),
    (
      id: "b5f11d7c-cb4e-4b74-8daa-9b9ce35e3f7c",
      type: "notes",
      attributes: (
        title: "",
        body: "get gift for cat",
        createdAt: "2023-05-02T08:20:51.480Z",
        updatedAt: "2023-05-02T08:20:51.480Z"
      ),
      relationships: null,
    ),
    (
      id: "8b25cab8-1a78-48a4-a73e-8446a7efb0a7",
      type: "notes",
      attributes: (
        title: "genius piece I wrote last night",
        body: "there's a place in france where the naked ladies dance...",
        createdAt: "2023-04-27T04:54:08.144Z",
        updatedAt: "2023-04-27T04:54:08.144Z"
      ),
      relationships: null,
    ),
    (
      id: "3af2dac6-f08f-4ddb-be75-404d1f538efe",
      type: "notes",
      attributes: (
        title: "",
        body: "cat translator",
        createdAt: "2023-03-11T03:16:42.936Z",
        updatedAt: "2023-03-11T03:16:42.936Z"
      ),
      relationships: null,
    ),
    (
      id: "db59bb6f-0bd8-4172-be4d-28a179ca9017",
      type: "notes",
      attributes: (
        title: "",
        body: "cat name: dog (mom's idea)",
        createdAt: "2023-02-06T12:27:27.727Z",
        updatedAt: "2023-02-06T12:27:27.727Z"
      ),
      relationships: null,
    ),
    (
      id: "91741fe7-7ca1-4b9d-8588-ba48cd1099c5",
      type: "notes",
      attributes: (
        title: "get vet for dog (cat)",
        body: "",
        createdAt: "2023-02-05T07:59:53.079Z",
        updatedAt: "2023-02-05T07:59:53.079Z"
      ),
      relationships: null,
    ),
    (
      id: "e95a7248-e373-4538-ae63-423ab4eafc3b",
      type: "notes",
      attributes: (
        title: "",
        body: "cat obedience school",
        createdAt: "2023-01-13T20:32:23.602Z",
        updatedAt: "2023-01-13T20:32:23.602Z"
      ),
      relationships: null,
    ),
    (
      id: "1a961420-369c-44f7-b42e-09dda766c016",
      type: "notes",
      attributes: (
        title: "inspired story",
        body: "there once was a man from nantucket...",
        createdAt: "2023-01-09T11:21:32.811Z",
        updatedAt: "2023-01-09T11:22:01.991Z"
      ),
      relationships: null,
    )
  ];
}

// TODO: split into different responsibilities
class AppState extends ChangeNotifier {
  var wordPair = WordPair.random();
  var favorites = <WordPair>[];
  var searchText = "";
  var currentDestinationIndex = 0;
  LabelData? currentLabel;
  UserResource? currentUser;
  NoteResource? currentNote;

  // TODO: remove test data
  var labels = generateDummyLabels();
  // var labels = <LabelData>[];

  // TODO: remove test data
  // var notes = generateDummyNotes();
  var notes = <NoteResource>[];

  // List<List<NoteResource>>? _noteColumns;

  late final _searchDebounced = Debounce(const Duration(milliseconds: 500), () {
    print(searchText);
  });

  void generateNewWordPair() {
    wordPair = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(wordPair)) {
      favorites.remove(wordPair);
    } else {
      favorites.add(wordPair);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair favorite) {
    favorites.remove(favorite);
    notifyListeners();
  }

  void updateSearchText(String value) {
    searchText = value;
    _searchDebounced();
    notifyListeners();
  }

  void cancelSearch() {
    _searchDebounced.cancel();
  }

  void setLabels(List<LabelData> values) {
    labels = values;
    notifyListeners();
  }

  void addLabel(LabelData value) {
    labels.add(value);
    notifyListeners();
  }

  void addLabels(List<LabelData> values) {
    labels.addAll(values);
    notifyListeners();
  }

  void setNotes(List<NoteResource> values) {
    notes = values;
    currentLabel = null;
    notifyListeners();
  }

  void setNotesByLabel(List<NoteResource> values, LabelData label) {
    notes = values;
    currentLabel = label;
    notifyListeners();
  }

  void addNote(NoteResource value) {
    notes.add(value);
    notifyListeners();
  }

  void addNotes(List<NoteResource> values) {
    notes.addAll(values);
    notifyListeners();
  }

  void setCurrentDestinationIndex(int selectedIndex) {
    currentDestinationIndex = selectedIndex;
    notifyListeners();
  }

  void setCurrentNote(NoteResource selectedNote) {
    currentNote = selectedNote;
    notifyListeners();
  }

  // /// Structure the flat [notes] list into columns (memoized for consecutive
  // /// equal [columnCount] values).
  // List<List<NoteResource>> columnizeNotes(int columnCount) {
  //   var prevCols = _noteColumns;
  //   if (prevCols != null && prevCols.length == columnCount) return prevCols;

  //   var newCols = columnize(notes, columnCount);
  //   _noteColumns = newCols;
  //   return newCols;
  // }

  IconData get currentFavoriteIcon {
    return favorites.contains(wordPair)
        ? Icons.favorite
        : Icons.favorite_border;
  }
}
