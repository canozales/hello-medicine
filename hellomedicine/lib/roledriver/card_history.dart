import 'package:flutter/material.dart';
import 'package:medhealth/network/model/history_model.dart';
import 'package:medhealth/roledriver/konfirmasi.dart';
import 'package:medhealth/theme.dart';
import 'package:date_format/date_format.dart';

class CardHistory extends StatelessWidget {
  final HistoryOrdelModel model;
  CardHistory({this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Konpirmasi(model)))
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("INV/" + model.invoice,
                  style: boldTextStyle.copyWith(fontSize: 16)),
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
            formatDate(DateTime.parse(model.orderAt),
                ['Tanggal ', dd, '/', mm, '/', yyyy]),
            style: regulerTextStyle.copyWith(fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            model.status,
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
