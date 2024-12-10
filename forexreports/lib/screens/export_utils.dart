import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

class ExportUtils {
  // Export all reports to CSV
  static Future<File> exportReportsToCSV() async {
    // Replace this mock data with actual report data
    final List<List<String>> data = [
      ['Cliente', 'Efectivo', 'Pesos', 'TC', 'Dolares'],
      ['Cliente 1', '1000', '20000', '20', '1000'],
      ['Cliente 2', '500', '10000', '20', '500']
    ];

    final csvData = const ListToCsvConverter().convert(data);

    // Save the file to the device
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/reports.csv';
    final file = File(path);

    await file.writeAsString(csvData);
    print('CSV saved to $path');
    return file;
  }

  // Export all reports to Excel
  static Future<File> exportReportsToExcel() async {
    // Replace this mock data with actual report data
    final List<List<String>> data = [
      ['Cliente', 'Efectivo', 'Pesos', 'TC', 'Dolares'],
      ['Cliente 1', '1000', '20000', '20', '1000'],
      ['Cliente 2', '500', '10000', '20', '500']
    ];

    // Save the file to the device (placeholder, replace with an Excel library like `excel`)
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/reports.xlsx';
    final file = File(path);

    // Placeholder logic
    await file.writeAsString('Excel placeholder data');
    print('Excel saved to $path');
    return file;
  }
}
