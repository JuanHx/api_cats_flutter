import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdownItem {
  final String id;
  final String name;

  CustomDropdownItem({required this.id, required this.name});
}

class CustomDropdown extends StatefulWidget {
  final List<CustomDropdownItem> items;
  final String? initialSelection;
  final void Function(CustomDropdownItem?)? onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    this.initialSelection,
    this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  CustomDropdownItem? _selectedItem;

  @override
  void initState() {
    super.initState();
    try {
      _selectedItem = widget.items.firstWhere(
        (item) => item.id == widget.initialSelection,
      );
    } catch (_) {
      _selectedItem = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 164, 145, 228), width: 1),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<CustomDropdownItem>(
          value: _selectedItem,
          isExpanded: true,
          icon: const Icon(Icons.expand_more, color: Color(0xFF7760C0)),
          hint: Text(
            "Select a breed",
            style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7760C0),
          ),
          ),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7760C0),
          ),
          dropdownColor: Colors.white,
          items: widget.items.map((item) {
            return DropdownMenuItem(value: item, child: Text(item.name));
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedItem = value;
            });
            widget.onChanged?.call(value);
          },
        ),
      ),
    );
  }
}
