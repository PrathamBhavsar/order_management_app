import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/customer_provider.dart';
import 'domain/usecases/remote/remote_customer_usecases.dart';
import 'data/repositories/customer_repository.dart';
import 'presentation/screens/customer_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CustomerProvider(
              GetCustomersUseCase(CustomerRepository()),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: CustomerScreen(),
        ),
      );
}
