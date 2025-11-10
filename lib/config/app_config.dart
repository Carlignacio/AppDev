class AppConfig {
  // Environment
  static const String environment = 'production'; // 'development', 'staging', 'production'

  // Features flags
  static const bool enableAnalytics = true;
  static const bool enablePushNotifications = true;
  static const bool enableInAppPurchases = false;

  // App settings
  static const int cacheExpirationDays = 7;
  static const int maxUploadSizeInMB = 10;
  static const bool allowOfflineMode = true;

  // Social links
  static const String websiteUrl = 'https://yourapp.com';
  static const String supportEmail = 'support@yourapp.com';
  static const String privacyPolicyUrl = 'https://yourapp.com/privacy';
  static const String termsOfServiceUrl = 'https://yourapp.com/terms';
}