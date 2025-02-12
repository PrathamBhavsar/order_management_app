import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/repositories/product_repository.dart';
import 'domain/usecases/local/local_product_usecases.dart';
import 'domain/usecases/remote/remote_product_usecases.dart';
import 'presentation/providers/customer_provider.dart';
import 'domain/usecases/remote/remote_customer_usecases.dart';
import 'data/repositories/customer_repository.dart';
import 'presentation/providers/product_provider.dart';
import 'presentation/screens/product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          MultiProvider(providers: [
            ChangeNotifierProvider(
              create: (_) => CustomerProvider(
                GetRemoteCustomersUseCase(
                  CustomerRepository(),
                ),
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => ProductProvider(
                GetRemoteProductsUseCase(
                  ProductRepository(),
                ),
                GetLocalProductsUseCase(
                  ProductRepository(),
                ),
              ),
            ),
          ])
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ProductScreen(),
        ),
      );
}
