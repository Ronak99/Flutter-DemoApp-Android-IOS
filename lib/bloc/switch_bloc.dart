import 'switch_provider.dart';
import 'dart:async';

class SwitchBloc { // create a StreamController
  StreamController osController = StreamController();
  final SwitchProvider provider =
      SwitchProvider();
       // create an instance of our CounterProvider

  Stream get getOS =>
      osController.stream; // create a getter for our stream

  void switchOS() {
    provider
        .switchOS(); // call the method to increase our count in the provider
    osController.sink.add(provider.isIOS); // add the count to our sink
  }

  void dispose() {
    osController.close(); // close our StreamController
  }
}

final switchbloc = SwitchBloc(); // create an instance of the counter bloc
