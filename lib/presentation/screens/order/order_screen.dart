import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/extensions/app_paddings.dart';
import '../../../domain/entities/customer_entity.dart';
import '../../../domain/entities/product_entity.dart';
import '../../providers/category_provider.dart';
import '../../providers/customer_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/product_provider.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_dropdown.dart';
import 'widgets/product_list.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final TextEditingController _qtyController = TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Add Order")),
      floatingActionButton: FloatingActionButton(
        onPressed: productProvider.fetchProducts,
        child: const Icon(Icons.refresh),
      ),
      body: Column(
        children: [
          Consumer<OrderProvider>(
            builder: (context, provider, child) => Column(
              children: [
                Consumer<CustomerProvider>(
                  builder: (context, customerProvider, child) =>
                      CustomDropdown<CustomerEntity>(
                    label: "Select Customer",
                    items: customerProvider.customers,
                    itemLabel: (customer) => customer.name,
                    selectedItem:
                        context.watch<OrderProvider>().selectedCustomer,
                    onChanged:
                        context.read<OrderProvider>().setSelectedCustomer,
                  ),
                ),
                Consumer<CategoryProvider>(
                  builder: (context, categoryProvider, child) =>
                      CustomDropdown<String>(
                    label: "Select Category",
                    items: categoryProvider.categories,
                    itemLabel: (category) => category,
                    selectedItem: provider.selectedCategory,
                    onChanged: provider.setSelectedCategory,
                  ).padSymmetric(vertical: 20),
                ),
                Consumer<ProductProvider>(
                  builder: (context, productProvider, child) =>
                      CustomDropdown<ProductEntity>(
                    label: "Select Product",
                    items: productProvider.products,
                    itemLabel: (product) => product.name,
                    selectedItem: provider.selectedProduct,
                    onChanged: provider.setSelectedProduct,
                  ),
                ),

                20.hGap,

                ///
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: _qtyController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Select Qty',
                        ),
                        onChanged: (value) {
                          int qty = int.tryParse(value) ?? 1;
                          provider.setSelectedQuantity(qty);
                        },
                      ),
                    ),
                    5.wGap,
                    CustomButton(
                      text: 'ADD',
                      onPressed: () {
                        provider.addOrderItem();
                      },
                    ),
                    CustomButton(
                      text: 'SUB',
                      onPressed: () {
                        int currentQty = int.tryParse(_qtyController.text) ?? 1;
                        if (currentQty > 1) {
                          int newQty = currentQty - 1;
                          _qtyController.text = newQty.toString();
                          provider.setSelectedQuantity(newQty);
                        }
                      },
                    ),
                    CustomButton(
                      text: 'REM',
                      onPressed: () {
                        if (provider.selectedProduct != null) {
                          provider
                              .removeOrderItem(provider.selectedProduct!.name);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ).padAll(10),
          ),

          ///
          Expanded(
            child: const ProductListWidget(),
          ),
        ],
      ),
    );
  }
}
