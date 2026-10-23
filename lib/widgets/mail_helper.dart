import 'package:url_launcher/url_launcher.dart';

import '../data/catalog.dart';

class MailHelper {
  static Future<bool> send({
    required String subject,
    required String body,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: Catalog.email,
      query: _encode({'subject': subject, 'body': body}),
    );
    if (await canLaunchUrl(uri)) {
      return launchUrl(uri);
    }
    return false;
  }

  static String _encode(Map<String, String> params) {
    return params.entries
        .map(
          (entry) =>
              '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}',
        )
        .join('&');
  }
}
