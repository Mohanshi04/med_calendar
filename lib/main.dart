import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MaterialApp(home: MedicationCalendar()));
}

class MedicationCalendar extends StatefulWidget {
  @override
  _MedicationCalendarState createState() => _MedicationCalendarState();
}

class _MedicationCalendarState extends State<MedicationCalendar> {
  Map<DateTime, int> _medicationData = {};
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    fetchMedicationData();
  }

  Future<void> fetchMedicationData() async {
    final url = Uri.parse('https://run.mocky.io/v3/6ae65a90-c196-427d-9b5f-e83345bec193');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> intakeList = jsonData['intake_history'];
      final DateFormat inputFormat = DateFormat('dd/MM/yyyy');

      final Map<DateTime, int> mappedData = {};

      for (var entry in intakeList) {
        DateTime parsedDate = inputFormat.parse(entry['date']);
        DateTime normalizedDate = DateTime.utc(parsedDate.year, parsedDate.month, parsedDate.day);
        mappedData[normalizedDate] = entry['dose'];
      }

      setState(() {
        _medicationData = mappedData;
      });
    } else {
      print("Failed to fetch data: ${response.statusCode}");
    }
  }

  Color _getDayColor(DateTime day) {
    final normalizedDay = DateTime.utc(day.year, day.month, day.day);
    final dosage = _medicationData[normalizedDay];

    if (dosage == 100) return Colors.green;
    if (dosage == 50) return Colors.yellow;
    if (dosage == 0) return Colors.red;
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Medication Calendar")),
      body: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime.utc(2024, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            final bgColor = _getDayColor(day);
            return Container(
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '${day.day}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
