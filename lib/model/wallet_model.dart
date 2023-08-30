class Wallet {
  int? walletid;
  int? userid;
  double? amount;

  Wallet({
    this.walletid,
    this.userid,
    this.amount,
  });

  factory Wallet.fromMap(Map<String, dynamic> json) => Wallet(
        walletid: json['walletid'],
        userid: json['userid'],
        amount: json['amount'],
      );

  Map<String, dynamic> toMap() {
    return {
      'walletid': walletid,
      'userid': userid,
      'amount': amount,
    };
  }
}
