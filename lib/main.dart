import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:income_expense/screen/expense/expense_screen.dart';
import 'package:income_expense/screen/home/home_screen.dart';
import 'package:income_expense/screen/income/income_screen.dart';
import 'package:income_expense/screen/transaction/view/transaction_screen.dart';

void main()
{
  runApp(
      GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: [
            GetPage(name: '/', page: () => Homescreen()),
            GetPage(name: '/income', page: () => incomescreen()),
            GetPage(name: '/expense', page: () => expensescreen()),
            GetPage(name: '/transaction', page: () => transectionscreen()),
          ]
      )
  );
}