import 'package:unittest/unittest.dart';
import '../feedparser.dart';

import 'dart:io';

void testParseFeed() {
  File file = new File('resources/feed.xml');
  Map<String, String> forecastByDay = FeedParser.parse(file.readAsStringSync());
  expect(forecastByDay['Tonight'], 'S wind 11 to 13 kt. A slight chance of rain before 4am. W swell 6 to 7 ft at 12 seconds. Wind waves around 1 ft.');
  expect(forecastByDay['Monday'], 'S wind 11 to 15 kt. Rain likely after 10am. W swell 3 to 5 ft at 12 seconds building to at 19 seconds . Wind waves 1 to 2 ft.');
  expect(forecastByDay['Monday Night'], 'S wind 8 to 18 kt becoming W after midnight. Rain likely, mainly before 10pm. W swell 7 ft at 18 seconds. Wind waves 1 to 2 ft.');
  expect(forecastByDay['Tuesday'], 'Variable winds 5 kt or less. Partly sunny. W swell 7 to 8 ft. Wind waves around 1 ft.');
  expect(forecastByDay['Tuesday Night'], 'Variable winds 5 kt or less. Mostly cloudy. W swell 6 to 8 ft. Wind waves around 1 ft.');
  expect(forecastByDay['Wednesday'], 'SE wind around 6 kt becoming S in the morning. A chance of rain. W swell 5 to 6 ft. Wind waves around 1 ft.');
  expect(forecastByDay['Wednesday Night'], 'S wind 8 to 12 kt. Rain, mainly before 4am. W swell 7 ft. Wind waves around 1 ft.');
  expect(forecastByDay['Thursday'], 'SW wind 5 to 8 kt becoming variable and less than 5 kt in the morning. A slight chance of showers. W swell 9 ft. Wind waves around 1 ft.');
  expect(forecastByDay['Thursday Night'], 'NW wind 7 to 9 kt. Partly cloudy. W swell 9 ft. Wind waves around 1 ft.');
}

// TODO: Test graceful handling of malformed feeds.

void main() {
  test('parse feed', testParseFeed);
}