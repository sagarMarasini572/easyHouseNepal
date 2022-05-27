// Form Error
final RegExp emailValidatorRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
final RegExp phoneValidatorRegExp = RegExp(r'(^(?:[+0]98)?[0-9]{10}$)');
final RegExp fullnameValidatorRegExp = RegExp(r'(^[a-zA-Z ]*$)');

const String kEmailNullError = "Email is required";
const String kDistrictNullError = "District is required";
const String kCityNullError = "City is required";
const String kToleNullError = "Tole is required";
const String kHouseNoNullError = "House no is required";
const String kPropertyNameNullError = "Property Name is required";
const String kPriceNullError = "Price is required";
const String kAreaNullError = "Area is required";
const String kAgeNullError = "Age is required";
const String kFloorNullError = "Floor is required";
const String kRoomNullError = "Room is required";
const String kBedRoomNullError = "Bed Room is required";
const String kBathRoomNullError = "Bath Room is required";
const String kKitchenNullError = "Kitchen is required";
const String kPassNullError = "Password is required";
const String kCodeNullError = "Reset code is required";
const String kConfirmPassNullError = "Re-enter your password";
const String kNamelNullError = "Full name is required";
const String kPhoneNumberNullError = "Phone number is required";
const String kAddressNullError = "Address is required";

const String kInvalidPhoneNumberError = "Please enter valid contact number";
const String kInvalidEmailError = "Please enter valid email address";
const String kInvalidFullNameError = "Please enter valid Name";

const String kShortEmailError = "Email must be at least 15 characters";
const String kShortCodeError = "Code must be at least 6 digits";
const String kShortPropertyNameError =
    "Property Name must be at least 8 digits";
const String kShortNameError = "Full Name must be at least 8 characters";
const String kShortDistrictError = "District must be at least 5 characters";
const String kShortCityError = "City must be at least 5 characters";
const String kShortToleError = "Tole must be at least 5 characters";
const String kShortAreaError = "Area must be at least 2 characters";
const String kShortPriceError = "Tole must be at least 4 characters";
const String kShortHouseNoError = "HouseNo must be at least 5 characters";
const String kShortPassError = "Password must be at least 6 characters";
const String kShortName = "Full Name is too short";

const String kLongPassError = "Password must not be greater than 15 characters";
const String kLongDistrictError =
    "District must not be greater than 15 characters";
const String kLongPropertyNameError =
    "Property Name must not be greater than 25 characters";
const String kLongCityError = "City must not be greater than 15 characters";
const String kLongKitchenError =
    "Kitchen must not be greater than 2 characters";
const String kLongBathRoomError =
    "Bath Room must not be greater than 2 characters";
const String kLongBedRoomError =
    "Bed Room must not be greater than 2 characters";
const String kLongRoomError = "Room must not be greater than 2 characters";
const String kLongFloorError = "Floor must not be greater than 2 characters";
const String kLongAgeError = "Age must not be greater than 2 characters";
const String kLongAreaError = "Area must not be greater than 3 characters";
const String kLongPriceError = "Price must not be greater than 7 characters";
const String kLongToleError = "Tole must not be greater than 15 characters";
const String kLongHouseNoError =
    "HouseNo must not be greater than 15 characters";
const String kLongEmailError = "Email must not be greater than 30 characters";
const String kLongCodeError = "Code must not be greater than 6 digits";
const String kLongNameError =
    "Full Name must not be greater than 20 characters";

const String kAlphabetOnlyError = "Please enter alphabet characters only";

const String kMatchPassError = "Passwords don't match";



