import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/search_text_provider.dart';

class SearchBar extends ConsumerWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController searchController = TextEditingController();

    return TextField(
      controller: searchController,
      onChanged: (value) {
        // Cập nhật giá trị searchTextProvider khi người dùng nhập văn bản
        ref.read(searchTextProvider.notifier).state = value;
      },
      decoration: const InputDecoration(
          hintText: 'Search...', suffixIcon: Icon(Icons.search)),
    );
  }
}
