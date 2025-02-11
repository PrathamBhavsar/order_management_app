import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/customer_provider.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Customers")),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.customers.length,
              itemBuilder: (context, index) {
                final customer = provider.customers[index];
                return ListTile(
                  title: Text(customer.name),
                  subtitle: Text(customer.email),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.fetchCustomers,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
