class Bill {
  late String id;
  late String bank;
  late String bankAccount;
  late String bankName;
  late String billName;
  late int billStatus;
  late String userCreate;
  late Map<String, dynamic> users;
  late String date;
  late String planID;

  Bill(this.id, this.bank, this.bankAccount, this.bankName, this.billName,
      this.billStatus, this.userCreate, this.users, this.date, this.planID);
}
