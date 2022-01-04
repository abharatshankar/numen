import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:numen_health/detail_movie_page.dart';
import 'package:numen_health/movies_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MoviesModel>? moviesResponse = [];
  List<MoviesModel>? searchresult = [];
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSearching = false;
    apidata();
  }

  void searchOperation(String searchText) {
    searchresult?.clear();
    if (_isSearching != null) {
      for (int i = 0; i < (moviesResponse?.length ?? 0); i++) {
        MoviesModel data = moviesResponse![i];
        if (data.title!.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult?.add(data);
        }
      }
      _isSearching = true;
    }

    setState(() {});
  }

  void _handleSearchEnd() {
    setState(() {
      _isSearching = false;
      _controller.clear();
    });
  }

  apidata() async {
    moviesResponse = await apiCall();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.white),
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.white)),
          onChanged: searchOperation,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.sort,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
              _handleSearchEnd();
              moviesResponse!.sort((a, b) =>
                  a.title!.toLowerCase().compareTo(b.title!.toLowerCase()));
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: (moviesResponse?.length ?? 0) != 0
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: _isSearching
                    ? (searchresult?.length ?? 0)
                    : moviesResponse?.length ?? 0,
                itemBuilder: (context, index) {
                  String? imageTodisplay = _isSearching
                      ? (searchresult![index].poster)
                      : moviesResponse![index].poster;
                  // var imageWidget =
                  //     Image.network(imageTodisplay!) != null
                  //         ? Image.network(imageTodisplay)
                  //         : SizedBox(
                  //             height: 30,
                  //             width: 30,
                  //           );
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailPage(
                                imagesArr: moviesResponse?[index].images ?? [],
                              )));
                    },
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                          leading: SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.network(
                              imageTodisplay!,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return const Text('no img');
                              },
                            ),
                            // child: Image.network(imageTodisplay!),
                          ),
                          title: _isSearching
                              ? Text(
                                  searchresult?[index].title.toString() ?? '')
                              : (Text(moviesResponse?[index].title.toString() ??
                                  ''))),
                    ),
                  );
                },
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
    );
  }

  Widget loadImage(int index) {
    return Container(
      height: 20,
      width: 20,
      child: Image.network(
        moviesResponse?[index].poster ?? '',
        fit: BoxFit.fill,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return const Text('Your error widget...');
        },
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return const SizedBox(
              height: 10,
              width: 10,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          }
        },
      ),
    );
  }

  Future<List<MoviesModel>> apiCall() async {
    // Await the http get response, then decode the json-formatted response.

    final response = await http.get(Uri.parse(
        'https://gist.githubusercontent.com/saniyusuf/406b843afdfb9c6a86e25753fe2761f4/raw/523c324c7fcc36efab8224f9ebb7556c09b69a14/Film.JSON'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((job) => MoviesModel.fromJson(job)).toList();
    } else {
      return [];
    }
  }
}
