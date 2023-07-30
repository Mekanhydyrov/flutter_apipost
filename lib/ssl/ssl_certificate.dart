import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        // Add your custom SSL certificate validation logic here
        // For example, you can accept all certificates by returning 'true',
        // but it's not recommended for production use.
        return true; // Accept all certificates (not recommended for production)
      };
  }
}