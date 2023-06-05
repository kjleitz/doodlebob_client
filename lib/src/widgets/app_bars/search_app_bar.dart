import "package:flutter/material.dart";

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final void Function(String) onChanged;
  final String hintText;

  const SearchAppBar({
    super.key,
    required this.onChanged,
    this.hintText = "Search...",
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  final TextEditingController searchController = TextEditingController();

  var _searchFieldFocused = false;
  late FocusNode _searchFieldFocusNode;

  @override
  void initState() {
    super.initState();
    _searchFieldFocusNode = FocusNode();
    _searchFieldFocusNode.addListener(_handleSearchFieldFocusChange);
    _searchFieldFocused = _searchFieldFocusNode.hasFocus;
  }

  @override
  void dispose() {
    // TODO: implement. See doc text on `super.dispose()` for good tip on
    //  lifecycle management of `appState` object itself, too.
    // appState.cancelSearch();
    _searchFieldFocusNode.removeListener(_handleSearchFieldFocusChange);
    _searchFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: TextField(
        focusNode: _searchFieldFocusNode,
        controller: searchController,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
        onChanged: widget.onChanged,
        onTapOutside: (event) {
          // For some reason, unfocusing like this makes it so that any
          // future interaction with the app bar (like pressing the menu
          // button) re-focuses the text box...
          //
          //   FocusScope.of(context).unfocus();
          //
          // ...whereas this does not exhibit that behavior:
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
      actions: [
        _searchFieldFocused
            ? IconButton(
                key: const ValueKey("close"),
                onPressed: () {
                  print("search unfocused");
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                icon: const Icon(Icons.close),
              )
            : IconButton(
                key: const ValueKey("search"),
                onPressed: () {
                  print("search focused");
                  _searchFieldFocusNode.requestFocus();
                },
                icon: const Icon(Icons.search),
              ),
      ],
    );
  }

  void _handleSearchFieldFocusChange() {
    // final hasFocus = _searchFieldFocusNode.hasFocus;
    final hasFocus = _searchFieldFocusNode.hasPrimaryFocus;

    if (hasFocus != _searchFieldFocused) {
      setState(() {
        _searchFieldFocused = hasFocus;
      });
    }
  }
}
