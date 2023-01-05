import 'package:sendgrid_mailer/sendgrid_mailer.dart';

class SendEmail {
  // final mailer = Mailer('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');

  // final emailbody = "<div style='font-family:Arial,Tahoma;font-size:15px'>";

  //                              emailbody += "<h4 style='text-align:center;font-size:18px;color:#aaa;margin:10px'>
  //                               <img src='https://bazeuniversityhospital.com/assets/img/logo.png' height='100px' alt=''><br>
  //                               <strong>BAZE UNIVERSITY HOSPITAL</strong></h4>
  //                               <h4 style='text-align:center;font-size:18px;margin:5px'>Reset Password</h4>
  //                               <h4 style='text-align:center;font-size:18px;margin:5px'>${new Date()}</h4>
  //                               <p style='text-align:center;'>A password reset event has been triggered. The password reset window is limited to two hours.</p>
  //                               <p style='text-align:center;'>If you do not reset your password within two hours, you will need to submit a new request.</p>
  //                               <p style='text-align:center;'>To complete the password reset process, visit the following link:</p>
  //                               <p style='text-align:center;'><a href='${serverLink}patient/account/password/reset/${resetToken}'>${serverLink}patient/account/password/reset/${resetToken}</a></p>
  //                           </div>";

  static sendLoginCredentials({
    String? reciever,
    String? sender,
    String? data,
    String? subj,
  }) {
    final body = '''<div style="font-family:Arial,Tahoma;font-size:15px"> 
        <h4 style="text-align:center;font-size:18px;color:#aaa;margin:10px">
        <img src="https://bazeuniversityhospital.com/assets/img/logo.png" height="100px" alt=""><br>
        <strong>BAZE UNIVERSITY HOSPITAL</strong></h4>
        <h4 style="text-align:center;font-size:18px;margin:5px">${DateTime.now()}</h4>
        <p style="text-align:center;"> Hi Adam,</p>
        <p style="text-align:center;">Welcome to BAZE University Hospital. You\'re all set. Now you can login to your patient dashboard using the information below.
        Make sure to change your password immediately after logged in</p>
        <p style="text-align:center;">PATIENT ID: <strong>FCT-0001</strong></p>
        <p style="text-align:center;">LOGIN USERNAME: <strong>adammusa89@gmail.com</strong></p>
        <p style="text-align:center;">PASSWORD: <strong>12345</strong></p>
        <hr>
        <p style="text-align:center;">Kindly <a href="https://bazeuniversityhospital.com">click here</a> and select returning patient from the menu to login your dashboard</p>
        </div>''';

    final mailer = Mailer(
        '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');
    final toAddress = Address(reciever!);
    final fromAddress = Address(sender!);
    final content = Content('text/html', body);
    final subject = subj!;
    final personalization = Personalization([toAddress]);

    final email = Email(
      [personalization],
      fromAddress,
      subject,
      content: [content],
    );
    mailer.send(email).then((result) {
      // ...
    });
  }
}
