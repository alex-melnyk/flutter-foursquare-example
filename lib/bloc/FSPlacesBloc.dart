//import 'dart:convert';

//import 'package:http/http.dart' as http;
import 'package:foursquaretest/models/Place.dart';
import 'package:rxdart/rxdart.dart';

import 'BlocProvider.dart';

class FSPlacesBloc extends BlocBase {
  BehaviorSubject<List<Place>> _moviesController =
  BehaviorSubject<List<Place>>();

  Sink<List<Place>> get inPlaces => _moviesController.sink;

  Stream<List<Place>> get outPlaces => _moviesController.stream;

  Future<void> getPlaces(lat, lng) async {
    const clientId = '3IR3TIAZ4MUM3BZJBQYTJTRF1BKRX5WAX5GTWHDIFVXAGTPB';
    const clientSecret = 'PVBXZ1TUW4JQGC45VVQW3PQ10ZJ4SQBDWYE4Z2S05YPVMFVY';

    final reqUrl = 'https://api.foursquare.com/v2/venues/explore?client_id=$clientId&client_secret=$clientSecret&v=20180323&limit=1&ll=$lat,$lng';
    print('reqUrl: $reqUrl');

//    final resp = await http.get(reqUrl);
//    return List.from(json.decode(resp.body)['results']).map((d) => Movie.fromMap(d)).toList();
//
//    inMovies.add(await fetchMovies(MoviesCategories.MOVIES_NOW_PLAYING));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _moviesController.close();
  }
}
