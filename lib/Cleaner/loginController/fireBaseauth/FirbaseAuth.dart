import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

Future<String?> getFirebaseIdToken() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return await user.getIdToken(); // Firebase ID Token (JWT)
  }
  return null;
}

Future<Map<String, dynamic>> checkSupervisor(String tenantId) async {
  try {
    final token = await getFirebaseIdToken();
    if (token == null) {
      return {'status': 'fail', 'message': 'No Firebase token'};
    }

    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/check-supervisor"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // <-- send token
      },
      body: jsonEncode({
        "tenant_id": tenantId, // still needed for multi-tenant DB
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {'status': 'fail', 'message': response.body};
    }
  } catch (e) {
    return {'status': 'fail', 'message': e.toString()};
  }
}
