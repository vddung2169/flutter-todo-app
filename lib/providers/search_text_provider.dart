import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a StateProvider to store the search text
final searchTextProvider = StateProvider<String>((ref) => '');
