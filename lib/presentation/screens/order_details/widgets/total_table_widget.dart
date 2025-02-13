import 'package:flutter/material.dart';

import '../../../../core/extensions/app_paddings.dart';
import '../../../../domain/entities/product_entity.dart';

class TotalTableWidget extends StatelessWidget {
  final Map<ProductEntity, int> orderItems;
  final double discount;

  const TotalTableWidget({
    super.key,
    required this.orderItems,
    this.discount = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    double totalQty = orderItems.values.fold(0, (sum, qty) => sum + qty);
    double totalUnitPrice = orderItems.entries.fold(
      0,
      (sum, entry) => sum + entry.key.price,
    );
    double totalPrice = orderItems.entries.fold(
      0,
      (sum, entry) => sum + (entry.key.price * entry.value),
    );
    double totalNetPrice = totalPrice * ((100 - discount) / 100);

    return DataTable(
      columnSpacing: 10,
      dataRowColor: WidgetStateColor.resolveWith((states) => Colors.grey[700]!),
      border: TableBorder(
        top: BorderSide.none,
        verticalInside: BorderSide(),
        bottom: BorderSide(width: 3),
      ),
      headingRowHeight: 0,
      columns: [
        DataColumn(
          headingRowAlignment: MainAxisAlignment.spaceBetween,
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
          headingRowAlignment: MainAxisAlignment.spaceBetween,
          numeric: true,
          label: Center(child: Text("Net\nPrice", softWrap: true))
              .padSymmetric(horizontal: 8),
        ),
      ],
      rows: [
        DataRow(
          color: WidgetStateColor.resolveWith((states) => Colors.grey[200]!),
          cells: [
            DataCell(
              Center(
                child: Text(
                  "Total",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            DataCell(
              Center(
                child: Text(
                  totalQty.toStringAsFixed(0),
                ),
              ),
            ),
            DataCell(
              Center(
                child: Text(
                  totalUnitPrice.toStringAsFixed(2),
                ),
              ),
            ),
            DataCell(
              Center(
                child: Text(
                  totalPrice.toStringAsFixed(2),
                ),
              ),
            ),
            DataCell(
              Center(
                child: Text(
                  totalNetPrice.toStringAsFixed(2),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
