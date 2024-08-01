import 'package:flutter/material.dart';
import 'package:toros_dart/models/bull.dart';
import 'package:toros_dart/csv/excel_service.dart';

class BullProvider with ChangeNotifier {
  List<Bull> _bulls = [];
  List<Bull> get bulls => _bulls;

  final ExcelService _excelService = ExcelService();

  Future<void> loadBulls(String filePath) async {
    List<Map<String, dynamic>> data = await _excelService.readExcel(filePath);
    _bulls = data.map((json) => Bull.fromJson(json)).toList();
    notifyListeners();
  }

  Bull getBullById(String id) {
    return _bulls.firstWhere(
      (bull) => bull.id == id,
      orElse: () => emptyBull,
    );
  }
}
