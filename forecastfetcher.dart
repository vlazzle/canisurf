import 'feedparser.dart';

import 'dart:io';
import 'dart:async';
import 'dart:convert';

class ForecastFetcher {
  final String _WEATHER_FEED_URL = 'http://forecast.weather.gov/MapClick.php?lat=37.74&lon=-122.65&FcstType=dwml';
  String _response = null;
  Future<Map> _forecastByTimePeriod = null;
  Future<String> _xml = null;
  
  Future<String> fetchXml() {
    if (null == _xml) {
      HttpClient http = new HttpClient();
      _xml = http.getUrl(Uri.parse(_WEATHER_FEED_URL)).
          then((HttpClientRequest request) => request.close()).
          then((HttpClientResponse response) {
            return response.transform(new Latin1Decoder()).join();
          });
      
    }
    return _xml;
  }
  
  Future<Map<String, String>> get forecastByTimePeriod {
    if (null == _forecastByTimePeriod) {
      _forecastByTimePeriod = fetchXml().then(FeedParser.parse);
    }
    return _forecastByTimePeriod;
  }
}