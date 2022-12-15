import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medhealth/main_page.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/theme.dart';

import 'package:medhealth/widget/button_primary.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:geolocator/geolocator.dart';

class EditAddressPage extends StatefulWidget {
  var model;
  String idUser;
  EditAddressPage(this.model, this.idUser);

  @override
  _EditAddressPageState createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  setAddress(double lat, double lng, String tempat) async {
    if (lat == null || lng == null) {
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "Pengumuman",
                  style: TextStyle(color: redColor),
                ),
                content: Text("Belum ada Perubahan"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(color: redColor),
                      ))
                ],
              ));
      return;
    }
    var urlSetAddress = Uri.parse(BASEURL.ubahAlamat);
    final response = await http.post(urlSetAddress, body: {
      'id_user': widget.idUser,
      'latitude': lat.toString(),
      'longtitude': lng.toString(),
      'address': tempat
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "Pengumuman",
                  style: TextStyle(color: redColor),
                ),
                content: Text(message),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPages(2)),
                            (route) => false);
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(color: redColor),
                      ))
                ],
              ));
    }
  }

  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(-6.19423211084943, 106.84323894367465), zoom: 14.0);

  Set<Marker> markersList = {};

  GoogleMapController googleMapController;

  final Mode _mode = Mode.overlay;
  final kGoogleApiKey = 'AIzaSyBCXS-E90n7wVi7xYQepfiBzJm7LZLxZhQ';
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  String namaTempat = "Tidak Terdefinisi";

  var lat1;
  var lat2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          key: homeScaffoldKey,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                  height: 70,
                  child: Row(children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 28,
                        color: redColor,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Pengaturan Alamat",
                      style: regulerTextStyle.copyWith(
                          fontSize: 22, color: redColor),
                    ),
                  ])),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      height: 500,
                      child: GoogleMap(
                        initialCameraPosition: initialCameraPosition,
                        markers: markersList,
                        mapType: MapType.normal,
                        onMapCreated: (GoogleMapController controller) {
                          googleMapController = controller;
                        },
                      ),
                    ),
                    ButtonPrimary(
                      text: 'Lokasi Sekarang',
                      onTap: () async {
                        BitmapDescriptor markerbitmap =
                            await BitmapDescriptor.fromAssetImage(
                          ImageConfiguration(),
                          "assets/marker2.png",
                        );
                        Position position = await _determinePosition();
                        googleMapController.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                                target: LatLng(
                                    position.latitude, position.longitude),
                                zoom: 14)));
                        markersList.clear();
                        markersList.add(Marker(
                            icon: markerbitmap,
                            markerId: const MarkerId('currentLocation'),
                            position:
                                LatLng(position.latitude, position.longitude)));

                        setState(() {
                          lat1 = position.latitude;
                          lat2 = position.longitude;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    ButtonPrimary(
                      text: 'Cari Tempat',
                      onTap: () {
                        _handlePressButton();
                      },
                    ),
                    const SizedBox(height: 16),
                    ButtonPrimary(
                      text: 'Simpan Alamat',
                      onTap: () {
                        setAddress(lat1, lat2, namaTempat);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
  Future<void> _handlePressButton() async {
    Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: "AIzaSyBCXS-E90n7wVi7xYQepfiBzJm7LZLxZhQ",
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Cari Alamatmu',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
        components: [Component(Component.country, "id")]);

    displayPrediction(p, homeScaffoldKey.currentState);
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState currentState) async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/marker2.png",
    );

    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId);

    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;

    markersList.clear();
    markersList.add(Marker(
        icon: markerbitmap,
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {
      namaTempat = detail.result.name;
      lat1 = detail.result.geometry.location.lat;
      lat2 = detail.result.geometry.location.lng;
    });

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
