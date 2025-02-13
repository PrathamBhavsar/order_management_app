import 'package:flutter/material.dart';

import '../../../../core/extensions/app_paddings.dart';
import '../../../../domain/entities/product_entity.dart';

class OrderTableWidget extends StatelessWidget {
  final Map<ProductEntity, int> orderItems;
  final double discount;

  const OrderTableWidget({
    super.key,
    required this.orderItems,
    this.discount = 4.0,
  });

  @override
  Widget build(BuildContext context) => DataTable(
        columnSpacing: 10,
        horizontalMargin: 10,
        headingTextStyle: TextStyle(
          color: Colors.white,
        ),
        headingRowColor:
            WidgetStateColor.resolveWith((states) => Colors.grey[700]!),
        border: TableBorder(
          left: BorderSide.none,
          verticalInside: BorderSide(),
          horizontalInside: BorderSide(),
          top: BorderSide(),
          bottom: BorderSide(),
          right: BorderSide.none,
        ),
        columns: [
          DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Center(
              child: Text("Name", softWrap: true),
            ),
          ),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.spaceBetween,
            numeric: true,
            label: Center(
              child: Text("Qty", softWrap: true),
            ).padSymmetric(horizontal: 10),
          ),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.spaceBetween,
            numeric: true,
            label: Center(
              child: Text("Unit\nPrice", softWrap: true),
            ).padSymmetric(horizontal: 10),
          ),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.spaceBetween,
            numeric: true,
            label: Center(
              child: Text("Total\nPrice", softWrap: true),
            ).padSymmetric(horizontal: 10),
          ),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            numeric: true,
            label: Center(child: Text("Net\nPrice", softWrap: true))
                .padSymmetric(horizontal: 8),
          ),
        ],
        rows: [
          ...orderItems.entries.map((entry) {
            final product = entry.key;
            final quantity = entry.value;
            final totalItemPrice = product.price * quantity;
            final netItemPrice = totalItemPrice * ((100 - discount) / 100);

            return DataRow(cells: [
              DataCell(
                Text(product.name, softWrap: true),
              ),
              DataCell(
                Center(
                  child: Text(
                    quantity.toString(),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    product.price.toStringAsFixed(2),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    totalItemPrice.toStringAsFixed(2),
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    netItemPrice.toStringAsFixed(2),
                  ),
                ),
              ),
            ]);
          }),
        ],
      );
}
