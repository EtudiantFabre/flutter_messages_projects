import 'package:flutter/material.dart';
import 'package:flutter_message_project/widgets/email_widget.dart';
import 'custom_search_bar.dart';
import '../models/models.dart';
import '../models/data.dart' as data;

class EmailListView extends StatelessWidget {
  const EmailListView({
    super.key,
    this.selectedIndex,
    this.onSelected,
    required this.currentUser,
  });

  final int? selectedIndex;
  final ValueChanged<int>? onSelected;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: [
          const SizedBox(height: 8),
          CustomSearchBar(currentUser: currentUser),
          const SizedBox(
            height: 8,
          ),
          ...List.generate(data.emails.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: EmailWidget(
                email: data.emails[index],
                onSelected: onSelected != null
                    ? () {
                        onSelected!(index);
                      }
                    : null,
                isSelected: selectedIndex == index,
              ),
            );
          }),
        ],
      ),
    );
  }
}
