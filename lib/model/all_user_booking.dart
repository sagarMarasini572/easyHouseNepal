class AllUserBookings {
  bool? success;
  List<String>? message;
  List<AllUserBooking>? allUserBooking;

  AllUserBookings({this.success, this.message, this.allUserBooking});

  AllUserBookings.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'].cast<String>();
    if (json['data'] != null) {
      allUserBooking = <AllUserBooking>[];
      json['data'].forEach((v) {
        allUserBooking!.add(AllUserBooking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (allUserBooking != null) {
      data['data'] = allUserBooking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllUserBooking {
  String? id;
  String? userId;
  String? propertyId;
  String? propertyTitle;
  String? propertyPrice;
  String? noOfBedrooms;
  String? noOfBathrooms;
  String? noOfKitchens;
  String? propertyDescription;
  String? bookDate;
  List<Images>? images;
  String? fullName;
  bool? isbooked;

  AllUserBooking(
      {this.id,
      this.userId,
      this.propertyId,
      this.propertyTitle,
      this.propertyPrice,
      this.noOfBedrooms,
      this.noOfBathrooms,
      this.noOfKitchens,
      this.propertyDescription,
      this.bookDate,
      this.images,
      this.fullName,
      this.isbooked});

  AllUserBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    propertyId = json['property_id'];
    propertyTitle = json['property_title'];
    propertyPrice = json['property_price'];
    noOfBedrooms = json['no_of_bedrooms'];
    noOfBathrooms = json['no_of_bathrooms'];
    noOfKitchens = json['no_of_kitchens'];
    propertyDescription = json['property_description'];
    bookDate = json['book_date'];
    isbooked = json['is_booked'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['property_id'] = propertyId;
    data['property_title'] = propertyTitle;
    data['property_price'] = propertyPrice;
    data['no_of_bedrooms'] = noOfBedrooms;
    data['no_of_bathrooms'] = noOfBathrooms;
    data['no_of_kitchens'] = noOfKitchens;
    data['property_description'] = propertyDescription;
    data['book_date'] = bookDate;
    data['is_booked'] = isbooked;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['full_name'] = fullName;
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
