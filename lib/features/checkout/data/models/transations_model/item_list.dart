import 'package:dartz/dartz.dart';

import 'item.dart';

class ItemList {
  List<OrderItem>? orderitems;

  ItemList({this.orderitems});

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
    orderitems:
        (json['items'] as List<dynamic>?)
            ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'items': orderitems?.map((e) => e.toJson()).toList(),
  };
}
