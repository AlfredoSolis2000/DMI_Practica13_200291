import 'package:flutter/material.dart';
import 'package:movieapp_200644/common/HttpHandler.dart';
import 'package:movieapp_200644/media_list.dart';
import 'package:movieapp_200644/common/MediaProvider.dart';
import 'package:movieapp_200644/model/Media.dart';

class Home extends StatefulWidget {
  const Home(
    {super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState(){
    _pageController = new PageController();
    super.initState();
  }

  @override
  void dispose(){
    _pageController?.dispose();
    super.dispose();
  }

  final MediaProvider movieProvider = new MediaPrvider();
  final MediaProvider showProvider = new ShowProvider();
  PageController? _pageController;
  int _page = 0;

  MediaType mediaType = MediaType.movie;
  final TextStyle customTextStyle = TextStyle(
    fontFamily: 'AmaticSC',
    fontSize: 16.0,
    fontWeight: FontWeight
        .bold,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MovieApp-200291"),
        titleTextStyle: TextStyle(fontFamily: 'MontserratAlternates'),
        backgroundColor: Color.fromARGB(255, 159, 41, 189),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
            },
          ),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(children: <Widget>[
          new DrawerHeader(
            child: Center(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/movie.jpg'), fit: BoxFit.cover)),
          ),
          new ListTile(
            title: new Text(
              "Peliculas",
              style:
                  customTextStyle,
            ),
            selected: mediaType == MediaType.movie,
            trailing: new Icon(Icons.local_movies),
            onTap: () {
              _changeMediaType(MediaType.movie);
              Navigator.of(context).pop();
            },
          ),
          new Divider(
            height: 5.0,
          ),
          new ListTile(
            title: new Text(
              "Television",
              style:
                  customTextStyle,
            ),
            trailing: new Icon(
                Icons.live_tv),
            onTap: () {
              _changeMediaType(MediaType.show);
              Navigator.of(context).pop();
            },
          ),
          new Divider(
            height: 5.0,
          ),
          new ListTile(
            title: new Text(
              "Cerrar",
              style:
                  customTextStyle,
            ),
            trailing: new Icon(Icons.exit_to_app),

            onTap: () => Navigator.of(context)
                .pop(),
          ),
        ]),
      ),
      body: PageView(
        children: _getMediaList(),
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: _obtenerIconos(),
        onTap: _navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  List<BottomNavigationBarItem> _obtenerIconos() {
    return mediaType == MediaType.movie? [
      new BottomNavigationBarItem(
        icon: new Icon(Icons.thumb_up),
        label: ("Populares"),
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.update),
        label: ("Proximamente"),
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.star),
        label: ("Mejor valorados"),
      )
      ]:
      [
      new BottomNavigationBarItem(
        icon: new Icon(Icons.thumb_up),
        label: ("Populares"),
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.update),
        label: ("En el Aire")
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.star),
        label: ("Mejor valorados"),
      ),
    ];
  }

  void _changeMediaType(MediaType type) {
    if (mediaType != type) {
      setState(() {
        mediaType = type;
      });
    }
  }

  List<Widget> _getMediaList() {
    return (mediaType == MediaType.movie)
        ? <Widget>[
            new MediaList(movieProvider, "popular"),
            new MediaList(movieProvider, "upcoming"),
            new MediaList(movieProvider, "top_rated"),
          ]
        : <Widget>[
            new MediaList(showProvider, "popular"),
            new MediaList(showProvider, "on_the_air"),
            new MediaList(showProvider, "top_rated"),
          ];
  }

  void _navigationTapped(int page) {
    _pageController?.animateToPage(page,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

}
