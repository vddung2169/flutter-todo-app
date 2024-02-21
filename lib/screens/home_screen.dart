import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/config/routes/routes.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/screens/completed_appbar.dart';
import 'package:todo_app/screens/incompleted_appbar.dart';
import 'package:todo_app/screens/today_appbar.dart';
import 'package:todo_app/screens/upcomming_appbar.dart';
import 'package:todo_app/ultils/ultils.dart';
import 'package:todo_app/widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  // Add this variable to store the search query

  late TabController _tabController;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _currentTime = DateTime.now();
    // Update the current time every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: Material(
            color: context.colorScheme.surface,
            child: TabBar(
              indicatorColor: context.colorScheme.surface,
              controller: _tabController,
              tabs: const [
                Tab(
                  child: Text(
                    'Todo',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Tab(
                  child: Text(
                    'Today',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Tab(
                  child: Text(
                    'Up Comming',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Tab(
                  child: Text(
                    'Completed',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            InCompletedTask(),
            TodayTask(),
            UpCommingTask(),
            CompletedTask(),
          ],
        ),
        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => context.push(RouteLocation.createTask),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DisplayWhiteText(text: 'Add new task'),
                ),
              ),
              Text(
                  'Today is: ${DateFormat('yyyy-MM-dd – kk:mm').format(_currentTime)}'),
            ],
          ),
        ],
      ),
    );
  }
}
