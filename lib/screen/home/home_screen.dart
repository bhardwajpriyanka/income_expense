import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../transaction/controller/transaction_controller.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Transactioncontroller controller = Get.put(Transactioncontroller());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(" Income Expense"),
        ),
        body: Column(
          children: [
            totalBalanceBox(),
            addButton(),
            incomeExpenseBox(),


          ],
        ),
      ),
    );
  }
  Widget addButton()
  {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Get.toNamed('/income');
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 60,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text('Income',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,letterSpacing: 2)),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Get.toNamed('/expense');
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 60,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text('Expense',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,letterSpacing: 2)),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                controller.readtransection();
                Get.toNamed('/transaction');
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 60,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text('Transaction',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,letterSpacing: 2)),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget incomeExpenseBox()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(10),
            height: 60,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.blueGrey  ,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Income',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500)),
                SizedBox(height: 10,),
                Obx(() =>  Text('\$ ${controller.income.value}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600))),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(10),
            height: 60,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Total Expense',style: TextStyle(color:Colors.white
                    ,fontWeight: FontWeight.w500)),
                SizedBox(height: 10,),
                Obx(() =>  Text('\$ ${controller.expense.value}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600))),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget totalBalanceBox()
  {
    return Container(
      margin: EdgeInsets.all(10),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Total Balance',style: TextStyle(color: Colors.white,letterSpacing: 1,fontSize: 22,)),

          Obx(() => Text('\$ ${controller.total.value}/-',style: TextStyle(color: Colors.white,letterSpacing: 2,fontSize: 22,fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

}