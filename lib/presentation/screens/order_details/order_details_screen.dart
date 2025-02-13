import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/extensions/app_paddings.dart';
import '../../providers/order_provider.dart';
import 'widgets/order_table_widget.dart';
import 'widgets/total_table_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final customerName =
        orderProvider.selectedCustomer?.name ?? "Unknown Customer";
    final discount = 4.0;

    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: DraggableScrollableSheet(
            initialChildSize: 0.9,
            expand: false,
            builder: (context, scrollController) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  title: Text(
                    "Order Details",
                    style: TextStyle(color: Colors.black),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.close),
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ).padSymmetric(vertical: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    5.hGap,
                    Text(
                      "Discount : ${discount.toStringAsFixed(1)}%",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ],
                ).padAll(10),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child:
                        OrderTableWidget(orderItems: orderProvider.orderItems),
                  ),
                ),
                TotalTableWidget(orderItems: orderProvider.orderItems),
                Consumer<OrderProvider>(
                  builder: (context, orderProvider, child) => Material(
                    elevation: 30,
                    color: Colors.white,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Signature',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          20.wGap,
                          orderProvider.signatureBytes != null
                              ? Image.memory(
                                  orderProvider.signatureBytes!,
                                  height: 70,
                                  width: 120,
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
