import 'package:get/get.dart';

import '../../utils/dbhelper.dart';

class Transactioncontroller extends GetxController {
  RxString? dropDropDown;
  RxList<Map> transectionlist = <Map>[].obs;
  RxInt total = 0.obs;
  RxInt income = 0.obs;
  RxInt expense = 0.obs;

  Future<void> readtransection() async {
    Dbhelper dbhelper = Dbhelper();
    transectionlist.value = await dbhelper.readdata();
  }

  Future<void> readIncomeExpense(int status) async {
    Dbhelper dbhelper = Dbhelper();
    transectionlist.value = await dbhelper.incomeexpensefilter(s1: status);
  }

  Future<void> readCategory() async {
    Dbhelper dbhelper = Dbhelper();
    transectionlist.value = await dbhelper.decendingfilter();
  }
  Future<void> readassending() async {
    Dbhelper dbhelper = Dbhelper();
    transectionlist.value = await dbhelper.assending();
  }

  void deletetransaction(int id) {
    Dbhelper dbhelper = Dbhelper();
    dbhelper.deletedata(id: id);
    readtransection();
  }

  void updatetransaction(String category,
      String amount,
      int status,
      String notes,
      String date,
      String time,
      String paytype, int id) {
    Dbhelper dbhelper = Dbhelper();
    dbhelper.updatedata(category: category,
        amount: amount,
        status: status,
        notes: notes,
        date: date,
        time: time,
        paytype: paytype,
        id: id);
    readtransection();
  }
  Rx<DateTime> current = DateTime.now().obs;
  Rx<DateTime> date=DateTime.now().obs;
  Rx<DateTime> Date=DateTime.now().obs;

  RxList<String> category=<String>[
    "Business",
    "Bonus",
    "Allowance",
    "Investment Income",
    "Pension",
    "Salary",
    "Education",
    "Company",
    "Railway",
    "Shop",
    "Rent",
    "Food",
    "traveling",
    "Tv",
    "other Category",
  ].obs;
  var selectcategory="Category".obs;
  RxList<String> paytype=<String>[
    "Online",
    "Cash",
    "Bank",
  ].obs;
  var selectpay="Cash".obs;

}