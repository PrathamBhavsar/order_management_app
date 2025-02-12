import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/constants.dart';
import 'data/repositories/category_repository.dart';
import 'data/repositories/product_repository.dart';
import 'domain/use_cases/local/local_category_use_cases.dart';
import 'domain/use_cases/local/local_customer_use_cases.dart';
import 'domain/use_cases/local/local_product_use_cases.dart';
import 'domain/use_cases/remote/remote_category_use_cases.dart';
import 'domain/use_cases/remote/remote_product_use_cases.dart';
import 'presentation/providers/category_provider.dart';
import 'presentation/providers/customer_provider.dart';
import 'domain/use_cases/remote/remote_customer_use_cases.dart';
import 'data/repositories/customer_repository.dart';
import 'presentation/providers/order_provider.dart';
import 'presentation/providers/product_provider.dart';
import 'presentation/screens/order_details_screen.dart';
import 'presentation/screens/signature_screen.dart';
import 'presentation/screens/splash/splash_screen.dart';

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
                GetLocalCustomersUseCase(
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
            ChangeNotifierProvider(
              create: (_) => CategoryProvider(
                GetRemoteCategoriesUseCase(
                  CategoryRepository(),
                ),
                GetLocalCategoriesUseCase(
                  CategoryRepository(),
                ),
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => OrderProvider(),
            ),
          ]),
        ],
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
            ),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.primary,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            inputDecorationTheme:
                InputDecorationTheme(border: UnderlineInputBorder()),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: SignatureScreen(),
        ),
      );
}
