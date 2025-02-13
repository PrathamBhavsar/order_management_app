import 'package:flutter/material.dart';

import '../../../../core/extensions/app_paddings.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.selectedItem,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black38,
            ),
          ),
          8.hGap,
          DropdownButtonFormField<T>(
            value: selectedItem,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            items: items
                .map((item) => DropdownMenuItem<T>(
                      value: item,
                      child: Text(itemLabel(item)),
                    ))
                .toList(),
            onChanged: onChanged,
          ),
        ],
      );
}
