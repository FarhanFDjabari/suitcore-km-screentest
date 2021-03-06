class Environments {
  static const String PRODUCTION = 'http://panti.suitdev.com/api';
  static const String DEV = 'https://reqres.in/api';
}

class ConfigEnvironments {
  static const String _currentEnvironments = Environments.DEV;
  static const List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.DEV,
      'url': 'https://reqres.in/',
    },
    {
      'env': Environments.PRODUCTION,
      'url': 'http://panti.suitdev.com/',
    },
  ];

  static String? getEnvironments() {
    return _availableEnvironments
        .firstWhere(
          (d) => d['env'] == _currentEnvironments,
        )
        .values
        .last
        .toString();
  }
}
