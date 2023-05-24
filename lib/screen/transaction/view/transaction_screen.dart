import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../utils/dbhelper.dart';
import '../controller/transaction_controller.dart';


class transectionscreen extends StatefulWidget {
  const transectionscreen({Key? key}) : super(key: key);

  @override
  State<transectionscreen> createState() => _transectionscreenState();
}

class _transectionscreenState extends State<transectionscreen> {
  Transactioncontroller controller = Get.put(Transactioncontroller());
  TextEditingController txtcate = TextEditingController();
  TextEditingController txtamount = TextEditingController();
  TextEditingController txtnote = TextEditingController();
  TextEditingController txtpaytype = TextEditingController();
  TextEditingController txtstatus = TextEditingController();
  TextEditingController txtdate = TextEditingController(
      text:
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
  TextEditingController txttime = TextEditingController(
      text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");
  Transactioncontroller transactioncontroller =
  Get.put(Transactioncontroller());

  @override
  void initState() {
    super.initState();
    controller.readtransection();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('All Transactions',
              style: TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        Get.defaultDialog(
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      transactioncontroller.readtransection();
                                      Get.back();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('All',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 1)),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      transactioncontroller
                                          .readIncomeExpense(1);
                                      Get.back();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Income',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 1)),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      transactioncontroller
                                          .readIncomeExpense(0);
                                      Get.back();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Expense',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 1)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.filter_list_alt,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ],
        ),
        body: Obx(
              () => ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => transactionBox(
              controller.transectionlist[index]['id'],
              controller.transectionlist[index]['category'],
              controller.transectionlist[index]['notes'],
              controller.transectionlist[index]['amount'],
              controller.transectionlist[index]['status'],
              index,
            ),
            itemCount: controller.transectionlist.length,
          ),
        ),
      ),
    );
  }

  Widget transactionBox(int id, String category, String notes, String amount,
      String status, int index) {
    int s1 = int.parse(status);
    return Container(
      height: 100,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: s1 == 1
            ? Border.all(color: Colors.green, width: 1)
            : Border.all(color: Colors.red, width: 1),
        //color: Colors.black12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('${id}',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 17)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$category',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                      letterSpacing: 1,
                      fontSize: 16)),
              SizedBox(
                height: 2,
              ),
              Text('$notes',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                      letterSpacing: 1,
                      fontSize: 13)),
            ],
          ),
          s1 == 1
              ? Text('\$ $amount',
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 10))
              : Text('\$ $amount',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                  fontSize: 10)),
          InkWell(
              onTap: () {
                txtcate = TextEditingController(
                    text: '${controller.transectionlist[index]['category']}');
                txtamount = TextEditingController(
                    text: '${controller.transectionlist[index]['amount']}');
                txtdate = TextEditingController(
                    text: '${controller.transectionlist[index]['date']}');
                txttime = TextEditingController(
                    text: '${controller.transectionlist[index]['time']}');
                txtpaytype = TextEditingController(
                    text: '${controller.transectionlist[index]['paytype']}');
                txtnote = TextEditingController(
                    text: '${controller.transectionlist[index]['notes']}');
                Get.defaultDialog(
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      TextField(
                           controller: txtcate,
                           decoration: InputDecoration(
                            border: OutlineInputBorder(),
                           label: Text("Category"),
                          fillColor: Colors.blue),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: txtamount,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Amount"),
                              fillColor: Colors.blue),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextField(
                          controller: txtnote,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Note"),
                              fillColor: Colors.blue),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Obx(() =>
                            Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.blueGrey),
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
                          height: 8,
                        ),
                        TextField(
                          controller: txtdate,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Date"),
                              fillColor: Colors.blue),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: txttime,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Time"),
                              fillColor: Colors.blue),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Dbhelper dbhelper = Dbhelper();
                                    int status = 1;
                                    String cate = txtcate.text;
                                    String amt = txtamount.text;
                                    String note = txtnote.text;
                                    String date = txtdate.text;
                                    String time = txttime.text;
                                    String paytype = txtpaytype.text;
                                    controller.updatetransaction(cate, amt,
                                        status, note, date, time, paytype, id);
                                    controller.readtransection();
                                    Get.back();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text('Income',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 2)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Dbhelper dbhelper = Dbhelper();
                                    int status = 0;
                                    String cate = txtcate.text;
                                    String amt = txtamount.text;
                                    String note = txtnote.text;
                                    String date = txtdate.text;
                                    String time = txttime.text;
                                    String paytype = txtpaytype.text;
                                    controller.updatetransaction(cate, amt,
                                        status, note, date, time, paytype, id);
                                    controller.readtransection();
                                    Get.back();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text('Expanse',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 2)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              child: Icon(Icons.edit, color: Colors.black)),
          InkWell(
              onTap: () {
                int id = controller.transectionlist[index]['id'];
                controller.deletetransaction(id);
                controller.readtransection();
              },
              child: Icon(Icons.delete, color: Colors.black)),
        ],
      ),
    );
  }
}

List filterList = [
  'all',
  'Expense',
  'Income',

];