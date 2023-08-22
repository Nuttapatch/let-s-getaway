class TravelPlace {
  late String id;
  late String address;
  late String name;
  late String openTime;
  late String closeTime;
  late String highlight;
  late String latitude;
  late String longtitude;
  late String location;
  late String province;
  late String travelPlaceTypeID;
  late List image;
  late List enterPrice;

  TravelPlace(
      this.id,
      this.name,
      this.openTime,
      this.closeTime,
      this.highlight,
      this.latitude,
      this.longtitude,
      this.location,
      this.province,
      this.travelPlaceTypeID,
      this.image,
      this.address,
      this.enterPrice);
}
