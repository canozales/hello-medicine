import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/network/model/product_model.dart';
import 'package:medhealth/roleadmin/pages/buatTab3/page/add_product.dart';
import 'package:medhealth/roleadmin/pages/detail_product.dart';
import 'package:medhealth/roleadmin/pages/search_product.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/card_category.dart';
import 'package:medhealth/widget/card_product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int index;
  bool filter = false;
  List<CategoryWithProduct> listCategory = [];

  getCategory() async {
    listCategory.clear();
    var urlCategory = Uri.parse(BASEURL.categoryWithProduct);
    final response = await http.get(urlCategory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          listCategory.add(CategoryWithProduct.fromJson(item));
        }
      });
      getProduct();
      totalCart();
    }
  }

  List<ProductModel> listProduct = [];
  getProduct() async {
    listProduct.clear();
    var urlProduct = Uri.parse(BASEURL.getProduct);
    final response = await http.get(urlProduct);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map product in data) {
          listProduct.add(ProductModel.fromJson(product));
        }
      });
    }
  }

  String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUSer);
    });
  }

  String jumlahCart = "0";
  totalCart() async {
    var urlGetTotalCart = Uri.parse(BASEURL.getTotalCart + userID);
    final response = await http.get(urlGetTotalCart);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)[0];
      String jumlah = data['Jumlah'];
      setState(() {
        jumlahCart = jumlah;
      });
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getPref();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: buildNavigateButton(),
        body: SafeArea(
            child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(24, 16, 24, 30),
          children: [
            Image.asset(
              'assets/logomed.png',
            ),
            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchProduct()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 234, 196, 196)),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: redColor,
                      ),
                      hintText: "Cari obat",
                      hintStyle: regulerTextStyle.copyWith(color: redColor)),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              "Cari Berdasarkan Kategori",
              style: regulerTextStyle.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: 14,
            ),
            GridView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: listCategory.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 10),
                itemBuilder: (context, i) {
                  final x = listCategory[i];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        index = i;
                        filter = true;
                      });
                    },
                    child: CardCategory(
                      imageCategory: x.image,
                      nameCategory: x.category,
                    ),
                  );
                }),
            SizedBox(
              height: 32,
            ),
            filter
                ? index == 7
                    ? Text("Feature on proggress")
                    : GridView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: listCategory[index].product.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16),
                        itemBuilder: (context, i) {
                          final y = listCategory[index].product[i];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailProduct(y)));
                            },
                            child: CardProduct(
                              nameProduct: y.nameProduct,
                              imageProduct: y.imageProduct,
                              price: y.price,
                            ),
                          );
                        })
                : GridView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: listProduct.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16),
                    itemBuilder: (context, i) {
                      final y = listProduct[i];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailProduct(y)));
                        },
                        child: CardProduct(
                          nameProduct: y.nameProduct,
                          imageProduct: y.imageProduct,
                          price: y.price,
                        ),
                      );
                    }),
          ],
        )));
  }

  Widget buildNavigateButton() => Padding(
        padding: const EdgeInsets.only(right: 0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddProductPage()));
          },
          child: Icon(
            Icons.add,
            size: 28,
          ),
          backgroundColor: redColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      );
}
