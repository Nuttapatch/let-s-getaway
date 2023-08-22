class Plan {
  late String id;
  late String dateBack;
  late String dateGo;
  late String placeBackLat;
  late String placeBackLong;
  late String placeGoLat;
  late String placeGoLong;
  late String planName;
  late int planStatus;
  late String userCreate;
  late List usersInPlan;

  Plan(
      this.id,
      this.dateBack,
      this.dateGo,
      this.placeBackLat,
      this.placeBackLong,
      this.placeGoLat,
      this.placeGoLong,
      this.planName,
      this.planStatus,
      this.userCreate,
      this.usersInPlan);
}
