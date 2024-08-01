import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:excel/excel.dart';

class ExcelService {
  Future<List<Map<String, dynamic>>> readExcel(String filePath) async {
    ByteData data = await rootBundle.load(filePath);
    Uint8List bytes = data.buffer.asUint8List();
    var excel = Excel.decodeBytes(bytes);

    List<Map<String, dynamic>> dataList = [];

    for (var table in excel.tables.keys) {
      var sheet = excel.tables[table];

      if (sheet != null && sheet.rows.isNotEmpty) {
        var headers = sheet.rows.first;

        for (var row in sheet.rows.skip(1)) {
          Map<String, dynamic> rowData = {};
          for (int i = 0; i < headers.length; i++) {
            String header = headers[i]?.value.toString() ?? 'Column $i';
            rowData[header] = row[i]?.value;
          }
          dataList.add(rowData);
        }
      }
    }
    return dataList;
  }
}
