import 'counter_provider.dart';
import 'dart:async';

class CounterBloc { // create a StreamController
  StreamController counterController = StreamController.broadcast();
  final CounterProvider provider =
      CounterProvider(); // create an instance of our CounterProvider

  Stream get getCount =>
      counterController.stream; // create a getter for our stream

  void updateCount() {
    provider
        .increaseCount(); // call the method to increase our count in the provider
    counterController.sink.add(CounterProvider.count); // add the count to our sink
  }

  void dispose() {
    counterController.close(); // close our StreamController
  }
}

final counterBloc = CounterBloc(); // create an instance of the counter bloc
