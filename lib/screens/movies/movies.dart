import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_imdb/controller/bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class Movies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          backgroundColor: Color(0xFFf6f4e6),
          body: BlocProvider(
            create: (context) =>
                MovieBloc(httpClient: http.Client())..add(MovieFetched()),
            child: MoviesPage(),
          ),
        ));
  }
}

class MoviesPage extends StatefulWidget {
  MoviesPage({Key key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  MovieBloc _movieBloc;
  @override
  void initState() {
    _movieBloc = BlocProvider.of<MovieBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
      if (state is MovieInitial) {
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Color(0xFF52575d),
          ),
        );
      }
      if (state is MovieFailure) {
        return Center(
          child: Text('failed to fetch posts'),
        );
      }
      if (state is MovieSuccess) {
        if (state.movies.isEmpty) {
          return Center(
            child: Text('no posts'),
          );
        }
        return GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          mainAxisSpacing: 2,

          // Generate 100 widgets that display their index in the List.
          children: List.generate(state.movies.length, (index) {
            print(state.movies[index].thumb);
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100.0,
                  height: 128,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(state.movies[index].thumb)),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.redAccent,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    state.movies[index].name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(state.movies[index].year.toString())
              ],
            );
          }),
        );
      }
    });
  }

  @override
  void dispose() {
    _movieBloc.close();
    super.dispose();
  }
}
