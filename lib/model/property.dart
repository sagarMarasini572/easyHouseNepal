class Properties {
  bool? success;
  List<Property>? properties;

  Properties({this.success, this.properties});

  Properties.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['message'] != null) {
      properties = <Property>[];
      json['message'].forEach((v) {
        properties!.add(Property.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (properties != null) {
      data['message'] = properties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Property {
  String? propertyId;
  String? propertyTitle;
  String? propertyPrice;
  String? propertyArea;
  String? propertyAge;
  String? noOfFloors;
  String? noOfRooms;
  String? facingDirection;
  String? contractDuration;
  String? noOfBedrooms;
  String? noOfBathrooms;
  String? noOfKitchens;
  String? province;
  String? district;
  String? city;
  String? tole;
  String? propertyHouseNo;
  String? propertyDescription;
  String? ownerName;
  String? ownerEmail;
  String? ownerContact;
  bool? isWished;
  bool? isBooked;
  String? bookedDate;
  List<Images>? images;

  Property(
      {this.propertyId,
      this.propertyTitle,
      this.propertyPrice,
      this.propertyArea,
      this.propertyAge,
      this.noOfFloors,
      this.noOfRooms,
      this.facingDirection,
      this.contractDuration,
      this.noOfBedrooms,
      this.noOfBathrooms,
      this.noOfKitchens,
      this.province,
      this.district,
      this.city,
      this.tole,
      this.propertyHouseNo,
      this.propertyDescription,
      this.ownerName,
      this.ownerEmail,
      this.ownerContact,
      this.isWished,
      this.isBooked,
      this.bookedDate,
      this.images});

  Property.fromJson(Map<String, dynamic> json) {
    propertyId = json['property_id'];
    propertyTitle = json['property_title'];
    propertyPrice = json['property_price'];
    propertyArea = json['property_area'];
    propertyAge = json['property_age'];
    noOfFloors = json['no_of_floors'];
    noOfRooms = json['no_of_rooms'];
    facingDirection = json['facing_direction'];
    contractDuration = json['contract_duration'];
    noOfBedrooms = json['no_of_bedrooms'];
    noOfBathrooms = json['no_of_bathrooms'];
    noOfKitchens = json['no_of_kitchens'];
    province = json['province'];
    district = json['district'];
    city = json['city'];
    tole = json['tole'];
    propertyHouseNo = json['property_house_no'];
    propertyDescription = json['property_description'];
    ownerName = json['owner_name'];
    ownerEmail = json['owner_email'];
    ownerContact = json['owner_contact'];
    isWished = json['is_wished'];
    isBooked = json['is_booked'];
    bookedDate = json['book_date'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['property_id'] = propertyId;
    data['property_title'] = propertyTitle;
    data['property_price'] = propertyPrice;
    data['property_area'] = propertyArea;
    data['property_age'] = propertyAge;
    data['no_of_floors'] = noOfFloors;
    data['no_of_rooms'] = noOfRooms;
    data['facing_direction'] = facingDirection;
    data['contract_duration'] = contractDuration;
    data['no_of_bedrooms'] = noOfBedrooms;
    data['no_of_bathrooms'] = noOfBathrooms;
    data['no_of_kitchens'] = noOfKitchens;
    data['province'] = province;
    data['district'] = district;
    data['city'] = city;
    data['tole'] = tole;
    data['property_house_no'] = propertyHouseNo;
    data['property_description'] = propertyDescription;
    data['owner_name'] = ownerName;
    data['owner_email'] = ownerEmail;
    data['owner_contact'] = ownerContact;
    data['is_wished'] = isWished;
    data['is_booked'] = isBooked;
    data['book_date'] = bookedDate;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? imgId;
  String? imgPath;
  String? propertyId;

  Images({this.imgId, this.imgPath, this.propertyId});

  Images.fromJson(Map<String, dynamic> json) {
    imgId = json['img_id'];
    imgPath = json['img_path'];
    propertyId = json['property_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['img_id'] = imgId;
    data['img_path'] = imgPath;
    data['property_id'] = propertyId;
    return data;
  }
}
