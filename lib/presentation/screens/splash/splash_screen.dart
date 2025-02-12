import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/category_repository.dart';
import '../../providers/category_provider.dart';
import '../../providers/customer_provider.dart';
import '../../providers/product_provider.dart';
import '../order/order_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
      // _fetchCategories();
    });
  }

  Future<void> _fetchCategories() async {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    await Future.wait([
      categoryProvider.fetchCategories(),
    ]);
  }

  Future<void> _fetchData() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    await Future.wait([
      productProvider.fetchProducts(),
      customerProvider.fetchCustomers(),
      categoryProvider.fetchCategories(),
    ]);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => OrderScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
