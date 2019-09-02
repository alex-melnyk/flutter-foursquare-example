import 'BlocProvider.dart';
import 'FSPlacesBloc.dart';

class ApplicationBloc extends BlocBase {
  static ApplicationBloc _singleton;

  factory ApplicationBloc() {
    return _singleton ??= ApplicationBloc._internal();
  }

  ApplicationBloc._internal() {
    fsBloc = FSPlacesBloc();
  }

  FSPlacesBloc fsBloc;

  @override
  void dispose() {}
}
