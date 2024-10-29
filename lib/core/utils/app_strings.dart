class AppStrings {
  /// String for categories screen route
  ///
  static const String routeCategories = '/categories';

  /// String for entries screen route
  ///
  static const String routeEntries = 'entries';

  /// String for entries screen parameter
  ///
  static const String categoryName = 'categoryName';

  /// String for default server exception message.
  ///
  static const String defaultServerExceptionMessage =
      'Failed to fetch data from the server';

  /// String for default cache exception message.
  ///
  static const String defaultCacheExceptionMessage =
      'Failed to fetch data from the local starage';

  /// String for default server failure message.
  ///
  static const String defaultServerFailureMessage =
      'Failed to fetch data from the server';

  /// String for default cache failure message.
  ///
  static const String defaultCacheFailureMessage =
      'Failed to fetch data from the local starage';

  /// String for content type key.
  ///
  static const String contentType = 'Content-Type';

  /// String for content type value (application/json).
  ///
  static const String applicationJson = 'application/json';

  /// String for caching categories in shared prefereces.
  ///
  static const String cachedCategories = 'categories';

  /// String for caching entries in shared prefereces.
  /// Must be conconatenated with '#<category name>'.
  ///
  static const String cachedEntries = 'entries';
}
