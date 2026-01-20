class AppConstants {
  // API Constants
  // static const String baseUrl = 'https://www.sen.point-cash.org';
  // static const String baseUrl = 'https://readypos.razinsoft.com';
  // static const String baseUrl = 'https://pos.digi-nest.my.id';
  static const String baseUrl = 'https://app.my-mirra.com/api';
  //  static const String baseUrl = 'http://192.168.0.80:8080';

  static const String loginUrl = '$baseUrl/sign-in';
  static const String profileUpdate = '$baseUrl/profile/update';
  static const String passwordChange = '$baseUrl/change/password';
  static const String forgotPassword = '$baseUrl/forgot/password';
  static const String dashboard = '$baseUrl/dashboard';
  static const String posProducts = '$baseUrl/product/search';
  static const String customers = '$baseUrl/customer/search';
  static const String cupon = '$baseUrl/apply/promo/code';
  static const String customersGroup = '$baseUrl/customer/groups';
  static const String addCustomer = '$baseUrl/customer/store';
  static const String posStore = '$baseUrl/pos/store';
  static const String report = '$baseUrl/reports';
  // category
  static const String categories = '$baseUrl/categories';
  static const String parentCategory =
      '$baseUrl/categories/parent-category';
  static const String addCategory = '$baseUrl/categories/store';
  static const String updateCategory = '$baseUrl/categories/update';
  static const String deleteCategory = '$baseUrl/categories/delete';
  // product
  static const String products = '$baseUrl/products';
  static const String productDetails = '$baseUrl/product/details';
  static const String deleteProduct = '$baseUrl/product/delete';
  static const String productInfo = '$baseUrl/add/product/info';
  static const String addProduct = '$baseUrl/product/store';
  // brand
  static const String brands = '$baseUrl/brands';
  static const String addBrand = '$baseUrl/brands/store';
  static const String updateBrand = '$baseUrl/brands/update';
  static const String deleteBrand = '$baseUrl/brands/delete';

  // deposit
  static const String bankAccount = '$baseUrl/accounts';
  static const String balance = '$baseUrl/balance';
  static const String balanceTransfer = '$baseUrl/balance/transfer';

  // purchase
  static const String purchasePDF = '$baseUrl/purchase/pdf';
  static const String salesPDF = '$baseUrl/sale/pdf';
  static const String statusPurchase = '$baseUrl/detail/{purchaseId}';

  // warehouse
  static const String warehouses = '$baseUrl/warehouses';
  static const String updateWarehouse = '$baseUrl/warehouses/update';
  static const String addWarehouse = '$baseUrl/warehouses/store';
  static const String deleteWarehouse = '$baseUrl/warehouses/delete';

  static const String democurrency = '\$';
  static const String appcurrency = '$baseUrl/general-settings';

  static const String purchase = "$baseUrl/purchase";
  static const String wareHouse = "$baseUrl/warehouses";
  static const String sales = "$baseUrl/sales";
  static const String expenses = "$baseUrl/expense";
  static const String accounts = "$baseUrl/admin/accounts";
  static const String drafts = "$baseUrl/drafts";
  static const String paymentSuccess = "$baseUrl/sale/payment/success";
  static const String deleteDraft = "$baseUrl/draft/delete";
  // payment
  static const String paymentList = "$baseUrl/payment-gateway-list";
  // load invoice
  static const String loadInvoice = "$baseUrl/invoice";

  // Hive Box
  static const String appSettingsBox = 'appSettings';
  static const String authBox = 'authBox';
  static const String cartBox = 'cartBox';

  // Settings veriable Names
  static const String appLocal = 'appLocal';
  static const String isDarkTheme = 'isDarkTheme';

  // Auth Variable Names
  static const String authToken = 'token';
  static const String userData = 'userData';
}
