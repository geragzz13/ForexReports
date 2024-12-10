// pesos_report_form.dart

import 'package:flutter/material.dart';

class PesosReportForm extends StatefulWidget {
  const PesosReportForm({super.key});

  @override
  State<PesosReportForm> createState() => _PesosReportFormState();
}

class _PesosReportFormState extends State<PesosReportForm> {
  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _efectivoController = TextEditingController();
  final TextEditingController _bancosController = TextEditingController();
  final TextEditingController _tcController = TextEditingController();
  final TextEditingController _totalPesosController = TextEditingController();

  void _saveReport() {
    final String cliente = _clienteController.text.trim();
    final String efectivo = _efectivoController.text.trim();
    final String bancos = _bancosController.text.trim();
    final String tc = _tcController.text.trim();
    final String totalPesos = _totalPesosController.text.trim();
    final DateTime fechaHora = DateTime.now();

    if (cliente.isEmpty ||
        efectivo.isEmpty ||
        bancos.isEmpty ||
        tc.isEmpty ||
        totalPesos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos.')),
      );
      return;
    }

    // Here you would save the data to the database.
    print('Saving Pesos Report:');
    print('Cliente: $cliente, Efectivo: $efectivo, Bancos: $bancos');
    print(
        'Fecha: ${fechaHora.toIso8601String()}, TC: $tc, Total Pesos: $totalPesos');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reporte de Pesos guardado con éxito.')),
    );

    // Clear form fields after saving
    _clienteController.clear();
    _efectivoController.clear();
    _bancosController.clear();
    _tcController.clear();
    _totalPesosController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Reporte de Pesos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _clienteController,
                decoration: const InputDecoration(labelText: 'Cliente'),
              ),
              TextField(
                controller: _efectivoController,
                decoration: const InputDecoration(labelText: 'Efectivo'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _bancosController,
                decoration: const InputDecoration(labelText: 'Bancos'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _tcController,
                decoration:
                    const InputDecoration(labelText: 'TC (Tipo de Cambio)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _totalPesosController,
                decoration: const InputDecoration(labelText: 'Total Pesos'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveReport,
                child: const Text('Guardar Reporte'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
