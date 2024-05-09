class URL {
  static const String base = 'https://conrev.in/CRV';
  //static const webServiceUrl = 'http://192.168.3.22:8090/webservice.asmx';
  static const webServiceUrl = 'http://122.165.67.146:8015/WebService.asmx';
  // static const webServiceUrl = 'http://122.165.67.146:8015/webservice.asmx';
  // 'http://122.165.67.146:8015/webservice.asmx';
  static const String oprprefix = 'BS';

  static const String login = base + '/api/login?';
  static const String getAllKeywords = base + "/api/getAllKeyword";
  static const String search = base + "/api/search?search=";
  static const String getSKbyKId = base + "/api/getSKbyKId/";
  static const String imageBase = base + "/public/upload/";
}

