import 'package:unittest/unittest.dart';
import 'package:petitparser/petitparser.dart';
import 'package:petitparser/xml.dart';

import '../forecastfetcher.dart';

void testFetchXml() {
  // TODO This test will be flaky since it actually fetches a URL.
  ForecastFetcher fetcher = new ForecastFetcher();
  fetcher.fetchXml().then(expectAsync((String xml) {
    XmlParser parser = new XmlParser();
    Result result = parser.parse(xml);
    expect(result.isSuccess, true);
  }));
}

void testForecastByDay() {
  // TODO This test will be flaky since it actually fetches a URL.
  ForecastFetcher fetcher = new ForecastFetcher();
  fetcher.forecastByTimePeriod.then(expectAsync((Map<String, String> forecastByDay) {
    expect(forecastByDay.length > 0, true);
    expect(forecastByDay.keys.any((String timePeriod) {
      return timePeriod.contains(' Night');
    }), true);
  }));
}

void main() {
  test('fetchXml', testFetchXml);
  test('forecastByDay', testForecastByDay);
}