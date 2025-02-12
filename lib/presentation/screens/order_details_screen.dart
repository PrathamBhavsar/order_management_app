import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/extensions/app_paddings.dart';
import '../providers/order_provider.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final orderItems = orderProvider.orderItems;
    final customerName =
        orderProvider.selectedCustomer?.name ?? "Unknown Customer";
    final discount = 4.0;

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

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customerName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          5.hGap,
          Text("Discount : ${discount.toStringAsFixed(1)}%",
              style: TextStyle(color: Colors.red, fontSize: 16)),
          20.hGap,
          Expanded(
            child: DataTable(
              columnSpacing: 1,
              headingRowColor:
                  WidgetStateColor.resolveWith((states) => Colors.grey[300]!),
              border: TableBorder.all(color: Colors.black),
              columns: [
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.spaceAround,
                  label: Center(
                    child: Text("Name", softWrap: true),
                  ),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.spaceAround,
                  numeric: true,
                  label: Center(
                    child: Text("Qty", softWrap: true),
                  ).padSymmetric(horizontal: 12),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.spaceAround,
                  numeric: true,
                  label: Center(
                    child: Text("Unit\nPrice", softWrap: true),
                  ).padSymmetric(horizontal: 12),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.spaceAround,
                  numeric: true,
                  label: Center(
                    child: Text("Total\nPrice", softWrap: true),
                  ).padSymmetric(horizontal: 12),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.spaceAround,
                  numeric: true,
                  label: Center(child: Text("Net\nPrice", softWrap: true))
                      .padSymmetric(horizontal: 0),
                ),
              ],
              rows: [
                ...orderItems.entries.map((entry) {
                  final product = entry.key;
                  final quantity = entry.value;
                  final totalItemPrice = product.price * quantity;
                  final netItemPrice =
                      totalItemPrice * ((100 - discount) / 100);

                  return DataRow(cells: [
                    DataCell(
                      Center(
                        child: Text(product.name, softWrap: true),
                      ),
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
                DataRow(
                  color: WidgetStateColor.resolveWith(
                      (states) => Colors.grey[200]!),
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
                ),
              ],
            ),
          ),
        ],
      ).padAll(10),
    );
  }
}
