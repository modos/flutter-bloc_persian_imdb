import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_imdb/controller/bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'my_card.dart';

class Home extends StatelessWidget {
  // This widget is the root of your application.
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
            child: MyHomePage(),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      }
      return MyCard();
    });
  }

  @override
  void dispose() {
    _movieBloc.close();
    super.dispose();
  }
}
