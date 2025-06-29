import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/task_service.dart';
import '../services/auth_service.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import '../widgets/task_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  TaskStatus? _statusFilter;
  TaskPriority? _priorityFilter;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Load mock data for demo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskService>(context, listen: false).loadMockData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskService = Provider.of<TaskService>(context);
    final auth = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tasks"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => auth.logout(),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "All"),
            Tab(text: "Open"),
            Tab(text: "Completed"),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search and Filter Bar
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search tasks...",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              taskService.setSearchQuery('');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) => taskService.setSearchQuery(value),
                ),
                const SizedBox(height: 12),
                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Status Filter
                      FilterChip(
                        label: const Text("Open"),
                        selected: _statusFilter == TaskStatus.open,
                        onSelected: (selected) {
                          setState(() {
                            _statusFilter = selected ? TaskStatus.open : null;
                          });
                          taskService.setStatusFilter(_statusFilter);
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text("Completed"),
                        selected: _statusFilter == TaskStatus.completed,
                        onSelected: (selected) {
                          setState(() {
                            _statusFilter = selected ? TaskStatus.completed : null;
                          });
                          taskService.setStatusFilter(_statusFilter);
                        },
                      ),
                      const SizedBox(width: 8),
                      // Priority Filters
                      FilterChip(
                        label: const Text("High"),
                        selected: _priorityFilter == TaskPriority.high,
                        onSelected: (selected) {
                          setState(() {
                            _priorityFilter = selected ? TaskPriority.high : null;
                          });
                          taskService.setPriorityFilter(_priorityFilter);
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text("Medium"),
                        selected: _priorityFilter == TaskPriority.medium,
                        onSelected: (selected) {
                          setState(() {
                            _priorityFilter = selected ? TaskPriority.medium : null;
                          });
                          taskService.setPriorityFilter(_priorityFilter);
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text("Low"),
                        selected: _priorityFilter == TaskPriority.low,
                        onSelected: (selected) {
                          setState(() {
                            _priorityFilter = selected ? TaskPriority.low : null;
                          });
                          taskService.setPriorityFilter(_priorityFilter);
                        },
                      ),
                      const SizedBox(width: 8),
                      // Clear Filters
                      if (_statusFilter != null || _priorityFilter != null)
                        FilterChip(
                          label: const Text("Clear"),
                          onSelected: (_) {
                            setState(() {
                              _statusFilter = null;
                              _priorityFilter = null;
                            });
                            taskService.clearFilters();
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Task List
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // All Tasks Tab
                _buildTaskList(taskService.filteredTasks),
                // Open Tasks Tab
                _buildTaskList(taskService.openTasks),
                // Completed Tasks Tab
                _buildTaskList(taskService.completedTasks),
              ],
            ),
          ),
          // Project by Vignesh K footer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.grey.shade100,
            child: Text(
              'App by Vignesh K',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const TaskForm(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Task"),
      ),
    );
  }

  Widget _buildTaskList(List<Task> tasks) {
    debugPrint('Building task list with ${tasks.length} tasks');
    
    if (tasks.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        debugPrint('Refreshing task list...');
        // Simulate refresh
        await Future.delayed(const Duration(milliseconds: 500));
        // In a real app, you would refresh data from the server
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 80), // Space for FAB
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          debugPrint('Building task tile for: ${task.title}');
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: TaskTile(
              key: ValueKey(task.id),
              task: task,
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            "No tasks found",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Create your first task to get started!",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => const TaskForm(),
            ),
            icon: const Icon(Icons.add),
            label: const Text("Add Your First Task"),
          ),
        ],
      ),
    );
  }
}
