import 'package:flutter/material.dart';
import 'services/store.dart';
import 'services/auth.dart';

final KMainBackgroundColor = Color(0Xff31B4F2);
final KInputFieldColor = Color(0Xff31B4F2);
const KGoldColor = Color(0XffF8CF40);
const KeepLoggedIn = 'KeepLoggedIn';

const KProductName = 'productName';
const KProductID = 'productID';
const KProductPrice = 'productPrice';
const KProductDescription = 'productDescription';
const KProductCategory = 'productCategory';
const KProductImage = 'productImage';
const KProductInfo = 'productInfo';
const KProductSale = 'productSale';
const KProductQuantity = 'productQuantity';
const KProductCollection = 'products';

const KCategory = 'categor';

const KOrdersCollection = 'Orders';
const KOrderDetails = 'OrderDetails';
const KOrderDate = 'OrderDate';
const KTotalPrice = 'TotalPrice';
const KOrderState = 'orderState';
const KOrderStateOpen = 'open';
const KOrderStateDeleted = 'deleted';
const KOrderStateOnDelivery = 'onDelivery';
const KOrderStateDone = 'done';

const KUsersCollection = 'Users';
const KAddress = 'Address';
const KName = 'Name';
const KPhoneNumber = 'PhoneNumber';

final KStore = Store();
final KAuth = Auth();
