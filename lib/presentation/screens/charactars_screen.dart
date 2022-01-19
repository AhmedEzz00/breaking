import '../../business%20logic/cubit/characters_cubit.dart';
import '../../constants/colors.dart';
import '../../data/models/charachers.dart';
import '../widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactarsScreen extends StatefulWidget {
  const CharactarsScreen({Key? key}) : super(key: key);

  @override
  State<CharactarsScreen> createState() => _CharactarsScreenState();
}

class _CharactarsScreenState extends State<CharactarsScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.grey,
          ),
        )
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearching,
            icon: const Icon(
              Icons.search,
              color: MyColors.grey,
            ))
      ];
    }
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.grey,
      decoration: const InputDecoration(
        hintText: 'Find a character',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.grey,
          fontSize: 17,
        ),
      ),
      style: const TextStyle(
        color: MyColors.grey,
        fontSize: 17,
      ),
      onChanged: (searchedCharacter) {
        addSearchedItemsToSearchedList(searchedCharacter);
      },
    );
  }

  Widget _buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = state.characters;
          return _buildLoadedListWidgets();
        } else {
          return _showLoadingIndicator();
        }
      },
    );
  }

  Widget _buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.grey,
        child: Column(
          children: [
            _buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCharactersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty
            ? allCharacters.length
            : searchedForCharacters.length,
        itemBuilder: (context, index) {
          return CharacterItem(
            character: _searchTextController.text.isEmpty
                ? allCharacters[index]
                : searchedForCharacters[index],
          );
        });
  }

  Widget _showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: MyColors.yellow,
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'characters',
      style: TextStyle(color: MyColors.grey),
    );
  }

  Widget _buildNoInternetWidget() {
    return Center(
      child: Container(
        color: MyColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text('Can\'t connect to internet',
                style: TextStyle(fontSize: 22, color: MyColors.grey)),
            Image.asset('assets/images/offline.png')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.yellow,
          leading: _isSearching
              ? const BackButton(
                  color: MyColors.grey,
                )
              : Container(),
          title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
          actions: _buildAppBarActions(),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return _buildBlocWidget();
            } else {
              return _buildNoInternetWidget();
            }
          },
          child: _showLoadingIndicator(),
        ),
        );
  }

  void addSearchedItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where((element) =>
            element.name!.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  void _startSearching() {
    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(onRemove: _stopSearching),
    );
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
}
