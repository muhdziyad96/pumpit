import 'package:pumpit/model/user_model.dart';

class PaymentCard {
  int? cardid;
  int userid;
  String? cardname;
  String? cardnum;
  String? expDate;
  String? cardType;
  User? user;

  PaymentCard({
    this.cardid,
    required this.userid,
    this.cardname,
    this.cardnum,
    this.expDate,
    this.cardType,
    this.user,
  });

  factory PaymentCard.fromMap(Map<String, dynamic> json) => PaymentCard(
        cardid: json['cardid'],
        userid: json['userid'],
        cardname: json['cardname'],
        cardnum: json['cardnum'],
        expDate: json['expDate'],
        cardType: json['cardType'],
        // user: User.fromMap(json['user']),
      );

  Map<String, dynamic> toMap() {
    return {
      'cardid': cardid,
      'userid': userid,
      'cardname': cardname,
      'cardnum': cardnum,
      'expDate': expDate,
      'cardType': cardType,
      // 'user': user?.toMap(),
    };
  }
}
