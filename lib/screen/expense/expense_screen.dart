import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../transaction/controller/transaction_controller.dart';
import '../utils/dbhelper.dart';


class expensescreen extends StatefulWidget {
  const expensescreen({Key? key}) : super(key: key);

  @override
  State<expensescreen> createState() => _expensescreenState();
}

class _expensescreenState extends State<expensescreen> {
  Transactioncontroller transactioncontroller =
  Get.put(Transactioncontroller());

  TextEditingController txtcate = TextEditingController();
  TextEditingController txtamount = TextEditingController();
  TextEditingController txtnote = TextEditingController();
  TextEditingController txtpaytype = TextEditingController();
  TextEditingController txtstatus = TextEditingController();
  TextEditingController txtdate = TextEditingController();
  TextEditingController txttime = TextEditingController(
      text: "${TimeOfDay
          .now()
          .hour}:${TimeOfDay
          .now()
          .minute}");

  @override
  void initState() {
    // TODO: implement initState
    Dbhelper dbhelper = Dbhelper();
    dbhelper.checkdb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    txtdate = TextEditingController(
        text:
        '${transactioncontroller.current.value.day}/${transactioncontroller
            .current.value.month}/${transactioncontroller.current.value.year}');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Expense"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: txtcate,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      label: Text("Category"),
                      fillColor: Colors.blue),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: txtamount,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      label: Text("Amount"),
                      fillColor: Colors.blue),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: txtnote,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      label: Text("Note"),
                      fillColor: Colors.blue),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(() =>
                    Container(
                      height: 60,
                      width: 393,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.blue),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(items: transactioncontroller
                            .paytype
                            .map(
                              (element) =>
                              DropdownMenuItem(
                                  child: Text(element), value: element),
                        )
                            .toList(),
                          onChanged: (value) {
                            transactioncontroller.selectpay.value = value!;
                          },
                          value: transactioncontroller.selectpay.value,
                        ),
                      ),
                    ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: 393,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() =>
                            Text("${transactioncontroller.current.value.day}/${transactioncontroller
                                .current.value.month}/${transactioncontroller.current.value.year}"),
                        ),
                      ),

                      IconButton(onPressed: () async {
                        transactioncontroller.current.value =
                        (await showDatePicker(context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2030)))!;
                      }, icon: Icon(Icons.calendar_month))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: txttime,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: DateTime.now().hour,
                                    minute: DateTime.now().minute));
                          },
                          icon: Icon(Icons.access_time_rounded)),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),

                      fillColor: Colors.blue),
                ),
                SizedBox(
                  height: 80,
                ),
                Align(alignment: Alignment.bottomCenter, child: addButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addButton() {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                var a = transactioncontroller.selectcategory.value;
                Dbhelper dbhelper = Dbhelper();
                dbhelper.insertdata(
                    category: a,
                    amount: txtamount.text,
                    status: '0',
                    notes: txtnote.text,
                    date: txtdate.text,
                    time: txttime.text,
                    paytype: txtpaytype.text);
                print(dbhelper.database);
                int i = 0;
                for (i = 0;
                i < transactioncontroller.transectionlist.length;
                i++) {
                  int status = int.parse(
                      transactioncontroller.transectionlist[i]['status']);
                  if (status == 0) {
                    int amount = int.parse(
                        transactioncontroller.transectionlist[i]['amount']);
                    transactioncontroller.total.value =
                        transactioncontroller.total.value - amount;
                    transactioncontroller.expense.value =
                        transactioncontroller.expense.value + amount;
                  }
                }
                Get.back();
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 50,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: Text('save',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sum() {
    int i = 0;
    for (i = 0; i < transactioncontroller.transectionlist.length; i++) {
      int status = int.parse(
          transactioncontroller.transectionlist[i]['status']);
      if (status == 1) {
        int amount = int.parse(
            transactioncontroller.transectionlist[i]['amount']);
        transactioncontroller.total.value =
            transactioncontroller.total.value + amount;
        transactioncontroller.income.value =
            transactioncontroller.income.value + amount;

        print("$amount");
      }
    }
  }

}
