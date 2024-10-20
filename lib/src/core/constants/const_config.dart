class ConstConfig {
  static const String appName = "TMDP APP";
  static int cacheListSize = 20;

  static String imagesBase(String imagePath) {
    return "https://image.tmdb.org/t/p/w500$imagePath";
  }

  static String posterVideoBase(int videoKey) {
    return "https://www.youtube.com/watch?v=$videoKey";
  }
}
