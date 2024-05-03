import 'package:flutter/material.dart';

class DependentDropdownPage extends StatefulWidget {
  final Map<String, List<String>> categoryMap;
  final String? selectedCategory;
  final String? selectedSubcategory;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onSubcategoryChanged;
  final String hint1;
  final String hint2;
  final String firstbox;
  final String Secbox;

  const DependentDropdownPage({
    Key? key,
    required this.categoryMap,
    required this.selectedCategory,
    required this.selectedSubcategory,
    required this.onCategoryChanged,
    required this.onSubcategoryChanged,
    required this.hint1,
    required this.hint2,
    required this.firstbox,
    required this.Secbox,
  }) : super(key: key);

  @override
  _DependentDropdownPageState createState() => _DependentDropdownPageState();
}

class _DependentDropdownPageState extends State<DependentDropdownPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.firstbox,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF111236)),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide:
                  BorderSide(color: const Color.fromARGB(255, 184, 184, 184)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          hint: Text(widget.hint1),
          style: TextStyle(fontSize: 14, color: Colors.black),
          value: widget.selectedCategory,
          items: widget.categoryMap.keys
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
          onChanged: widget.onCategoryChanged,
        ),
        SizedBox(height: 20),
        Text(
          widget.Secbox,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF111236)),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide:
                  BorderSide(color: const Color.fromARGB(255, 184, 184, 184)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          hint: Text(widget.hint2),
          style: TextStyle(fontSize: 14, color: Colors.black),
          value: widget.selectedSubcategory,
          items: widget.selectedCategory != null
              ? widget.categoryMap[widget.selectedCategory!]!
                  .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList()
              : [],
          onChanged: widget.onSubcategoryChanged,
        ),
      ],
    );
  }
}
