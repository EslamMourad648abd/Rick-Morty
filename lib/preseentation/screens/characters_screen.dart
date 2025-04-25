import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/business_logic/cubit/characters_cubit.dart';
import 'package:untitled/constants/my_colors.dart';
import 'package:untitled/preseentation/screens/characters_details.dart';
import 'package:untitled/preseentation/widgets/character_item.dart';

import '../../data/models/characters.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  //late List<Characters> allCharacters;
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   allCharacters = BlocProvider.of<CharactersCubit>(context)
  //       .getAllCharacters()
  //       .cast<Characters>();
  // }

  late List<Character> allCharacters;

  late List<Character> searchForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildsearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: "Find a character",
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchCharacter) {
        addSearchedForItemsToSSearchedList(searchCharacter);
      },
    );
  }

  void addSearchedForItemsToSSearchedList(String searchCharacter) {
    searchForCharacters = allCharacters
        .where((character) =>
            character.Name.toLowerCase().startsWith(searchCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: MyColors.myGrey,
            ))
      ];
    } else {
      return [
        IconButton(
          icon: Icon(Icons.search, color: MyColors.myGrey),
          onPressed: _startSearch,
        )
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    allCharacters = [];
    searchForCharacters = [];
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = state.characters;
          print("State is CharactersLoaded, displaying list"); // Debugging
          return buildLoadedListWidget(state.characters);
          // allCharacters = (state).characters.cast<Characters>();
          // return buildLoadedListWidget();
        } else if (state is CharactersError) {
          return Center(child: Text("Error: ${state.message}"));
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidget(List<Character> characters) {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(characters),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList(List<Character> characters) {
    if (characters.isEmpty) {
      return Center(child: Text("No characters found"));
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          mainAxisExtent: 250),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty
          ? characters.length
          : searchForCharacters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context, // ✅ Used 'context' instead of 'ctx'
              MaterialPageRoute(
                builder: (context) => CharacterDetailsScreen(
                    character: character), // ✅ Corrected context
              ),
            );
          },
          child: CharacterItem(
            character: _searchTextController.text.isEmpty
                ? character
                : searchForCharacters[index],
            onTap: () {},
          ), // ✅ Removed unnecessary `onTap: () {}`
        );
      },
    );
  }

  Widget _buildAppBarTitle() {
    return Text("Characters", style: TextStyle(color: MyColors.myGrey));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: _isSearching ? _buildsearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: buildBlocWidget(),
    );
  }
}
