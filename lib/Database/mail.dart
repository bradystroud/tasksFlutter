import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart'; //For creating the SMTP server
import 'package:url_launcher/url_launcher.dart';

main() async {
  String username = "ajsidnekf@gmail.com";
  String password = "PASSWORD123";

  final smtpServer = gmail(username, password); 
  // Creating the Gmail server

  // Create our email message.
  final message = Message()
    ..from = Address(username)
    ..recipients.add('dest@example.com') //recipent email
    ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
    ..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
    ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}' //subject of the email
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'; //body of the email

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString()); //print if the email is sent
  } on MailerException catch (e) {
    print('Message not sent. \n'+ e.toString()); //print if the email is not sent
    // e.toString() will show why the email is not sending
  }
} 

launchEmail() async {
    // ios specification
    final String subject = "TASKS APP FEEDBACK";
    final String stringText = "Feedback: ";
    String uri = 'mailto:bradystroud@me.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(stringText)}';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      print("No email client found");
    }
  }