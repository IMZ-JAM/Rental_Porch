import 'dart:convert';
import 'package:http/http.dart' as http;



Future sendEmailToAskRes({
  required String name,
  required String toEmail,
  required String replyToEmail,
  required String message,
  required String clientName
})async{
  const serviceId = 'service_5eia0s3';
  const templateId = 'template_6x4kj38';
  const accountKey = 'WNyJ_QVMIC0C-LDQP';

  final uri = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  
  await http.post(
    uri,
    headers: {
      'origin' : 'http://local.host',
      'Content-Type' : 'application/json',
    },
    body: jsonEncode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': accountKey,
      'template_params': {
        'to_email': toEmail,
        'to_name': name,
        'message': message,
        'reply_to_email': replyToEmail,
      }
    })
  );

}


Future sendEmailToAcceptOrDicline({
  required String name,
  required String toEmail,
  required String replyToEmail,
  required String message,
  required String rentadorName
})async{
  const serviceId = 'service_5eia0s3';
  const templateId = 'template_0qb9br9';
  const accountKey = 'WNyJ_QVMIC0C-LDQP';

  final uri = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  
  await http.post(
    uri,
    headers: {
      'origin' : 'http://local.host',
      'Content-Type' : 'application/json',
    },
    body: jsonEncode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': accountKey,
      'template_params': {
        'to_email': toEmail,
        'to_name': name,
        'message': message,
        'reply_to_email': replyToEmail,
        'from_name': rentadorName
      }
    })
  );

}
