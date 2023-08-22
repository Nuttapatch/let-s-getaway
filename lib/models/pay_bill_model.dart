class PayBillModel {
  late String id;
  late String date;
  late String payType;
  late String planID;
  late int status;
  late String tranferSlip;
  late String username;
  late double amount;

  PayBillModel(this.id, this.planID, this.date, this.payType, this.status,
      this.tranferSlip, this.username, this.amount);
}
