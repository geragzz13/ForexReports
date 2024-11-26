import 'package:flutter/material.dart';

class ReportCreationScreen extends StatefulWidget {
  const ReportCreationScreen({super.key});

  @override
  State<ReportCreationScreen> createState() => _ReportCreationScreenState();
}

class _ReportCreationScreenState extends State<ReportCreationScreen> {
  final TextEditingController _efectivoController = TextEditingController();
  final TextEditingController _pesosController = TextEditingController();
  final TextEditingController _tcController = TextEditingController();
  final TextEditingController _dolaresController = TextEditingController();

  List<Map<String, String>> _reportes = []; // List to store reports

  String? _selectedClient;
  final List<String> _clientes = ['Cliente 1', 'Cliente 2', 'Cliente 3'];

  // This function updates Pesos or Dólares dynamically based on the Tipo de Cambio
  void _updateCalculation() {
    if (_efectivoController.text.isEmpty || _tcController.text.isEmpty) return;

    final efectivo = double.tryParse(_efectivoController.text) ?? 0;
    final tc = double.tryParse(_tcController.text) ?? 1;

    // Dynamically calculate Pesos or Dólares based on user input
    if (_pesosController.text.isEmpty && _dolaresController.text.isNotEmpty) {
      final dolares = double.tryParse(_dolaresController.text) ?? 0;
      _pesosController.text = (dolares * tc).toStringAsFixed(2);
    } else if (_dolaresController.text.isEmpty &&
        _pesosController.text.isNotEmpty) {
      final pesos = double.tryParse(_pesosController.text) ?? 0;
      _dolaresController.text = (pesos / tc).toStringAsFixed(2);
    }
  }

  void _addReporte() {
    if (_selectedClient != null &&
        _efectivoController.text.isNotEmpty &&
        _pesosController.text.isNotEmpty &&
        _tcController.text.isNotEmpty &&
        _dolaresController.text.isNotEmpty) {
      setState(() {
        _reportes.add({
          'cliente': _selectedClient!,
          'efectivo': _efectivoController.text,
          'pesos': _pesosController.text,
          'tc': _tcController.text,
          'dolares': _dolaresController.text,
        });
        _clearForm();
      });
    }
  }

  void _clearForm() {
    _efectivoController.clear();
    _pesosController.clear();
    _tcController.clear();
    _dolaresController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Reporte'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: _selectedClient,
              hint: const Text('Seleccione un cliente'),
              isExpanded: true,
              items: _clientes.map((String cliente) {
                return DropdownMenuItem<String>(
                  value: cliente,
                  child: Text(cliente),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedClient = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  Table(
                    border: TableBorder.all(color: Colors.grey),
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(color: Colors.blueAccent),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Efectivo',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Pesos',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('TC (Tipo de Cambio)',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Dólares',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                      ..._reportes
                          .where((reporte) =>
                              reporte['cliente'] == _selectedClient)
                          .map((reporte) {
                        return TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(reporte['efectivo']!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(reporte['pesos']!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(reporte['tc']!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(reporte['dolares']!),
                          ),
                        ]);
                      }).toList()
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Agregar nuevo reporte:',
                style: TextStyle(fontSize: 16)),
            TextField(
              controller: _efectivoController,
              decoration: const InputDecoration(labelText: 'Efectivo'),
              keyboardType: TextInputType.number,
              onChanged: (value) => _updateCalculation(),
            ),
            TextField(
              controller: _pesosController,
              decoration: const InputDecoration(labelText: 'Pesos'),
              keyboardType: TextInputType.number,
              onChanged: (value) => _updateCalculation(),
            ),
            TextField(
              controller: _tcController,
              decoration:
                  const InputDecoration(labelText: 'TC (Tipo de Cambio)'),
              keyboardType: TextInputType.number,
              onChanged: (value) => _updateCalculation(),
            ),
            TextField(
              controller: _dolaresController,
              decoration: const InputDecoration(labelText: 'Dólares'),
              keyboardType: TextInputType.number,
              onChanged: (value) => _updateCalculation(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addReporte,
              child: const Text('Guardar Reporte'),
            ),
          ],
        ),
      ),
    );
  }
}
