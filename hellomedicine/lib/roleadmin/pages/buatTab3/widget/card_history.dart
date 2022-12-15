import 'package:flutter/material.dart';
import 'package:medhealth/network/model/history_model.dart';
import 'package:medhealth/roleadmin/pages/konfirmasi.dart';
import 'package:medhealth/roleadmin/pages/pengantaran.dart';
import 'package:medhealth/theme.dart';

class CardHistory extends StatelessWidget {
  final HistoryOrdelModel model;
  CardHistory(this.model);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        if (model.status == "1")
          {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Konpirmasi(model)))
          }
        else
          {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Pengantaran(model)))
          }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(model.name, style: boldTextStyle.copyWith(fontSize: 16)),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
              )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "INV/" + model.invoice,
            style: regulerTextStyle.copyWith(fontSize: 16),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            model.status == "1" ? "Menunggu Konfirmasi" : model.status,
            style: lightTextStyle.copyWith(fontSize: 15),
          ),
          SizedBox(
            height: 12,
          ),
          Divider()
        ],
      ),
    );
  }
}
