import '../forecastfetcher.dart';
import 'dart:html';

void main() {
  ForecastFetcher fetcher = new ForecastFetcher();
  fetcher.forecastByTimePeriod.then(_showForecast);
}

void _showForecast(Map<String, String> forecastByTimePeriod) {
  forecastByTimePeriod.forEach((String timePeriod, String forecast) {
    Element timePeriodHeaderEl = document.createElement('header');
    timePeriodHeaderEl.text = timePeriod;
    
    Element forecastEl = document.createElement('p');
    forecastEl.text = forecast;
    
    Element forecastSectionEl = document.createElement('section');
    forecastSectionEl.append(timePeriodHeaderEl);
    forecastSectionEl.append(forecastEl);
    
    document.body.append(forecastSectionEl);
  });
}