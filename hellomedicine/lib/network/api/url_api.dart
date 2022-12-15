class BASEURL {
  static String ipAddress = "192.168.137.1";
  // static String ipAddress = "localhost";
  static String apiRegister = "http://$ipAddress/hellomed/register_api.php";
  static String apiLogin = "http://$ipAddress/hellomed/login_api.php";
  static String categoryWithProduct =
      "http://$ipAddress/hellomed/get_product_with_category.php";
  static String getProduct = "http://$ipAddress/hellomed/get_product.php";
  static String getDriver = "http://$ipAddress/hellomed/get_driver.php";

  static String addToCart = "http://$ipAddress/hellomed/add_to_cart.php";
  static String getProductCart =
      "http://$ipAddress/hellomed/get_cart.php?userID=";
  static String updateQuantityProductCart =
      "http://$ipAddress/hellomed/update_quantity.php";
  static String totalPriceCart =
      "http://$ipAddress/hellomed/get_total_price.php?userID=";
  static String getTotalCart =
      "http://$ipAddress/hellomed/total_cart.php?userID=";
  static String checkout = "http://$ipAddress/hellomed/checkout.php";

  static String addProduct = "http://$ipAddress/hellomed/add_product.php";
  static String deleteProduct =
      "http://$ipAddress/hellomed/delete_product.php?id_product=";
  static String editProduct = "http://$ipAddress/hellomed/edit_product.php";

  static String ubahStatus = "http://$ipAddress/hellomed/edit_order_status.php";

  static String ubahStatusOnly =
      "http://$ipAddress/hellomed/edit_order_status_only.php";

  static String ubahAlamat = "http://$ipAddress/hellomed/edit_coordinates.php";

  static String historyOrder4 =
      "http://$ipAddress/hellomed/get_history4.php?userID=";

  static String historyOrder3 =
      "http://$ipAddress/hellomed/get_history3.php?userID=";
  static String historyOrder = "http://$ipAddress/hellomed/get_history.php";
  static String historyOrder2 = "http://$ipAddress/hellomed/get_history2.php";

  static String getUserDetail =
      "http://$ipAddress/hellomed/get_user_detail.php?userID=";

  static String setUserDetail =
      "http://$ipAddress/hellomed/set_user_detail.php?userID=";
}
