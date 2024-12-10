// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'export_utils.dart'; // Ensure this utility is implemented for exporting

class ReportsHubScreen extends StatefulWidget {
  const ReportsHubScreen({super.key});

  @override
  _ReportsHubScreenState createState() => _ReportsHubScreenState();
}

class _ReportsHubScreenState extends State<ReportsHubScreen> {
  final List<Map<String, dynamic>> _reports = [
    {'id': 1, 'type': 'Pesos', 'content': 'Reporte en Pesos'},
    {'id': 2, 'type': 'Dollars', 'content': 'Reporte en Dólares'},
    {'id': 3, 'type': 'Weekly', 'content': 'Reporte Semanal'},
    {'id': 4, 'type': 'Monthly', 'content': 'Reporte Mensual'},
  ]; // Example reports

  final Set<int> _selectedReportIds = {}; // Store selected report IDs

  // Toggle selection for a report
  void _toggleReportSelection(int id) {
    setState(() {
      if (_selectedReportIds.contains(id)) {
        _selectedReportIds.remove(id);
      } else {
        _selectedReportIds.add(id);
      }
    });
  }

  // Export selected reports
  Future<void> _exportSelectedReports() async {
    final selectedReports = _reports
        .where((report) => _selectedReportIds.contains(report['id']))
        .toList();
    if (selectedReports.isNotEmpty) {
      await ExportUtils.exportReportsToCSV(selectedReports);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Selected reports exported successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No reports selected to export.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports Hub'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed:
                _exportSelectedReports, // Trigger export for selected reports
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: _reports.map((report) {
          final isSelected = _selectedReportIds.contains(report['id']);
          return CheckboxListTile(
            value: isSelected,
            title: Text(report['content']),
            subtitle: Text('Tipo: ${report['type']}'),
            onChanged: (_) => _toggleReportSelection(report['id']),
          );
        }).toList(),
      ),
    );
  }
}
