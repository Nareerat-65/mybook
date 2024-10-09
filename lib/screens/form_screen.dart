import 'package:mybook/main.dart';
import 'package:mybook/models/transactions.dart';
import 'package:mybook/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mybook/provider/transaction_provider.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final categoryController = TextEditingController();
  final authorController = TextEditingController();
 

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        appBar: AppBar(
          title: const Text('เพิ่มหนังสือของคุณ'),
        ),
        body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ชื่อหนังสือ',
                      border: OutlineInputBorder(),
                    ),
                    autofocus: false,
                    controller: titleController,
                    validator: (String? str) {
                      if (str!.isEmpty) {
                        return 'กรุณากรอกข้อมูล';
                      }
                    },
                  ),
                  const SizedBox(height:16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ประเภท',
                      border: OutlineInputBorder(),
                    ),
                    autofocus: false,
                    controller: categoryController,
                    validator: (String? str) {
                      if (str!.isEmpty) {
                        return 'กรุณากรอกข้อมูล';
                      }
                    },
                  ),
                  const SizedBox(height:16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ผู้แต่ง',
                      border: OutlineInputBorder(),
                    ),
                    autofocus: false,
                    controller: authorController,
                    validator: (String? str) {
                      if (str!.isEmpty) {
                        return 'กรุณากรอกข้อมูล';
                      }
                    },
                  ),
                  const SizedBox(height:16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'จำนวนเงิน',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    validator: (String? input) {
                      try {
                        double amount = double.parse(input!);
                        if (amount < 0) {
                          return 'กรุณากรอกข้อมูลมากกว่า 0';
                        }
                      } catch (e) {
                        return 'กรุณากรอกข้อมูลเป็นตัวเลข';
                      }
                    },
                  ),
                  const SizedBox(height:16.0),
                  TextButton(
                      child: const Text('บันทึก'),
                      onPressed: () {
                            if (formKey.currentState!.validate())
                              {
                                // create transaction data object
                                var statement = Transactions(
                                    keyID: null,
                                    title: titleController.text,
                                    amount: double.parse(amountController.text),
                                    category: categoryController.text,
                                    author: authorController.text,
                                    
                                    );
                              
                                // add transaction data object to provider
                                var provider = Provider.of<TransactionProvider>(context, listen: false);
                                
                                provider.addTransaction(statement);
              
                                Navigator.push(context, MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context){
                                    return MyHomePage();
                                  }
                                ));
                              }
                          })
                ],
              ),
            )));
  }
}