# tmdp_movie_app

A Flutter App to discover the movies database on the The Movies Database.

## Setup
- You only need to create the api secret file containing the api key as following:
  1. Create a file named "api_keys.dart" in the path '/lib/.secrets'.
  2. Add the Variable "tmdbApiKey" with your API key to TMDB site.
  3. Run/Build the app.

## App Structure and Features
- Bloc for state management.
- View movie sections on home screen of 3 movie categories.
- Refresh indicator with different Api response errors and states handling.
- Network feature for managing every single request from one place.
- preparations for future localizations support.
- App dark theme mode support.
- View all category movies.
- Offline caching for loaded movies data, images and latest opened movie using hydrated bloc and Cached network image.
- Movie trailers links to youtube from the app.
- Performance optimized with bloc widgets and data handling.


## TODO
- Unit tests.
- Favourite movies.
- Movies search.