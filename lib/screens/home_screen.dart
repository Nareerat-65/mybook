import 'package:mybook/provider/transaction_provider.dart';
import 'package:mybook/screens/edit_screen.dart';
import 'package:mybook/screens/form_screen.dart'; // เพิ่ม import ของ FormScreen

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("MyBook"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          if (provider.transactions.isEmpty) {
            return const Center(
              child: Text('ไม่มีรายการ'),
            );
          } else {
            return ListView.builder(
              itemCount: provider.transactions.length,
              itemBuilder: (context, index) {
                var statement = provider.transactions[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: ListTile(
                    title: Text(statement.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ประเภท : ${statement.category}'),
                        Text('ผู้แต่ง : ${statement.author}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min, 
                      children: [
                        Text(
                          '฿ ${statement.amount}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 106, 177, 106),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            provider.deleteTransaction(statement.keyID);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return EditScreen(statement: statement);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormScreen()),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}