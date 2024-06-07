import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static const String baseUrl =
      'https://flowiseai-railway-production-06ee.up.railway.app';

  // prediction endpoint
  static String get prediction =>
      '/api/v1/prediction/${dotenv.env['ChatFlowId']}';

  // prediction endpoint
  static String get upsert =>
      '/api/v1/vector/upsert/${dotenv.env['ChatFlowId']}';
}
