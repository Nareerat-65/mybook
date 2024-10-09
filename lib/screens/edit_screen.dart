import 'package:mybook/main.dart';
import 'package:mybook/models/transactions.dart';
import 'package:mybook/provider/transaction_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  Transactions statement;

  EditScreen({super.key,required this.statement});
   

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var amountController = TextEditingController();
  var categoryController = TextEditingController();
  var authorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.statement.title;
    amountController.text = widget.statement.amount.toString();
    categoryController.text = widget.statement.category;
    authorController.text = widget.statement.author;
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('แก้ไขข้อมูล'),
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
                    child: const Text('ยืนยันการแก้ไข'),
                    onPressed: () {
                          if (formKey.currentState!.validate())
                            {
                              // create transaction data object
                              var statement = Transactions(
                                  keyID: widget.statement.keyID,
                                  title: titleController.text,
                                  amount: double.parse(amountController.text),
                                  category: categoryController.text,
                                  author: authorController.text,
                                  
                                  );
                            
                              // add transaction data object to provider
                              var provider = Provider.of<TransactionProvider>(context, listen: false);
                              
                              provider.updateTransaction(statement);

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