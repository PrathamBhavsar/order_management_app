import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/constants.dart';
import '../../../core/extensions/app_paddings.dart';
import '../../../domain/entities/customer_entity.dart';
import '../../../domain/entities/product_entity.dart';
import '../../providers/category_provider.dart';
import '../../providers/customer_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/product_provider.dart';
import '../order_details/order_details_screen.dart';
import 'signature/signature_screen.dart';
import 'widgets/custom_button_widget.dart';
import 'widgets/custom_dropdown_widget.dart';
import 'widgets/product_list_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final TextEditingController _qtyController = TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: const Text("Add Order")),
          body: Column(
            children: [
              Consumer<OrderProvider>(
                builder: (context, provider, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Units: ${provider.orderItems.length}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black38,
                      ),
                    ),
                    10.hGap,
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
                      ).padSymmetric(vertical: 15),
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
                                labelStyle: TextStyle(
                                  color: AppColors.primary,
                                )),
                            onChanged: (value) {
                              int qty = int.tryParse(value) ?? 1;
                              provider.setSelectedQuantity(qty);
                            },
                          ),
                        ),
                        5.wGap,
                        CustomButton(
                          text: 'ADD',
                          onPressed: () => provider.addOrderItem(),
                        ),
                        CustomButton(
                          text: 'SUB',
                          onPressed: () {
                            if (provider.selectedProduct != null) {
                              provider
                                  .subtractItemQty(provider.selectedProduct!);
                            }
                          },
                        ),
                        CustomButton(
                          text: 'REM',
                          onPressed: () {
                            if (provider.selectedProduct != null) {
                              provider
                                  .removeOrderItem(provider.selectedProduct!);
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
          bottomSheet: Consumer<OrderProvider>(
            builder: (context, orderProvider, child) => Material(
              elevation: 30,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignatureScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Tap to Sign',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  orderProvider.signatureBytes != null
                      ? Image.memory(
                          orderProvider.signatureBytes!,
                          height: 70,
                          width: 120,
                        )
                      : SizedBox.shrink(),
                  FloatingActionButton(
                    shape: const CircleBorder(),
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => OrderDetailsScreen(),
                    ),
                    child: const Icon(Icons.done_rounded),
                  ),
                ],
              ).padSymmetric(vertical: 20, horizontal: 10),
            ),
          ),
        ),
      );
}
