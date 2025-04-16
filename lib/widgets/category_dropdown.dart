// ignore_for_file: must_be_immutable

import 'package:finance_management/utils/icons_list.dart';
import 'package:flutter/material.dart';

class CategoryDropDown extends StatelessWidget {
  CategoryDropDown({super.key, this.cattype, required this.onChanged});

  final String? cattype;
  final ValueChanged<String?> onChanged;
  var appIcons = AppIcons();

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Colors.black,
      value: cattype,
      isExpanded: true,
      hint: const Text('Select Category'),
      items: appIcons.homeExpensesCategories
          .map((e) => DropdownMenuItem<String>(
              value: e['name'],
              child: Row(
                children: [
                  Icon(
                    e['icon'],
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    e['name'],
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              )))
          .toList(),
      onChanged: onChanged,
    );
  }
}
