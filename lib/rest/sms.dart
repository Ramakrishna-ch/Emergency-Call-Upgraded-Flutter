import 'package:flutter/cupertino.dart';
import 'package:sms_maintained/sms.dart';

class SmsSend with ChangeNotifier {
  void sendSms(String content, String number) {
    SmsSender sender = SmsSender();
    String address = number;

    SmsMessage message = SmsMessage(address, content);
    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        print("SMS is sent!");
      } else if (state == SmsMessageState.Delivered) {
        print("SMS is delivered!");
      }
    });
    sender.sendSms(message);
  }
}
