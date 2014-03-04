import 'package:petitparser/petitparser.dart';
import 'package:petitparser/xml.dart';

class FeedParser {
  static final RegExp _MULTIPLE_SPACES_RE = new RegExp(r'(\s{2,})');
  
  static Map<String, String> parse(String xml) {
    XmlParser parser = new XmlParser();
    Result result = parser.parse(xml);
    if (!(result.value is XmlDocument)) {
      return new Map();
    }
    XmlDocument doc = result.value;
    XmlElement dwml = doc.children[1];
    assert(dwml.name.toString() == 'dwml');
    XmlElement forecastDataEl = dwml.children.firstWhere(_isForecastDataEl);
    
    Map<String, List<String>> periodNamesByLayoutKey = new Map();
    forecastDataEl.children.where(_isTimeLayoutEl).forEach((XmlElement timeLayoutEl) {
      String layoutKey = timeLayoutEl.children.firstWhere(_isLayoutKeyEl).firstChild.toString();
      Iterable<String> periodNames = timeLayoutEl.children.where(_isStartValidTimeEl).map((XmlElement startValidTimeEl) {
        return startValidTimeEl.getAttribute('period-name');
      });
      periodNamesByLayoutKey[layoutKey] = periodNames;
    });
    
    XmlElement parametersEl = forecastDataEl.children.firstWhere(_isParametersEl);
    
    XmlElement wordedForecastElement = parametersEl.children.firstWhere(_isWordedForecastEl);
    String layoutKey = wordedForecastElement.getAttribute('time-layout');
    Iterable<String> periodNames = periodNamesByLayoutKey[layoutKey];
    Map<String, String> forecastByPeriodName = new Map();
    int i = 0;
    wordedForecastElement.children.forEach((XmlNode node) {
      if (!(node is XmlElement)) {
        return;
      }
      XmlElement element = node;
      if (element.name.toString() != 'text') {
        return;
      }
      String forecast = element.firstChild.toString().replaceAll(_MULTIPLE_SPACES_RE, ' ');
      String periodName = periodNames.elementAt(i);
      forecastByPeriodName[periodName] = forecast;
      i++;
    });
    return forecastByPeriodName;
  }

  
  static bool _isElementName(XmlNode node, String name) {
    if (!(node is XmlElement)) {
      return false;
    }
    XmlElement element = node;
    return element.name.toString() == name;    
  }
  
  static bool _isForecastDataEl(XmlNode node) {
    if (!(node is XmlElement)) {
      return false;
    }
    XmlElement element = node;
    return element.name.toString() == 'data' &&
        element.getAttribute('type') == 'forecast';
  }
  
  static bool _isTimeLayoutEl(XmlNode node) {
    return _isElementName(node,'time-layout');
  }
  
  static bool _isParametersEl(XmlNode node) {
    return _isElementName(node, 'parameters');
  }
  
  static bool _isWordedForecastEl(XmlNode node) {
    return _isElementName(node, 'wordedForecast');
  }
  
  static bool _isLayoutKeyEl(XmlNode node) {
    return _isElementName(node, 'layout-key');
  }
  
  static bool _isStartValidTimeEl(XmlNode node) {
    return _isElementName(node, 'start-valid-time');
  }
}