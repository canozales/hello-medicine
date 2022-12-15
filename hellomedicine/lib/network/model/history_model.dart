class HistoryOrdelModel {
  final String invoice;
  final String idUser;
  final String orderAt;
  final String status;
  final String name;
  final String address;
  final String phone;
  final String pengantar;
  final String totalprice;
  final List<HistoryOrderDetailModel> detail;

  HistoryOrdelModel(
      {this.invoice,
      this.idUser,
      this.orderAt,
      this.status,
      this.detail,
      this.name,
      this.address,
      this.phone,
      this.pengantar,
      this.totalprice});

  factory HistoryOrdelModel.fromJson(Map<String, dynamic> dataOrder) {
    var list = dataOrder['detail'] as List;
    List<HistoryOrderDetailModel> dataListDetail =
        list.map((e) => HistoryOrderDetailModel.fromJson(e)).toList();
    return HistoryOrdelModel(
      name: dataOrder['name'],
      address: dataOrder['address'],
      phone: dataOrder['phone'],
      invoice: dataOrder['invoice'],
      idUser: dataOrder['id_user'],
      orderAt: dataOrder['order_at'],
      status: dataOrder['status'],
      pengantar: dataOrder['pengantar'],
      totalprice: dataOrder['totalprice'],
      detail: dataListDetail,
    );
  }
}

class HistoryOrderDetailModel {
  final String idOrders;
  final String invoice;
  final String idProduct;
  final String nameProduct;
  final String quantity;
  final String price;
  final String gambar;

  HistoryOrderDetailModel(
      {this.idOrders,
      this.invoice,
      this.idProduct,
      this.nameProduct,
      this.quantity,
      this.price,
      this.gambar});

  factory HistoryOrderDetailModel.fromJson(Map<String, dynamic> data) {
    return HistoryOrderDetailModel(
        idOrders: data['id_orders'],
        invoice: data['invoice'],
        idProduct: data['id_product'],
        nameProduct: data['nameProduct'],
        quantity: data['quantity'],
        price: data['price'],
        gambar: data['gambar']);
  }
}
