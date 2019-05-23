class CounterProvider {
  //couterProvider only consists of a counter and a method which is responsible for increasing the value of count
  static int count = 0;
  int increaseCount() => count++;
  int currentCount = count;
}
