import 'package:flutter_outfit/http/api_record.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordController extends GetxController {
  RecordController();

  var apiRecord = ApiRecord();

  var userId;

  _initData() async {
    // 获取用户ID
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');
    // 初始化日期列表
    await initDates();
    // 初始化浏览历史列表
    initRecords();
    update(["record"]);
  }

  var dates = [].obs;
  var records = [].obs;

  var dateIndex = 0.obs;

  var loading = true.obs;

  Future<void> initDates() async {
    loading.value = true;
    var result = await apiRecord.getDates({
      'userId': userId,
    });
    dates.value = result;
  }

  void initRecords() async {
    if (dates.isNotEmpty) {
      var result = await apiRecord.getRecords({
        'userId': userId,
        'date': dates[dateIndex.value],
      });
      records.value = result ?? [];
    }
    loading.value = false;
  }

  void onTap() {}

  void onDateItemTap(int index) {
    if (dateIndex.value == index) {
      return;
    }
    dateIndex.value = index;
    initRecords();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  String formatDate(String date) {
    // 将日期字符串解析为 DateTime 对象
    DateTime dateTime = DateFormat('yyyy/MM/dd').parse(date);

    // 格式化日期为 "dd/MM\nyyyy" 的形式
    return DateFormat('dd/MM\nyyyy').format(dateTime);
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
