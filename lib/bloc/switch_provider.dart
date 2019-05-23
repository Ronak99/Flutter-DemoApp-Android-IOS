class SwitchProvider {
  //couterProvider only consists of a counter and a method which is responsible for increasing the value of count
  bool isIOS = false;
  bool switchOS() => isIOS = !isIOS;
 
}
